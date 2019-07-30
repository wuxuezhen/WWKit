//
//  BDUserManager.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/21.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDUser.h"
NS_ASSUME_NONNULL_BEGIN

@interface BDUserManager : NSObject
+ (instancetype)sharedManager;

+(BDUser *)bd_user;

/**
 保存用户信息
 */
+ (BOOL) bd_saveUserInfo:(BDUser *)user;

/**
 清除用户信息
 */
+ (BOOL) bd_removeUserInfo;

@end

NS_ASSUME_NONNULL_END
