//
//  NSObject+Object.h
//  HNLandTax
//
//  Created by wzz on 2018/12/24.
//  Copyright © 2018 WYW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Object)
/** *将JSON string 转化为Dictionary*/
-(NSDictionary * _Nullable)toDictionary;

/** *将JSON string 转化为Array*/
-(NSArray * _Nullable)toArray;

/**
 keyPath字符串取 字典/数组/对象 的值
 NSString *name = [dict2 jsonValueForKeyPath:@"JavaObjc.testMap.entry[0].list.DemoModel[0].name"];
 支持一下格式keyPath
 @"name"
 @"peroples[2].name"
 @"peoples[2][3].name"
 */
- (id _Nullable)jsonValueForKeyPath:(NSString *_Nullable)keyPath;

@end

NS_ASSUME_NONNULL_END
