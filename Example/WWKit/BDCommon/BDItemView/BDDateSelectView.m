//
//  BDDateSelectView.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/29.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDDateSelectView.h"
#import "WWGCDQueue.h"
@interface BDDateSelectView()
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UILabel *beforeLabel;
@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UILabel *nextLabel;
@property (nonatomic, assign) BOOL nextEnble;

@end

@implementation BDDateSelectView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _maxDate        = [NSDate bd_yestodayDate];
        self.selectDate = [NSDate bd_yestodayDate];
        [self bd_initUI];
    }
    return self;
}

#pragma mark - UI
-(void)bd_initUI{
   
    [self addSubview:self.dateView];
    [self.dateView addSubview:self.beforeLabel];
    [self.dateView addSubview:self.selectLabel];
    [self.dateView addSubview:self.nextLabel];
    
    [self.beforeLabel blockClick:^{
        [self routerEvent:BDPreNextDayEventKey info:[self PreTime]];
    }];
    
    [self.selectLabel blockClick:^{
        [self routerEvent:BDPickDateEventKey info:nil];
    }];
    
    [self.nextLabel blockClick:^{
        if (self.nextEnble) {
            [self routerEvent:BDPreNextDayEventKey info:[self nextTime]];
        }
    }];
}

#pragma mark - getter setter
-(void)setSelectDate:(NSDate *)selectDate{
    _selectDate = selectDate;
    bd_async_globalQueue(^{
        NSString *s = [BDDateFormat bd_formatWithDate:self.selectDate withFormate:@"yyyyMMdd"];
        NSString *n = [BDDateFormat bd_formatWithDate:self.maxDate withFormate:@"yyyyMMdd"];
        NSString *dateText = [self selectDateString];
        bd_async_mainQueue(^{
            self.selectLabel.text = dateText;
            if (s.integerValue < n.integerValue) {
                self.nextEnble = YES;
                self.nextLabel.textColor = [UIColor orangeColor];
            }else {
                self.nextEnble = NO;
                self.nextLabel.textColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
            }
        });
    });
}

-(NSString *)PreTime{
    self.selectDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.selectDate];
    return [BDDateFormat bd_formatWithDate:self.selectDate withFormate:@"yyyyMMdd"];
}

-(NSString *)nextTime{
    self.selectDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:self.selectDate];
    return [BDDateFormat bd_formatWithDate:self.selectDate withFormate:@"yyyyMMdd"];
}

-(NSString *)selectDateString{
    return [BDDateFormat bd_formatWithDate:self.selectDate withFormate:@"yyyy.MM.dd"];
}


#pragma mark - 懒加载
-(UIView *)dateView{
    if (!_dateView) {
        _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 35)];
        _dateView.backgroundColor = BD_RGB_HEX(0xF5F5F5);
    }
    return _dateView;
}


-(UILabel *)beforeLabel{
    if (!_beforeLabel) {
        _beforeLabel = [BDUI bd_createLabelWithFrame:CGRectMake(10, 0, 80, 35)
                                                text:@"前一日"
                                           textColor:[UIColor bd_orangeColor]
                                                font:[UIFont systemFontOfSize:15]];
    }
    return _beforeLabel;
}

-(UILabel *)selectLabel{
    if (!_selectLabel) {
        _selectLabel = [BDUI bd_createLabelWithFrame:CGRectMake(SCREEN_W/2 - 80, 0, 160, 35)
                                                text:[self selectDateString]
                                           textColor:[UIColor bd_orangeColor]
                                                font:[UIFont systemFontOfSize:15]];
    }
    return _selectLabel;
}

-(UILabel * )nextLabel{
    if (!_nextLabel) {
        _nextLabel = [BDUI bd_createLabelWithFrame:CGRectMake(SCREEN_W - 90, 0, 80, 35)
                                              text:@"后一日"
                                         textColor:[[UIColor bd_orangeColor] colorWithAlphaComponent:0.5]
                                              font:[UIFont systemFontOfSize:15]];
        
    }
    return _nextLabel;
}

@end
