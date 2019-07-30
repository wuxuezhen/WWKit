//
//  NSNumber+Category.m
//  HNLandTax
//
//  Created by wzz on 2018/12/24.
//  Copyright © 2018 WYW. All rights reserved.
//

#import "NSNumber+Category.h"
//是否启用断言
#define UseAssert 0

#if UseAssert
#define MGCrashLog(text) NSAssert(NO, text)
#else
#define MGCrashLog(text) NSLog(@"\n>>>>>>>>>>>\n%@\n<<<<<<<<<<\n",text)
#endif

@implementation NSNumber (Category)

- (NSInteger)length {
    MGCrashLog(@"NSNumber length");
    return 0;
}

- (BOOL)isEqualToString:(NSString *)aString {
    MGCrashLog(@"NSNumber isEqualToString");
    return [[self stringValue] isEqualToString:aString];
}

- (id)objectForKey:(NSString *)key {
    MGCrashLog(@"NSNumber objectForKey");
    return nil;
}

- (id)objectAtIndex:(NSInteger)index {
    MGCrashLog(@"NSNumber objectAtIndex");
    return nil;
}


@end

@implementation NSNull (PLUNotCrash)

- (NSInteger)integerValue {
    MGCrashLog(@"NSNull integerValue");
    return 0;
}

- (double)doubleValue {
    MGCrashLog(@"NSNull doubleValue");
    return 0;
}

- (float)floatValue {
    MGCrashLog(@"NSNull floatValue");
    return 0;
}

- (int)intValue {
    MGCrashLog(@"NSNull intValue");
    return 0;
}

- (long long)longLongValue {
    MGCrashLog(@"NSNull longLongValue");
    return 0;
}

- (BOOL)boolValue {
    MGCrashLog(@"NSNull boolValue");
    return NO;
}

- (NSString *)stringValue {
    MGCrashLog(@"NSNull stringValue");
    return nil;
}

- (NSInteger)length {
    MGCrashLog(@"NSNull length");
    return 0;
}
@end
