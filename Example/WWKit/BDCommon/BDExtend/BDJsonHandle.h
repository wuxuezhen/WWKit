//
//  BDJsonHandle.h
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJsonHandle : NSObject

/**
 获取本地json数据
 @param JsonPath 本地路径
 @return 对象
 */
+(id)toObjectWithJsonPath:(NSString *)JsonPath;

/**
 根据类型获取本地json数据
 @param dataPath 数据路径
 @param type 数据类型
 @return 对象
 */
+(id)toDataWithDataPath:(NSString *)dataPath ofType:(NSString *)type;


// 字典转成JSON 字符串
+(NSString *)toJsonStringWithDictionary:(id)dictionary;

// JSON 字符串 转字典
+(NSDictionary *)toDictionaryWithJsonString:(NSString *)jsonString ;

/**下划线转驼峰**/
+ (NSString *)_stringConverToHump:(NSString *)key;

@end
