//
//  UIResponder+Event.m
//  MiGuKit
//
//  Created by zhgz on 2018/3/31.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import "UIResponder+Event.h"
#import <objc/runtime.h>
#define kEventBlockKey @"kEventBlockKey"
#define kNeedNextResponderKey @"kNeedNextResponderKey"
@implementation UIResponder (Event)

- (void)setEventStrategy:(NSMutableDictionary *)eventStrategy {
    objc_setAssociatedObject(self, @selector(eventStrategy), eventStrategy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)eventStrategy{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)routerEvent:(nonnull NSString *)eventName info:(nullable id)info{
	EventBlock block = self.eventStrategy[eventName][kEventBlockKey];
    block ? block(info) : nil;
    
	if(self.eventStrategy){
        if([self.eventStrategy[eventName][kNeedNextResponderKey] isEqual:@(NO)]){
            return;
        }
    }
	[self.nextResponder routerEvent:eventName info:info];
}

- (void)registerEvent:(nonnull NSString *)eventName
                block:(nullable EventBlock)block
                 next:(BOOL)needNext{
	if(!self.eventStrategy){
        self.eventStrategy = [NSMutableDictionary new];
    }
    self.eventStrategy[eventName] = @{kEventBlockKey:(block ? block : ^(id info){}),
                                      kNeedNextResponderKey:@(needNext)
                                      };
}
@end
