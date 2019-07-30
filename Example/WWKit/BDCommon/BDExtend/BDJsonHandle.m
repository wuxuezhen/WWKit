//
//  BDJsonHandle.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "BDJsonHandle.h"

@implementation BDJsonHandle

+(id)toObjectWithJsonPath:(NSString *)JsonPath{
    NSError  *error = nil;
    NSData   *data  = [self toDataWithDataPath:JsonPath ofType:@"json"];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

+(id)toDataWithDataPath:(NSString *)dataPath ofType:(NSString *)type{
    NSString *path  = [[NSBundle mainBundle] pathForResource:dataPath ofType:type];
    return [NSData dataWithContentsOfFile:path];
}


// 字典转成JSON 字符串
+(NSString *)toJsonStringWithDictionary:(id)dictionary {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// JSON 字符串 转字典
+ (NSDictionary *)toDictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil || [jsonString isEqualToString:@""]) {
        return nil;
    }
    NSData       *jsonData   = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError      *error      = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dictionary;
}

+ (NSString *)_stringConverToHump:(NSString *)key {
    NSMutableString *str = [NSMutableString stringWithString:key];
    while ([str containsString:@"_"]) {
        NSRange range = [str rangeOfString:@"_"];
        if (range.location + 1 < [str length]) {
            char c = [str characterAtIndex:range.location+1];
            [str replaceCharactersInRange:NSMakeRange(range.location, range.length+1)
                               withString:[[NSString stringWithFormat:@"%c",c] uppercaseString]];
        }
    }
    return str;
}

@end
