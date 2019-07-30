//
//  WWGCDTimer.h
//
//  Created by wzz on 2018/3/16.
//  Copyright © 2018年 wzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWGCDTimer : NSObject

@property (nonatomic, assign) float timeSpace;
@property (nonatomic, copy) void(^ww_handler)(void);
@property (nonatomic, copy) void(^ww_failure)(void);

/**
  初始化
 @param timeSpace 循环时间
 */
-(instancetype)initWithTimeSpace:(float)timeSpace;


/**
 启动/恢复
 */
- (void)ww_resume;


/**
 暂停
 */
- (void)ww_suspend;


/**
 停止/取消
 */
- (void)ww_cancel;

@end
