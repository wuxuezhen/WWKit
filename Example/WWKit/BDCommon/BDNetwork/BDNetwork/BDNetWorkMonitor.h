//
//  BDNetWorkMonitor.h
//
//  Created by caiyi on 2018/8/21.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
@interface BDNetWorkMonitor : NSObject


/**
 当前网络状态

 @param success 当前网络字符串
 */
+ (void)fit_checkNetworkConnectionStatus:(void(^)(NSString *))success;


/**
 当前网络状态
 
 @return 网络状态
 */
+ (NetworkStatus)fit_currentNetworkStatus;

/**
 当前是否有网
 
 @return yes/no
 */
+ (BOOL)fit_checkHasConnentNet;



@end
