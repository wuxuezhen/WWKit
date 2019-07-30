//
//  UIView+BDPosition.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/6/3.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "UIView+BDPosition.h"

@implementation UIView (BDPosition)
- (BOOL)bd_isDisplayedInScreen:(UIView *)view {
    if (view == nil) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect      = [view.superview convertRect:view.frame toView:window];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    // 若view 隐藏
    if (view.hidden) {
        return NO;
    }
    
    // 若没有superview
    if (view.superview == nil) {
        return NO;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  NO;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

@end
