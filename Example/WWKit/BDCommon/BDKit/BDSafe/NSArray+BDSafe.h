//
//  NSArray+BDSafe.h
//  MiGuKit
//
//  Created by Alfred on 2018/12/10.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (BDSafe)

- (ObjectType)bd_objectAtIndex:(NSUInteger)index;

- (NSUInteger)bd_indexOfObject:(ObjectType)anObject inRange:(NSRange)range;

- (NSUInteger)bd_indexOfObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;

- (NSArray<ObjectType> *)bd_arrayByAddingObject:(ObjectType)anObject;


- (NSArray<ObjectType> *)bd_subarrayWithRange:(NSRange)range;

- (BOOL)bd_writeToURL:(NSURL *)url error:(NSError **)error API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0));

- (NSArray<ObjectType> *)bd_objectsAtIndexes:(NSIndexSet *)indexes;

- (ObjectType)bd_objectAtIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));

@end


@interface NSMutableArray<ObjectType> (BDSafe)

- (void)bd_addObject:(ObjectType)anObject;

- (void)bd_insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

- (void)bd_removeObjectAtIndex:(NSUInteger)index;

- (void)bd_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

- (void)bd_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

- (void)bd_removeObject:(ObjectType)anObject inRange:(NSRange)range;

- (void)bd_removeObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;

- (void)bd_removeObjectsInRange:(NSRange)range;

- (void)bd_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray range:(NSRange)otherRange;

- (void)bd_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray;

- (void)bd_insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexes;

- (void)bd_removeObjectsAtIndexes:(NSIndexSet *)indexes;

- (void)bd_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<ObjectType> *)objects;

- (void)bd_setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));

@end
