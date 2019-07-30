//
//  BDSafe.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/9.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDSafe.h"
#import "NSObject+Object.h"

@implementation BDSafeArray

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
- (id)objectAtIndex:(NSUInteger)index {
    return [self.originArray bd_objectAtIndex:index];
}
#pragma clang diagnostic pop

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if ([self.originArray isKindOfClass:NSMutableArray.class]) {
        [(NSMutableArray *)self.originArray bd_setObject:obj atIndexedSubscript:idx];
    }
}

@end


@implementation BDSafeDictionary
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
- (id)objectForKey:(id)aKey {
    return [self.originDict bd_objectForKey:aKey];
}

#pragma clang diagnostic pop

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if ([self.originDict isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self.originDict bd_setObject:obj forKey:key];
    }
}

@end
