//
//  BDKeychina.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/29.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDKeychina.h"
#import <YYKit/YYKeychain.h>
#import "BDDevice.h"
@implementation BDKeychina

+(NSString *)getPassword{
    return [YYKeychain selectOneItem:[self keychainItem]].password;
}

+(void)setPassword:(NSString *)password{
    [YYKeychain setPassword:password forService:[self service] account:[self account]];
}

+(void)setItem:(NSDictionary *)dict{
    YYKeychainItem *item   = [self keychainItem];
    YYKeychainItem *result = [YYKeychain selectOneItem:item];
    if (result) {
        //赋值
        [YYKeychain updateItem:result];
    }else{
        //赋值
        //        item.passwordData = @"";
        [YYKeychain insertItem:item];
        
    }
}



+(YYKeychainItem *)keychainItem{
    YYKeychainItem *item = [YYKeychainItem new];
    item.service = [self service];
    item.account = [self account];
    return item;
}

+(NSString *)service{
    return [BDDevice bd_bundleIdentifier];
}

+(NSString *)account{
    return [BDDevice bd_deviceIDFA];
}
@end
