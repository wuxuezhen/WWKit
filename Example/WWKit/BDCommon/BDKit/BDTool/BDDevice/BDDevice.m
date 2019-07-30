//
//  BDDevice.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/9.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDDevice.h"
#import <sys/utsname.h>
#import "BDKeyManager.h"
#import <AdSupport/AdSupport.h>
@implementation BDDevice

#pragma mark - app
+ (NSString *)bd_appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:BDSystemVersion];
}

+ (NSString *)bd_appBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:BDSystemBuild];
}

+ (NSString *)bd_bundleIdentifier{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:BDBundleIdentifier];
}

+ (NSString *)bd_appDisplayName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:BDAppDisplayName];
}

+ (NSString *)bd_appBundleName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:BDAppBundleName];
}

#pragma mark - 系统
+ (NSString *)bd_systemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)bd_systemName{
    return [[UIDevice currentDevice] systemName];
}

#pragma mark - 设备
+ (NSString *)bd_deviceName{
    return [[UIDevice currentDevice] name];
}

/**  卸载应用重新安装后会不一致*/
+ (NSString *)bd_deviceIDFV{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/** 不会因为应用卸载改变
 * 但是用户在设置-隐私-广告里面限制广告跟踪后会变成@"00000000-0000-0000-0000-000000000000"
 * 重新打开后会变成另一个，还原广告标识符也会变
 */
+ (NSString *)bd_deviceIDFA{
    NSString *uuidString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if(!uuidString || uuidString.length == 0 || [uuidString isEqualToString:@"00000000-0000-0000-0000-000000000000"]){
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
        CFRelease(uuidRef);
    }
    return uuidString;
}

+(NSString *)bd_uuidString{
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)deviceLocalized{
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *)bd_deviceType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone 8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone 8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}

+ (NSDictionary *)bd_deviceInfo{
    NSString *phoneSystem = [@"iOS " stringByAppendingString:[self bd_systemVersion]];
    return @{@"phoneType":[self bd_deviceType],
             @"phoneSystem":phoneSystem,
             @"os":@"iOS",
             @"version":[self bd_appVersion]
             };
}

+ (BOOL)bd_simulator{
    NSString *deviceModel = [self bd_deviceType];
    return [deviceModel isEqualToString:@"Simulator"];
}

+(BOOL)bd_iPhonex{
    NSString *deviceModel = [self bd_deviceType];
    return [deviceModel rangeOfString:@"iPhone X"].location != NSNotFound;
}

+(BOOL)bd_reLogin{
    NSString *recordVersion  = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAppVersionRecord"];
    NSString *currentVersion = [self bd_appVersion];
    if (recordVersion && [recordVersion isEqualToString:currentVersion]) {
        return NO;
    }else{
        return YES;
    }
}
@end
