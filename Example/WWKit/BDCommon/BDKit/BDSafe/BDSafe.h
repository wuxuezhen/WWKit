//
//  BDSafe.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/9.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDictionary+BDSafe.h"
#import "NSArray+BDSafe.h"
NS_ASSUME_NONNULL_BEGIN
/**
 MGSafeArray
 */
@interface BDSafeArray<__covariant ObjectType> : NSObject
@property (nonatomic, weak) NSArray *originArray;
- (ObjectType _Nullable)objectAtIndexedSubscript:(NSUInteger)idx;
@end

/**
 MGSafeMutableArray
 */
@interface BDSafeMutableArray<ObjectType> : BDSafeArray<ObjectType>
- (void)setObject:(ObjectType _Nullable)obj atIndexedSubscript:(NSUInteger)idx;
@end


/**
 MGSafeDictionary
 */
@interface BDSafeDictionary<__covariant KeyType, __covariant ObjectType> : NSObject
@property (nonatomic, weak) NSDictionary *originDict;
- (ObjectType _Nullable)objectForKeyedSubscript:(KeyType<NSCopying>_Nullable)key;
@end

/**
 MGSafeMutableDictionary
 */
@interface BDSafeMutableDictionary<KeyType, ObjectType> : BDSafeDictionary<KeyType, ObjectType>
- (void)setObject:(_Nullable ObjectType)obj forKeyedSubscript:(KeyType<NSCopying>_Nullable)key;
@end

NS_ASSUME_NONNULL_END
