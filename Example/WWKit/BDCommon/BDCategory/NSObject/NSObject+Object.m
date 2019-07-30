//
//  NSObject+Object.m
//  HNLandTax
//
//  Created by wzz on 2018/12/24.
//  Copyright © 2018 WYW. All rights reserved.
//

#import "NSObject+Object.h"

@implementation NSObject (Object)
- (id)valueForUndefinedKey:(NSString *)key {
    NSString *string = [NSString stringWithFormat:@"%@ valueForUndefinedKey:%@", self, key];
    NSLog(@"%@",string);
    NSAssert(NO, string);
    return nil;
}

- (NSDictionary *)toDictionary {
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSData class]]) {
        @try {
            NSData *data = nil;
            if ([self isKindOfClass:[NSString class]]) {
                data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
            } else {
                data = (NSData *)self;
            }
            /** *
             NSJSONReadingMutableContainers 解析为数组或字典
             NSJSONReadingMutableLeaves 解析为可变字符
             NSJSONReadingAllowFragments 解析为除上面两个以外的格式
             */
            NSError *jsonError;
            NSDictionary *objDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            return objDictionary;
            
        }
        @catch (NSException *exception) {
            NSLog(@"error");
            return nil;
        }
    }
    else
        NSLog(@"self is not string or nsdata");
    return nil;
}

-(NSArray *)toArray {
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSData class]]) {
        @try {
            NSData *data = nil;
            if ([self isKindOfClass:[NSString class]]) {
                data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
            } else {
                data = (NSData *)self;
            }
            /** *
             NSJSONReadingMutableContainers 解析为数组或字典
             NSJSONReadingMutableLeaves 解析为可变字符
             NSJSONReadingAllowFragments 解析为除上面两个以外的格式
             */
            NSError *jsonError;
            NSArray *objArray = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&jsonError];
            return objArray;
            
        }
        @catch (NSException *exception) {
            NSLog(@"error");
            return nil;
        }
    }
    else
        NSLog(@"self is not string or nsdata");
    return nil;
}

/**
 keyPath字符串取 字典/数组/对象 的值
 @param keyPath keyPath description
 @return return value description
 */
- (id)jsonValueForKeyPath:(NSString *)keyPath {
    if (keyPath.length == 0) {
        return nil;
    }
    if(![keyPath containsString:@"."]
       &&![keyPath containsString:@"["]
       &&![keyPath containsString:@"]"]
       ){
        return [self jsonValueForKey:keyPath];
    }
    NSArray *keyArr = [self parseKeyPath:keyPath];
    return [self jsonValueForKeys:keyArr];
}

- (NSArray *)parseKeyPath:(NSString *)keyPath {
    NSArray *arr = [keyPath componentsSeparatedByString:@"."];
    NSMutableArray *keyArr = [NSMutableArray array];
    for (NSString *key in arr) {
        if ([key containsString:@"["] && [key containsString:@"]"]) {
            NSArray *arrkey = [key componentsSeparatedByString:@"["];
            for (NSString *key in arrkey) {
                if ([key containsString:@"]"]) {
                    [keyArr addObject:[key componentsSeparatedByString:@"]"].firstObject];
                } else {
                    if (key.length > 0) {
                        [keyArr addObject:key];
                    }
                }
            }
        } else {
            [keyArr addObject:key];
        }
    }
    return keyArr;
}

- (id)jsonValueForKeys:(NSArray *)arr {
    if (arr.count == 0) {
        return nil;
    }
    id value = [self jsonValueForKey:arr.firstObject];
    if (arr.count == 1) {
        return value;
    } else {
        return [value jsonValueForKeys:[arr subarrayWithRange:NSMakeRange(1, arr.count - 1)]];
    }
}

- (id)jsonValueForKey:(NSString *)key {
    if ([self isKindOfClass:NSDictionary.class] && key) {
        return [(NSDictionary *)self objectForKey:key];
    } else if ([self isKindOfClass:NSArray.class] && key) {
        NSInteger index = 0;
        if ([key respondsToSelector:@selector(integerValue)]) {
            index = [key integerValue];
        }
        if ([(NSArray *)self count] > index && index >= 0) {
            return [(NSArray *)self objectAtIndex:index];
        }
        return nil;
    } else if ([self isKindOfClass:NSString.class] || [self isKindOfClass:NSData.class]) {
        NSDictionary *dict = [self toDictionary];
        if (dict) {
            return [dict jsonValueForKey:key];
        }
        NSArray *arr = [self toArray];
        if (arr) {
            return [arr jsonValueForKey:key];
        }
        return nil;
    } else {
        return [self valueForKey:key];
    }
}
@end
