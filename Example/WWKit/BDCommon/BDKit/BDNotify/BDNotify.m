//
//  BDNotify.m
//  MiGuKit
//
//  Created by zhgz on 2018/4/9.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import "BDNotify.h"
#import <objc/runtime.h>

@interface NSObject(BDNotify)

@end

@implementation NSObject(BDNotify)

- (void)setBdNotifyStrategy:(NSMutableDictionary *)bdNotifyStrategy {
    objc_setAssociatedObject(self, @selector(bdNotifyStrategy), bdNotifyStrategy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)bdNotifyStrategy{
    return objc_getAssociatedObject(self, _cmd);
}

@end


@interface BDNotify()
@property (nonatomic,strong) NSMutableDictionary *notifyDic;
@end

@implementation BDNotify

+ (BDNotify *)sharedInstance {
    static BDNotify *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.notifyDic = [NSMutableDictionary new];
    });
    return instance;
}

+ (void)bd_notify:(nonnull NSString *)eventName info:(nullable id)info {
    NSPointerArray *array = [BDNotify sharedInstance].notifyDic[eventName];
    if(array != nil){
        for(id obj in array){
            NotifyBlock block =((NSObject*)obj).bdNotifyStrategy[eventName];
            block ? block(info) : nil;
        }
    }
}

+ (void)bd_registerNotify:(nonnull NSString *)eventName
                 instance:(nonnull id)instance
                    block:(nullable NotifyBlock)block {
    
    if([BDNotify sharedInstance].notifyDic[eventName] == nil){
        [BDNotify sharedInstance].notifyDic[eventName] = [NSPointerArray weakObjectsPointerArray];
    }
    NSPointerArray *array = [BDNotify sharedInstance].notifyDic[eventName];
    if(!instance){
        if(((NSObject*)instance).bdNotifyStrategy == nil){
            ((NSObject*)instance).bdNotifyStrategy = [NSMutableDictionary new];
        }
        ((NSObject*)instance).bdNotifyStrategy[eventName] = block ? block :^(id info){};
        [array addPointer:(__bridge void *)instance];
    }
}

//+(void)removeNotify:(nonnull NSString *)eventName {
//    NSPointerArray *array = [MGNotify sharedInstance].notifyDic[eventName];
//    if(array != nil){
//        for(id obj in array){
//            [((NSObject*)obj).mgNotifyStrategy removeObjectForKey:eventName];
//        }
//    }
//    [[MGNotify sharedInstance].notifyDic removeObjectForKey:eventName];
//}

@end

