//
//  UIResponder+ReverseEvent.h
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/9.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+Event.h"


@interface UIResponder (ReverseEvent)

/**
 向 子视图/子控制器 发送事件
 */
- (void)routerReverseEvent:(nonnull NSString *)eventName info:(nullable id)info;

/**
 接受来自父视图/父控制器发送过来的事件
 */
- (void)registerReverseEvent:(nonnull NSString *)eventName block:(nullable EventBlock)block;


@end
