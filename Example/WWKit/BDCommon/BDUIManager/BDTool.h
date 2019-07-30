//
//  BDTool.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/20.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BDTool : NSObject

+(CGFloat)widthWithView:(NSString *)string font:(NSInteger)size hight:(CGFloat)hight;
+(CGFloat)hightWithView:(NSString *)string font:(NSInteger)size Width:(CGFloat)width;

+(CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width spacing:(CGFloat)spacing;
+(CGFloat)widthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight spacing:(CGFloat)spacing;

+(NSAttributedString *)attributedString:(NSString *)text font:(UIFont *)font spacing:(CGFloat)spacing;

+(NSAttributedString *)attributedString:(NSString *)text
                              textColor:(UIColor *)textColor
                                    Key:(NSString *)key
                               keyColor:(UIColor *)keyColor
                                   font:(UIFont *)font
                                spacing:(CGFloat)spacing;

//判断 整型
+ (BOOL)isPureInt:(NSString*)string;
//判断 浮点型
+ (BOOL)isPureFloat:(NSString*)string;
//判断 数字，字符串
+(BOOL)whetherDigitalWithInput:(NSString *)str;

@end
