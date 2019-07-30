//
//  BDUI.h
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BDUI : NSObject

//利用工厂模式，将基本控件用静态方法创建，是能够更方便的修改类似的属性

//创建view
+(UIView *)bd_createViewWithFrame:(CGRect)Frame;

//创建Label
+(UILabel *)bd_createLabelWithText:(NSString *)text
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font;

+(UILabel *)bd_createLabelWithFrame:(CGRect)frame
                               text:(NSString *)text
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font;
// 创建 Button

+(UIButton *)bd_createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                               target:(id)target
                             selecter:(SEL)selecter;

+(UIButton *)bd_createButtonWithImageName:(NSString *)imageName
                      backgroundImageName:(NSString *)backgroundImageName
                                   target:(id)target
                                 selecter:(SEL)selecter;

+(UIButton *)bd_createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                            imageName:(NSString *)imageName
                  backgroundImageName:(NSString *)backgroundImageName
                               target:(id)target
                             selecter:(SEL)selecter;

// 创建 ImageView
+(UIImageView *)bd_createImageViewWithFrame:(CGRect)frame
                                  imageName:(NSString *)imageName;

// 创建 TextField
+(UITextField *)bd_createTextFieldWithFrame:(CGRect)frame
                                       text:(NSString *)text
                                placeHolder:(NSString *)placeHolder;

//创建加减按钮
+(UIStepper *)bd_createStepper:(CGRect)frame
                         Value:(NSInteger)value
                           Max:(NSInteger)max
                           Min:(NSInteger)min
                        Target:(id)target
                      selecter:(SEL)selecter;

+(UITableView *)bd_createTableViewWith:(CGRect)frame
                                target:(id)action
                                 style:(UITableViewStyle)style;

//没有内容背景图
+(UIView *)bd_backgroundWithNoContent;

@end
