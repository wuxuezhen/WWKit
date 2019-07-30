//
//  BDUserManager.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/21.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDUserManager.h"
#import "BDKeychina.h"
@interface BDUserManager()
@property (strong, nonatomic) BDUser *user;
@end

@implementation BDUserManager
+ (instancetype)sharedManager {
    static BDUserManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[NSFileManager defaultManager] fileExistsAtPath:LOCAL_USER_PATH]) {
            sharedManager = [self bd_initManager];
        }else{
            sharedManager = [[self alloc] init];
//            if ([BDKeychina getPassword]) {
//                BDUser *user = [[BDUser alloc]initWithString:[BDKeychina getPassword]
//                                                             error:nil];
//                [self bd_saveUserInfo:user];
//            }
        }
    });
    return sharedManager;
}

#pragma mark - 初始化、更新、清除用户数据
+ (BDUserManager *)bd_initManager{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:LOCAL_USER_PATH];
}

+ (BOOL) bd_saveUserInfo:(BDUser *)user {
    [BDUserManager sharedManager].user = user;
//    [BDKeychina setPassword:user.toJSONString];
    return  [NSKeyedArchiver archiveRootObject: [BDUserManager sharedManager] toFile:LOCAL_USER_PATH];
}

+ (BOOL) bd_removeUserInfo{
    [BDUserManager sharedManager].user = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:LOCAL_USER_PATH]) {
        NSError *error = nil;
        return [[NSFileManager defaultManager] removeItemAtPath:LOCAL_USER_PATH error:&error];
    }
    return YES;
}

#pragma mark **********************************  用户信息  **************************************
+(BDUser *)bd_user{
    return [BDUserManager sharedManager].user;
}


#pragma mark **********************************  归档解档  **************************************
/***归档***/
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.user forKey:@"user"];
}

/***解档***/
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.user = [coder decodeObjectForKey:@"user"];
    }
    return self;
}
@end
