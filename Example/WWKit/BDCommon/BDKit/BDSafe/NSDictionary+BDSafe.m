//
//  NSDictionary+BDSafe.m
//  MiGuKit
//
//  Created by 熊智凡 on 2018/12/10.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import "NSDictionary+BDSafe.h"

@implementation NSDictionary (BDSafe)

- (BOOL)bd_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error {
    if (url == nil) {
        return NO;
    }else {
        return [self writeToURL:url error:error];
    }
}

+ (instancetype)bd_dictionaryWithObject:(id)object forKey:(id)key {
    if (object == nil || key == nil) {
        return nil;
    }else {
        return [NSDictionary dictionaryWithObject:object forKey:key];
    }
}

- (id)bd_objectForKey:(id)aKey {
    if (aKey) {
        return [self objectForKey:aKey];
    }
    return nil;
}

- (id)bd_valueForKey:(id)aKay {
    if (aKay) {
        return [self valueForKey:aKay];
    }
    return nil;
}

- (void)bd_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey && [self isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self setObject:anObject forKey:aKey];
    }
}

- (void)bd_setValue:(id)value forKey:(NSString *)key {
    if (key && [self isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self setValue:value forKey:key];
    }
}

@end

