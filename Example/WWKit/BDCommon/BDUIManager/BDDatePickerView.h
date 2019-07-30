//
//  BDDatePickerView.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/5.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *dateFormat;

@property (nonatomic) NSDate *date;
@property (nonatomic) NSDate *maxDate;
@property (nonatomic) NSDate *minDate;

@property (nonatomic, copy) void (^confirmBlock)(NSString *dateString,NSDate *date);
@property (nonatomic ,copy) void (^cancelBlock)(void);

-(instancetype)initWithPickerMode:(UIDatePickerMode)mode;
-(void)show;

@end

NS_ASSUME_NONNULL_END
