//
//  BDKeychina.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/29.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDKeychina : NSObject
+(NSString *)getPassword;

+(void)setPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
