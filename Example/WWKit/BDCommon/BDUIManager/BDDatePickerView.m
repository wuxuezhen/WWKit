//
//  BDDatePickerView.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/5.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDDatePickerView.h"
#import "BDBusinessDataHeader.h"
#import "WWGCDQueue.h"
#define PICK_HEIGHT  SCREEN_H/3

@interface BDDatePickerView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *makesureBtn;

@end

@implementation BDDatePickerView

-(instancetype)init{
    return [self initWithPickerMode:UIDatePickerModeDate];
}
-(instancetype)initWithPickerMode:(UIDatePickerMode)mode{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    if (self) {
        self.backgroundColor = BD_RGBA(0, 0, 0, 0.2);
        
        if (mode) {
            self.datePicker.datePickerMode = mode;
        } else {
            self.datePicker.datePickerMode = UIDatePickerModeDate;
        }
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.datePicker];
        [self.contentView addSubview:self.toolBar];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self);
            make.height.mas_equalTo(PICK_HEIGHT + 40);
        }];
        
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(PICK_HEIGHT);
        }];
       
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.contentView);
            make.bottom.equalTo(self.datePicker.mas_top);
            make.height.mas_equalTo(40);
        }];
        
        [self.toolBar addSubview:self.cancelBtn];
        [self.toolBar addSubview:self.makesureBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.equalTo(self.toolBar);
            make.width.equalTo(@70);
        }];
        [self.makesureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.bottom.equalTo(self.toolBar);
            make.width.equalTo(@70);
        }];
    }
    return self;
}


-(void)setCancelTitle:(NSString *)cancelTitle{
    _cancelTitle = cancelTitle;
    UIButton *bu = [self viewWithTag:1];
    _cancelTitle = cancelTitle;
    [bu setTitle:cancelTitle forState:UIControlStateNormal];
}
-(void)setDate:(NSDate *)date{
    _date = date;
    _datePicker.date = date;
}
-(void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    _datePicker.maximumDate = maxDate;
}
-(void)setMinDate:(NSDate *)minDate{
    _maxDate = minDate;
    _datePicker.minimumDate = minDate;
}

/**弹出视图*/
- (void)show{
    bd_async_mainQueue(^{
        [[[UIApplication sharedApplication].delegate window] addSubview:self];
        [self layoutIfNeeded];
        CGRect selfFrame = self.contentView.frame;
        self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, CGRectGetHeight(selfFrame));
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = selfFrame;
        }];
    });
}

-(void)remove{
    bd_async_mainQueue(^{
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, CGRectGetHeight(self.contentView.frame));
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

#pragma mark - action
//选择确定或者取消
-(void)makesureAction:(UIButton *)sender{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    if (self.dateFormat) {
        [dateformatter setDateFormat:self.dateFormat];
    } else {
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *choseDateString = [dateformatter stringFromDate:_datePicker.date];
//    NSString *timeInterval = @([_datePicker.date timeIntervalSince1970]).stringValue;
//    NSArray *dates =@[choseDateString?:@"",timeInterval?:@""];
    self.confirmBlock ?  self.confirmBlock(choseDateString,_datePicker.date) : nil;
    [self remove];
}

- (void)cancelAction:(UIButton *)sender {
    [self remove];
}



#pragma mark - 懒加载
-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    }
    return _datePicker;
}


-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [BDUI bd_createButtonWithTitle:@"取消"
                                         titleColor:[UIColor darkGrayColor]
                                             target:self
                                           selecter:@selector(cancelAction:)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelBtn;
}
-(UIButton *)makesureBtn{
    if (!_makesureBtn) {
        _makesureBtn = [BDUI bd_createButtonWithTitle:@"确定"
                                           titleColor:[UIColor darkGrayColor]
                                               target:self
                                             selecter:@selector(makesureAction:)];
    }
    _makesureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    return _makesureBtn;
}


-(UIView *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIView alloc]init];
        _toolBar.backgroundColor = BD_RGB_HEX(0xf5f5f5);
    }
    return _toolBar;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
@end

