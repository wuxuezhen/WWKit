//
//  BDNetWorkMonitor.m
//
//  Created by caiyi on 2018/8/21.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "BDNetWorkMonitor.h"

@implementation BDNetWorkMonitor

/**
 当前网络状态
 
 @param success 成功
 */
+(void)fit_checkNetworkConnectionStatus:(void(^)(NSString *sting))success{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        NSString *message = nil;
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                message = @"未知的网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                message = @"无网络连接";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                message = @"您当前使用的是3G|4G网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                message = @"您已连接到Wifi";
                break;
            default:
                message = @"未知的网络";
                break;
        }
        if (success) {
            success(message);
        }
    }];
    
}


/**
 当前网络状态
 
 @return 网络状态
 */
+ (NetworkStatus)fit_currentNetworkStatus{
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

/**
 当前是否有网
 
 @return yes/no
 */
+ (BOOL)fit_checkHasConnentNet{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    switch([reachability currentReachabilityStatus]){
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
}


@end
