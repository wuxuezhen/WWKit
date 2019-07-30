//
//  UIViewController+FITAppSettings.m
//  FitBody
//
//  Created by caiyi on 2018/8/22.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "UIViewController+FITAppSettings.h"

@implementation UIViewController (FITAppSettings)


/**
 打开设置
 */
- (void)fit_openAppSettings {
    [self fit_openURL:UIApplicationOpenSettingsURLString];
}



/**
 拨打电话

 @param phone 手机号码
 */
-(void)fit_callPhone:(NSString *)phone{
    if (!phone || phone.length == 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"tel:%@",phone];
    [self fit_openURL:url];
}



/**
 打开链接

 @param url 链接
 */
-(void)fit_openURL:(NSString *)url{
    if ([self fit_canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                                   options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}
                                         completionHandler:^(BOOL success) {
                                             
                                         }];
                
            }
            
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
        
    }
}


/**
 是否能打开链接

 @param url 链接
 @return yes/no
 */
-(BOOL)fit_canOpenURL:(NSString *)url{
    if (url && url.length > 0) {
        return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
    }else{
        return NO;
    }
}
@end
