//
//  BDDevice.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/9.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDevice : NSObject

#pragma mark - app
+ (NSString *)bd_appVersion;

+ (NSString *)bd_appBuild;

+ (NSString *)bd_bundleIdentifier;

+ (NSString *)bd_appDisplayName;

+ (NSString *)bd_appBundleName;


#pragma mark - 系统
+ (NSString *)bd_systemVersion;

+ (NSString *)bd_systemName;


#pragma mark - 设备
+ (NSString *)bd_deviceName;

+ (NSString *)bd_deviceIDFV;

+ (NSString *)bd_deviceIDFA;

+ (NSString *)bd_uuidString;

+ (NSString *)deviceLocalized;

+ (NSString *)bd_deviceType;

+ (NSDictionary *)bd_deviceInfo;

#pragma mark - 条件
+ (BOOL)bd_simulator;

+ (BOOL)bd_iPhonex;

+ (BOOL)bd_reLogin;

@end

NS_ASSUME_NONNULL_END
