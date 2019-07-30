//
//  BDBaseTableViewController.m
//
//  Created by 吴振振 on 2017/11/30.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "BDBaseTableViewController.h"
#import "BDPageNetwork.h"
@interface BDBaseTableViewController ()
@property (nonatomic, strong) BDPageNetwork *pageNet;
@end

@implementation BDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
}

#pragma mark - BDTableViewProtocol
-(void)bd_tableViewDefaut{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(void)bd_tableViewForFill{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
}

-(UITableViewStyle)tableViewStyle{
    return UITableViewStylePlain;
}

#pragma mark -  BDRefreshProtocol
/**
 mj_pageRefresh
 */
-(void)mj_pageRefresh{
    [self mj_pageRefreshForHeader];
    [self mj_pageRefreshForFooter];
}

-(void)mj_pageRefreshForHeader{
    [self.tableView bd_headerRefreshTarget:self.pageNet selecter:@selector(getFirstPage)];
}
-(void)mj_pageRefreshForFooter{
    [self.tableView bd_footerRefreshTarget:self.pageNet selecter:@selector(getNextPage)];
}

/**
 MJRefresh
 */
- (void)mj_refresh {
    [self mj_headerRefresh];
    [self mj_footerRefresh];
}

-(void)mj_headerRefresh{
    [self.tableView bd_headerRefreshTarget:self selecter:@selector(mj_headerRefreshAction)];
}

-(void)mj_footerRefresh{
    [self.tableView bd_footerRefreshTarget:self selecter:@selector(mj_footerRefreshAction)];
}

-(void)mj_headerRefreshAction{
    
}
-(void)mj_footerRefreshAction{
    
}

-(void)bd_beginLoadRequest{
    [self.tableView beginRefreshing];
}

-(void)bd_refreshData{
    [self.pageNet refreshParams:[self bd_params]];
}


#pragma mark - Net Config
-(NSString *)bd_pageUrl{
    return nil;
}
-(Class)bd_pageModelClass{
    return nil;
}
-(NSDictionary *)bd_params{
    return nil;
}
-(NSString *)bd_parsingKey{
    return nil;
}



#pragma mark - UITableViewDeletage

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}


#pragma mark - noInsetAdjustmentBehavior
-(void)bd_noInsetAdjustmentBehavior{
    if (@available(iOS 11.0, *)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout =  UIRectEdgeAll;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [BDUI bd_createTableViewWith:CGRectZero target:self style:[self tableViewStyle]];
        _tableView.separatorColor = BD_RGB_HEX(0xcccccc);
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _tableView;
}


- (BDPageNetwork *)pageNet {
    if (!_pageNet) {
        NSString *url      = [self bd_pageUrl];
        NSString *key      = [self bd_parsingKey];
        NSDictionary *para = [self bd_params];
        Class class        = [self bd_pageModelClass];
        
        if (para) {
            _pageNet = [[BDPageNetwork alloc] initWithJSONModelClass:class
                                                                  key:key
                                                              apiPath:url
                                                               params:para];
        }else{
            _pageNet = [[BDPageNetwork alloc] initWithJSONModelClass:class
                                                                  key:key
                                                              apiPath:url];
        }
        
        __weak typeof(self) wself = self;
        
        _pageNet.RefreshHandler = ^{
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                if (!strongSelf.dataArray) {
                    strongSelf.dataArray = [NSMutableArray array];
                } else {
                    [strongSelf.dataArray removeAllObjects];
                }
            }
        };
        _pageNet.NextPageHandler = ^(NSArray *results, BOOL isAllLoaded) {
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.dataArray addObjectsFromArray:results];
                if (isAllLoaded) {
                     [strongSelf.tableView endRefreshAllLoad:isAllLoaded];
                }else{
                    [strongSelf.tableView endRefresh];
                }
            }
        };
        
        _pageNet.AllLoadedHandler = ^{
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.tableView endRefreshAllLoad:YES];
            }
        };
        
        _pageNet.NetworkingErrorHandler = ^(NSError *error, NSString *message) {
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.tableView endRefresh];
            }
        };
    }
    return _pageNet;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
