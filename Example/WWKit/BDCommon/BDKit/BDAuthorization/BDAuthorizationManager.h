//
//  BDAuthorizationManager.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/30.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, BDAuthorizationType) {
    BDAuthorizationTypePhotoLibrary, // 相册
    BDAuthorizationTypeCamera, // 相机
    BDAuthorizationTypeMicrophone, // 麦克风
    BDAuthorizationTypeContacts, // 联系人
    BDAuthorizationTypeCalendars, // 日历
    BDAuthorizationTypeReminder, // 备忘录
    BDAuthorizationTypeNotication, // 通知
    
};
NS_ASSUME_NONNULL_BEGIN

@interface BDAuthorizationManager : NSObject

+ (void)requestAuthorization:(BDAuthorizationType)type
           completionHandler:(void(^)(BOOL granted, BOOL isFirst))completionHandler;

+ (void)requestAuthorization:(BDAuthorizationType)type
                   showAlert:(BOOL)showAlert
           completionHandler:(void(^)(BOOL granted, BOOL isFirst))completionHandler;

@end

NS_ASSUME_NONNULL_END
