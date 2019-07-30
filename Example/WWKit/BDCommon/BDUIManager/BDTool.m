//
//  BDTool.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/20.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "BDTool.h"

@implementation BDTool

//获取宽度
+(CGFloat)widthWithView:(NSString *)string font:(NSInteger)size hight:(CGFloat)hight{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, hight)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}
                                       context:nil];
    
    return rect.size.width;
}
//获取高度
+(CGFloat)hightWithView:(NSString *)string font:(NSInteger)size Width:(CGFloat)width{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}
                                       context:nil];
    return rect.size.height;
}

//获取高度富文本
+ (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width spacing:(CGFloat)spacing {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.font = font;
    label.numberOfLines = 0;
    label.attributedText = [self attributedString:text font:font spacing:spacing];
    [label sizeToFit];
    return label.frame.size.height;
}
//获取宽度富文本
+ (CGFloat)widthWithText:(NSString *)text font:(UIFont *)font hight:(CGFloat)hight spacing:(CGFloat)spacing {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAXFLOAT, hight)];
    label.font = font;
    label.numberOfLines = 0;
    label.attributedText = [self attributedString:text font:font spacing:spacing];
    [label sizeToFit];
    return label.frame.size.height;
}

//获取富文本
+(NSAttributedString *)attributedString:(NSString *)text font:(UIFont *)font spacing:(CGFloat)spacing {
    if (spacing < 0.01 || !text) {
        return nil;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName
                             value:font
                             range:NSMakeRange(0, text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}

+(NSAttributedString *)attributedString:(NSString *)text textColor:(UIColor *)textColor Key:(NSString *)key keyColor:(UIColor *)keyColor font:(UIFont *)font spacing:(CGFloat)spacing{
    if (spacing < 0.01 || !text) {
        return nil;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{
                                      NSFontAttributeName:font,
                                      NSForegroundColorAttributeName:textColor
                                      }
                             range:NSMakeRange(0, text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [attributedString length])];
    
    [attributedString addAttributes:@{
                                      NSFontAttributeName:font,
                                      NSForegroundColorAttributeName:keyColor
                                      }
                              range:[text rangeOfString:key]];
    return attributedString;
}




+(BOOL)whetherDigitalWithInput:(NSString *)str{
    
    return ![self isPureInt:str] && ![self isPureFloat:str];
}

//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
