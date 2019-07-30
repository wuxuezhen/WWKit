//
//  UIColor+BDColor.h
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BD_RGB(r,g,b)    BD_RGBA((r),(g),(b),1.0)
#define BD_RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define BD_RGB_HEX(hexValue)      BD_RGB_HEXHEX((hexValue),1.0)
#define BD_RGB_HEXHEX(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:a]

#define BDRandomColor BD_RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BDColor)
/**
 字体橙色
 */
+(UIColor *)bd_orangeColor;

/**
 字体灰色
 */
+(UIColor *)bd_grayColor;

/**
 字体黑色
 */
+(UIColor *)bd_blackColor;

/**
 蓝色
 */
+(UIColor *)bd_blueColor;

/**
 主题蓝色
 */
+(UIColor *)bd_themeColor;

/**
 浅灰
 */
+(UIColor *)bd_lightGrayColor;

@end

NS_ASSUME_NONNULL_END
