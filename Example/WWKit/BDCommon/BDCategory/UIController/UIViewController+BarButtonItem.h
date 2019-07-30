//
//  UIViewController+BarButtonItem.h
//
//  Created by caiyi on 2018/8/27.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarButtonItem)

#pragma mark - 设置父类导航
-(void)bd_setSuperNavnavigation;

/**
 通过图片创建导航栏右边按钮，需重写ld_rightBarButtonItemAction:
 @param imageName 图片名称
 */
- (void)bd_createLeftBarButtonItemWithImage:(NSString *)imageName;
/**
 通过文字创建导航栏右边按钮,需重写ld_rightBarButtonItemAction:
 @param title 按钮名称
 */
- (void)bd_createLeftBarButtonItemWithTitle:(NSString *)title;
/**
 导航右边按钮的点击行为
 */
- (void)bd_leftBarButtonItemAction:(UIBarButtonItem *)barButtonItem;




/**
 通过图片创建导航栏右边按钮，需重写ld_rightBarButtonItemAction:
 @param imageName 图片名称
 */
- (void)bd_createRightBarButtonItemWithImage:(NSString *)imageName;

/**
 通过文字创建导航栏右边按钮,需重写ld_rightBarButtonItemAction:
 @param title 按钮名称
 */
- (void)bd_createRightBarButtonItemWithTitle:(NSString *)title;

/**
 导航右边按钮的点击行为
 */
- (void)bd_rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem;


/**
 修改导航栏title 颜色
 */
- (void)bd_navigationTitleColor:(UIColor *)titleColor;

- (void)bd_statusBarStyle:(UIStatusBarStyle)statusBarStyle;

@end
