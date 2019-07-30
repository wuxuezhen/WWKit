//
//  BDTextField.h
//
//  Created by 吴振振 on 2018/6/5.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDTextField : UITextField
@property (nonatomic, strong) UIColor *lineColor;
-(instancetype)initWithText:(NSString *)text
                       font:(UIFont *)font
                placeHolder:(NSString *)placeHolder
                  textColor:(UIColor *)textColor
                  tintColor:(UIColor *)tintColor
                  lineColor:(UIColor *)lineColor;
@end
