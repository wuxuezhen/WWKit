//
//  UIViewController+FITAppSettings.h
//  FitBody
//
//  Created by caiyi on 2018/8/22.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FITAppSettings)

/**
 打开设置界面
 */
- (void)fit_openAppSettings;


/**
 拨打电话
 
 @param phone 电话号码
 */
-(void)fit_callPhone:(NSString *)phone;


/**
 打开链接
 
 @param url 链接
 */
-(void)fit_openURL:(NSString *)url;


/**
 是否能打开链接
 
 @param url 链接
 @return yes/no
 */
-(BOOL)fit_canOpenURL:(NSString *)url;

@end
