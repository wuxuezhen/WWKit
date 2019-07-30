//
//  NSObject+MGModel.m
//  MGTools
//
//  Created by Alfred Zhang on 2018/2/28.
//  Copyright © 2018年 MIGU. All rights reserved.
//

#import "NSObject+MGModel.h"
#import <objc/runtime.h>

@implementation NSObject (MGModel)

- (BOOL)mg_boolValue {
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"0"]) {
            return NO;
        }else {
            return YES;
        }
    }else{
        return NO;
    }
}

- (NSInteger)mg_integerValue {
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) integerValue];
    }else{
        return 0;
    }
}

- (CGFloat)mg_floatValue {
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) floatValue];
    }else{
        return 0;
    }
}

-(id)mgOriginData{
	return objc_getAssociatedObject(self, _cmd);;
}

-(void)setMgOriginData:(id)mgOriginData{
	objc_setAssociatedObject(self, @selector(mgOriginData), mgOriginData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
