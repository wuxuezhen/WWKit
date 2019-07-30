//
//  BDUI.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "BDUI.h"

@implementation BDUI

+(UIView *)bd_createViewWithFrame:(CGRect)frame{
    return [[UIView alloc]initWithFrame:frame];
}

+(UILabel *)bd_createLabelWithText:(NSString *)text
                         textColor:(UIColor *)textColor
                              font:(UIFont *)font{
    UILabel *label  = [[UILabel alloc]init];
    label.text      = text;
    label.textColor = textColor;
    label.font      = font;
    return label;
}

+(UILabel *)bd_createLabelWithFrame:(CGRect)frame
                               text:(NSString *)text
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font{
    UILabel *label  = [[UILabel alloc]initWithFrame:frame];
    label.text      = text;
    label.textColor = textColor;
    label.font      = font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+(UIButton *)bd_createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                               target:(id)target
                             selecter:(SEL)selecter{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)bd_createButtonWithImageName:(NSString *)imageName
                      backgroundImageName:(NSString *)backgroundImageName
                                   target:(id)target
                                 selecter:(SEL)selecter{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (backgroundImageName) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)bd_createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                            imageName:(NSString *)imageName
                  backgroundImageName:(NSString *)backgroundImageName
                               target:(id)target
                             selecter:(SEL)selecter{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (backgroundImageName) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIImageView *)bd_createImageViewWithFrame:(CGRect)frame
                                  imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
}

+(UITextField *)bd_createTextFieldWithFrame:(CGRect)frame
                                       text:(NSString *)text
                                placeHolder:(NSString *)placeHolder{
    UITextField *textFirld = [[UITextField alloc]initWithFrame:frame];
    textFirld.text         = text;
    textFirld.placeholder  = placeHolder;
    textFirld.borderStyle  = UITextBorderStyleRoundedRect;
    return textFirld;
}

+(UIStepper *)bd_createStepper:(CGRect)frame
                         Value:(NSInteger)value
                           Max:(NSInteger)max
                           Min:(NSInteger)min
                        Target:(id)target
                      selecter:(SEL)selecter{
    UIStepper *stepper = [[UIStepper alloc]init];
    stepper.frame      = frame;
    stepper.value      = value;
    stepper.maximumValue = max;
    stepper.minimumValue = min;
    stepper.stepValue    = 1;
    stepper.continuous   = YES;
    stepper.wraps        = NO;
    //stepper.tintColor = [UIColor lightGrayColor];//设置按钮的颜色;
    [stepper setBackgroundColor:[UIColor clearColor]];
    [stepper addTarget:target action:selecter forControlEvents:UIControlEventValueChanged];
    return stepper;
}

+(UITableView *)bd_createTableViewWith:(CGRect)frame
                                target:(id)action
                                 style:(UITableViewStyle)style{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.delegate     = action;
    tableView.dataSource   = action;
    tableView.sectionHeaderHeight = CGFLOAT_MIN;
    tableView.sectionFooterHeight = CGFLOAT_MIN;
    tableView.tableFooterView     = [[UIView alloc]init];
    return tableView;
}

+(UIView *)bd_backgroundWithNoContent{
    return [[UIView alloc]init];
}
@end
