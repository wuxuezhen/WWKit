//
//  UIView+LoadingHud.h
//  HNLandTax
//
//  Created by wzz on 2018/11/13.
//  Copyright © 2018 WYW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LoadingHud)
/**
 展示加载框
 */
- (void)wz_showProgressHud;

/**
 展示加载框
 @param text 提示文字
 */
- (void)wz_showProgressHud:(NSString * _Nullable)text;

/**
 移除展示加载框
 */
- (void)wz_dismissHud;



/**
 提示文字 默认1.5秒后消失
 @param text 提示文字
 */
- (void)wz_showHubText:(NSString *)text;

/**
 提示文字
 @param text 提示文字
 @param duration 展示时间
 */
- (void)wz_showHubText:(NSString *)text duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
