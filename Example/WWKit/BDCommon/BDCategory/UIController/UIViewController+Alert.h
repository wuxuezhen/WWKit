//
//  UIViewController+Alert.h
//  bdBody
//
//  Created by caiyi on 2018/8/29.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)


/*** 中间弹窗 包含确定、取消两个事件 **/
- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                confirmAction:(void (^)(void))confirmAciton
                 cancelAction:(void (^)(void))cancelAciton;


/**
 中间弹窗 包含两个事件 可自定义标题
 */
- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
       destructiveActionTitle:(NSString *)destructiveTitle
            cancelActionTitle:(NSString *)cancelTitle
                confirmAction:(void (^)(void))confirmAciton
                 cancelAction:(void (^)(void))cancelAciton;


/*** 中间弹窗仅确定事件 **/
- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                confirmAction:(void (^)(void))confirmAciton;

/*** 中间弹窗一个事件 可自定义标题 **/
- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  actionTitle:(NSString *)actionTitle
                confirmAction:(void (^)(void))confirmAciton;

@end

