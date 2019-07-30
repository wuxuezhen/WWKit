//
//  WWAppSettings.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/28.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "WWAppSettings.h"

@implementation WWAppSettings

/**
 打开设置
 */
+ (void)ww_openAppSettings {
    [self ww_openURL:UIApplicationOpenSettingsURLString];
}



/**
 拨打电话
 
 @param phone 手机号码
 */
+(void)ww_callPhone:(NSString *)phone{
    if (!phone || phone.length == 0) {
        return;
    }
    [self ww_openURL:[@"tel:" stringByAppendingString:phone]];
}



/**
 打开链接
 
 @param url 链接
 */
+(void)ww_openURL:(NSString *)url{
    if ([self ww_canOpenURL:url]) {
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
+(BOOL)ww_canOpenURL:(NSString *)url{
    if (url && url.length > 0) {
        return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
    }else{
        return NO;
    }
}
@end

