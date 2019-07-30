//
//  WWGCDQueue.m
//
//  Created by 吴振振 on 2019/3/28.
//  Copyright © 2019 wzz. All rights reserved.
//

#import "WWGCDQueue.h"

@implementation WWGCDQueue

#pragma mark - 任务执行方法
/**
 异步队列：异步串行serialQueue() / 异步并行concurrentQueue()
 @param block 回调
 */
void ww_async_queue(dispatch_queue_t queue, dispatch_block_t block){
    dispatch_async(queue, block);
}

/**
 异步并行
 @param block 回调
 */
void ww_async_concurrentQueue(dispatch_block_t block){
    dispatch_async(concurrentQueue(), block);
}

/**
 异步串行
 @param block 回调
 */
void ww_async_serialQueue(dispatch_block_t block){
    dispatch_async(serialQueue(), block);
}

/**
 全局异步并行
 @param block 回调
 */
void ww_async_globalQueue(dispatch_block_t block){
    dispatch_async(global_queue(), block);
}

/**
 主线程队列
 @param block 回调
 */
void ww_async_mainQueue(dispatch_block_t block) {
    dispatch_async(mainQueue(), block);
}

/**
 延时函数
 */
void ww_dispatch_after(float seconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}


#pragma mark - 队列创建方法
//串行队列（Serial Dispatch Queue）
//每次只有一个任务被执行。让任务一个接着一个地执行。（只开启一个线程，一个任务执行完毕后，再执行下一个任务）
//dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
dispatch_queue_t serialQueue(){
    return dispatch_queue_create("ww_serialQueue", DISPATCH_QUEUE_SERIAL);
}


//并发队列（Concurrent Dispatch Queue）
//可以让多个任务并发（同时）执行。（可以开启多个线程，并且同时执行任务）
//注意：并发队列的并发功能只有在异步（dispatch_async）函数下才有效
//dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
dispatch_queue_t concurrentQueue(){
    return dispatch_queue_create("ww_concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
}


//全局队列（Serial Dispatch Queue）
dispatch_queue_t global_queue(){
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

//主队列（dispatch_get_main_queue）
dispatch_queue_t mainQueue(){
     return dispatch_get_main_queue();
}


// 同步执行任务创建方法
//+(void)sync:(dispatch_queue_t)queue{
//    dispatch_sync(queue, ^{
//        // 这里放同步执行任务代码
//    });
//}
@end

