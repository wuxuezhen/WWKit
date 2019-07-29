//
//  BDGCDTimer.m
//
//  Created by wzz on 2018/3/16.
//  Copyright © 2018年 wzz. All rights reserved.
//

#import "BDGCDTimer.h"

/**
 当定时器 开启后 只可以 暂停 和 关闭
 当定时器 关闭后 只可以 重新开启
 当定时器 暂停后 只可以 恢复
 当定时器 恢复后 只可以 暂停 和 关闭
 */
typedef NS_ENUM(NSInteger,BDTimerStatus) {
    BDTimerStatusIng,       //执行中
    BDTimerStatusSuspend,   //暂停
    BDTimerStatusStop,      //关闭
};

@interface BDGCDTimer ()

@property (nonatomic, strong) dispatch_source_t gcdTimer;
@property (nonatomic, strong) dispatch_semaphore_t lock;
@property (nonatomic, assign) BOOL onFire;
@property (nonatomic, assign) BDTimerStatus timerStatus;

@end

@implementation BDGCDTimer

- (instancetype)init{
    if (self = [super init]) {
        _timeSpace = 1;
        _timerStatus = BDTimerStatusStop;
    }
    return self;
}

-(instancetype)initWithTimeSpace:(float)timeSpace{
    if (self = [super init]) {
        _timeSpace = timeSpace;
        _timerStatus = BDTimerStatusStop;
    }
    return self;
}


/**
 启动/恢复计时器
 */
- (void)bd_resume {
    if (_timerStatus == BDTimerStatusIng) {
        [self bd_failureStatus:(@"运行状态")];
    }else{
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        if (self.gcdTimer) {
            dispatch_resume(self.gcdTimer);
            _onFire = YES;
            _timerStatus = BDTimerStatusIng;
        }
        dispatch_semaphore_signal(self.lock);
    }
}

/**
 暂停
 */
- (void)bd_suspend {
    if (_timerStatus == BDTimerStatusIng) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        if (self.gcdTimer) {
            dispatch_suspend(self.gcdTimer);
            _onFire = NO;
            _timerStatus = BDTimerStatusSuspend;
        }
        dispatch_semaphore_signal(self.lock);
    }else{
        [self bd_failureStatus:(@"暂停状态")];
    }
}

/**
停止/取消
 */
- (void)bd_cancel {
    if (_timerStatus == BDTimerStatusIng) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        if (self.gcdTimer) {
            dispatch_source_cancel(self.gcdTimer);
            _timerStatus = BDTimerStatusStop;
            _onFire = NO;
            self.gcdTimer = nil;
        }
        dispatch_semaphore_signal(self.lock);
    }else{
        [self bd_failureStatus:@"非运行状态"];
    }
    
}

-(void)bd_failureStatus:(NSString *)message{
    NSArray *msgs = @[@"运行",@"暂停",@"停止"];
    NSString *tm  = [msgs[self.timerStatus] stringByAppendingFormat:@"不能改为%@",message];
    NSLog(@"%@",tm);
    self.bd_failure ? self.bd_failure() : nil;
}



#pragma mark - getter

- (dispatch_source_t)gcdTimer {
    if (!_gcdTimer) {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
//        dispatch_time_t start = dispatch_walltime(NULL, (int64_t)(0.0 * NSEC_PER_SEC));
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC));
        uint64_t interval     = (uint64_t)(_timeSpace * NSEC_PER_SEC);
        dispatch_source_set_timer(_gcdTimer, start, interval, 0);
        
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(_gcdTimer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.bd_handler) {
                    weakSelf.bd_handler();
                }
            });
        });
    }
    return _gcdTimer;
}

- (dispatch_semaphore_t)lock {
    if (!_lock) {
          //线程加锁
        _lock = dispatch_semaphore_create(1);
    }
    return _lock;
}


/**
销毁
 */
- (void)dealloc {
    if (_gcdTimer) {
        if (_onFire == NO) {
            dispatch_resume(self.gcdTimer);
        }
        [self bd_cancel];
    }
}

@end
