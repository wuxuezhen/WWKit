//
//  UITabBar+CustomerTabBar.m
//  TuoDian
//
//  Created by wxz on 2017/8/18.
//  Copyright © 2017年 wxz. All rights reserved.
//

#import "UITabBar+CustomerTabBar.h"

@implementation UITabBar (CustomerTabBar)

- (void)showBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
   
    UILabel *label = [[UILabel alloc]init];
    label.tag = 1000+index;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //计算小红点的X值，根据第index控制器，小红点在每个tabbar按钮的中部偏移0.1，即是每个按钮宽度的0.6倍
    CGFloat percentX      = (index+0.64);
    CGFloat tabBarButtonW = CGRectGetWidth(tabFrame)/self.items.count;
    CGFloat x             = percentX * tabBarButtonW;
    CGFloat y             = 0.1 * CGRectGetHeight(tabFrame);
   
    label.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:label];
    [self bringSubviewToFront:label];
}

/**
 隐藏红点
 
 @param index 第几个控制器隐藏，从0开始算起
 */
- (void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

/**
 移除控件
 
 @param index 第几个控制器要移除控件，从0开始算起
 */
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 1000+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
