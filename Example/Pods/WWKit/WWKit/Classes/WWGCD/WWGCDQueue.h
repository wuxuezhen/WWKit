//
//  WWGCDQueue.h
//
//  Created by 吴振振 on 2019/3/28.
//  Copyright © 2019 wzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWGCDQueue : NSObject

/**
 异步串行serialQueue() / 异步并行concurrentQueue()
 */
void ww_async_queue(dispatch_queue_t queue, dispatch_block_t block);

/**
 异步并行
 */
void ww_async_concurrentQueue(dispatch_block_t block);

/**
 异步串行
 */
void ww_async_serialQueue(dispatch_block_t block);

/**
 全局异步并行
 */
void ww_async_globalQueue(dispatch_block_t block);

/**
 主线程队列
 */
void ww_async_mainQueue(dispatch_block_t block);

/**
 延时函数
 */
void ww_dispatch_after(float seconds, dispatch_block_t block);

//串行队列（Serial Dispatch Queue）
dispatch_queue_t serialQueue(void);

//并发队列（Concurrent Dispatch Queue）
dispatch_queue_t concurrentQueue(void);

@end

NS_ASSUME_NONNULL_END
