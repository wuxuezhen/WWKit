//
//  UIColor+BDColor.m
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#import "UIColor+BDColor.h"

@implementation UIColor (BDColor)

/**
 字体橙色
 */
+(UIColor *)bd_orangeColor{
    return BD_RGB_HEX(0xFB7A52);
}

/**
 字体灰色
 */
+(UIColor *)bd_grayColor{
    return BD_RGB_HEX(0x666666);
}

/**
 字体黑色
 */
+(UIColor *)bd_blackColor{
    return BD_RGB_HEX(0x333333);
}

/**
 蓝色
 */
+(UIColor *)bd_blueColor{
    return BD_RGB_HEX(0x0D7FF9);
}

/**
 主题蓝色
 */
+(UIColor *)bd_themeColor{
    return BD_RGB_HEX(0x0696FF);
}

/**
 浅灰
 */
+(UIColor *)bd_lightGrayColor{
    return BD_RGB_HEX(0xB3B3B3);
}

@end
