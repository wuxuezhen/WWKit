//
//  WWAppSettings.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/28.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWAppSettings : NSObject

/**
 打开设置界面
 */
+(void)ww_openAppSettings;


/**
 拨打电话
 @param phone 电话号码
 */
+(void)ww_callPhone:(NSString *)phone;


/**
 打开链接
 @param url 链接
 */
+(void)ww_openURL:(NSString *)url;


/**
 是否能打开链接
 @param url 链接
 @return yes/no
 */
+(BOOL)ww_canOpenURL:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
