//
//  BDChartWebViewController.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/24.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDChartWebViewController.h"
#import "AAChartKit.h"
#import "AppDelegate.h"
#import "UIDevice+TFDevice.h"
#import "BDBANet.h"
#import "BDDevice.h"
#import "WWGCDQueue.h"
#define ChartViewWidth  (SCREEN_W - 30)
#define ChartViewHeight SCALE_W(165)
#define SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] doubleValue]
@interface BDChartWebViewController ()<AAChartViewDidFinishLoadDelegate>
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAOptions    *aaOptions;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, copy) NSString *demandFlag;
@end

@implementation BDChartWebViewController

-(instancetype)initWithParams:(NSDictionary *)params{
    if (self = [super init]) {
        _params = params;
        _demandFlag = [params objectForKey:@"demandFlag"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =  UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self switchOrientation:YES];
    self.title = [self bd_navChartTitle];
    [self bd_createLeftBarButtonItemWithTitle:@"返回"];
    [self.view addSubview:self.aaChartView];
    CGFloat space = 10;
    if ([BDDevice bd_iPhonex]) {
        space = 40;
    }
    [self.aaChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(space);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(40);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    [self.aaChartView aa_drawChartWithOptions:self.aaOptions];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self bd_netLoadTrend];
}


#pragma mark - 数据请求
-(void)bd_netLoadTrend{
    WeakSelf(weakSelf);
    [self wz_showProgressHud];
    [BDBANet bd_netLoadFPTrendWithParams:self.params success:^(NSArray * _Nullable results) {
        [weakSelf wz_dismissHud];
        [weakSelf bd_refreshChartWithDatas:results];
    } failure:^(NSString * _Nullable message) {
        [weakSelf wz_dismissHud];
    }];
}

-(void)bd_refreshChartWithDatas:(NSArray *)datas{
    NSMutableArray *currs = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    for (BDFPTrendModel *item in datas) {
        if ([self bd_handle]) {
            [currs addObject:@(item.value/10000)];
        }else{
            [currs addObject:@(item.value)];
        }
        if ([self bd_typeColumn]) {
            NSString *title = [item.date stringByReplacingCharactersInRange:NSMakeRange(4, 0) withString:@"/"];
            [titles addObject:title];
        }else{
            NSString *title = [item.date substringFromIndex:4];
            [titles addObject:[title stringByReplacingCharactersInRange:NSMakeRange(2, 0) withString:@"/"]];
        }
    }
    
    AASeriesElement *seriesElement = AASeriesElement.new.nameSet(@"本周期").lineWidthSet(@1).dataSet(currs);
    //设置 AAChartView 的背景色是否为透明
    if (SYSTEM_VERSION < 10.0) {
        seriesElement.fillOpacity = @(0.2);
    }else{
        seriesElement.fillColor   = [self fillColor];
    }
    
    self.aaChartModel.series = @[seriesElement];
    self.aaChartModel.categories = titles ;//设置 X 轴坐标文字内容
    self.aaChartModel.xAxisLabelsFontSize = @10;
    [self.aaChartView aa_refreshChartWithOptions:self.aaOptions];
}

- (void)AAChartViewDidFinishLoad{
    
}
-(id)fillColor{
    return  @{
              @"linearGradient": @{
                      @"x1": @0,
                      @"y1": @1,
                      @"x2": @0,
                      @"y2": @0
                      },
              @"stops": @[@[@0,@"rgba(255,255,255,0.1)"],
                          @[@1,@"rgba(64,224,208,0.4)"]]
              };
}


-(void)bd_leftBarButtonItemAction:(UIBarButtonItem *)barButtonItem{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)switchOrientation:(BOOL)allowRotation{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = allowRotation;
    if (allowRotation) {
        //切换到横屏
        [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        //切换到竖屏
        [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    }
    
}

// MARK:状态栏的显示（横屏系统默认会隐藏的）
- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(BOOL)bd_typeColumn{
    return self.demandFlag && [self.demandFlag isEqualToString:@"monthactive"];
}

-(BOOL)bd_handle{
    NSArray *array = @[@"usernum",@"monthactive",@"musernum",@"inuser",@"minuser"];
    return [array containsObject:self.demandFlag];
}

-(NSString *)bd_navChartTitle{
    NSDictionary *dict = @{@"usernum":@"日活(万) - ",
                           @"monthactive":@"月均月活(万) - ",
                           @"musernum":@"月活(万) - ",
                           @"phonenum":@"号码获取率(%) - ",
                           @"flow":@"蜂窝流量(TB) - ",
                           @"wifi":@"蜂窝wifi流量(TB) - ",
                           @"inuser":@"会员在订(万) - ",
                           @"minuser":@"会员净增(万) - ",
                           };
    return [dict[self.demandFlag] stringByAppendingString:self.params[@"provName"]];
}

-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]initWithFrame:self.view.bounds];
        _aaChartView.isClearBackgroundColor = YES;
        _aaChartView.delegate = self;
        _aaChartView.scrollEnabled = YES;
        _aaChartView.bounces = NO;
    }
    return _aaChartView;
}

-(AAChartModel *)aaChartModel{
    if (!_aaChartModel) {
        _aaChartModel = AAChartModel.new
        .chartTypeSet([self bd_typeColumn] ? AAChartTypeColumn: AAChartTypeArea)//图表类型
        .titleSet(@"")//图表主标题
        .subtitleSet(@"")//图表副标题
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
        .colorsThemeSet(@[@"#0D7FF9",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
        .backgroundColorSet(@"#4b2b7f")
        .yAxisGridLineWidthSet(@1);//y轴横向分割线宽度为0(即是隐藏分割线)
        
        _aaChartModel.tooltipValueSuffixSet(@"");//设置浮动提示框单位后缀
        _aaChartModel.xAxisCrosshairWidth = @1;
        _aaChartModel.xAxisCrosshairColor = @"#cccccc";//浅石板灰准星线
        _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDash;
        
        _aaChartModel.markerSymbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:边缘白色
        _aaChartModel.markerSymbol = AAChartSymbolTypeCircle;
        _aaChartModel.markerRadius = @(2);
        _aaChartModel.yAxisAllowDecimals = NO;
        if ([self.demandFlag isEqualToString:@"phonenum"]) {
            _aaChartModel.tooltipValueSuffixSet(@"%");//设置浮动提示框单位后缀
        }
        _aaChartModel.legendEnabled = NO;
    }
    return _aaChartModel;
}

-(AAOptions *)aaOptions{
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:self.aaChartModel];
    aaOptions.tooltip.backgroundColor = @"#FFFFFF";
    aaOptions.yAxis.gridLineDashStyle = AALineDashSyleTypeLongDash;
    return aaOptions;
}

@end

