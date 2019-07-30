//
//  UIButton+BarValue.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/4.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "UIButton+BarValue.h"

@implementation UIButton (BarValue)
- (void)showBadge:(NSString *)text{
    [self removeBadge];
    
    UILabel *label = [[UILabel alloc]init];
    label.tag = 1000;
    label.clipsToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:11];
    
    CGRect tabFrame = self.frame;
    
    //计算小红点的X值，根据第index控制器，小红点在每个tabbar按钮的中部偏移0.1，即是每个按钮宽度的0.6倍
    CGFloat percentX      = 0.8;
    CGFloat tabBarButtonW = CGRectGetWidth(tabFrame);
    CGFloat x             = percentX * tabBarButtonW;
    CGFloat y             = 0.1 * CGRectGetHeight(tabFrame);
    
    label.text = text;
    [label sizeToFit];
    
    CGRect frame = label.frame;
    label.frame = CGRectMake(x, y, MAX(frame.size.width, frame.size.height)+2, frame.size.height+2);
    label.layer.cornerRadius = frame.size.height/2;
    
    [self addSubview:label];
    [self bringSubviewToFront:label];
}

- (void)showBadgeWithSport:(NSInteger)num{
    [self removeBadge];
    
    UILabel *label = [[UILabel alloc]init];
    label.tag = 1000;
    label.clipsToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:11];
    
    CGRect tabFrame = self.frame;
    
    //计算小红点的X值，根据第index控制器，小红点在每个tabbar按钮的中部偏移0.1，即是每个按钮宽度的0.6倍
    CGFloat percentX      = 0.65;
    CGFloat tabBarButtonW = CGRectGetWidth(tabFrame);
    CGFloat x             = percentX * tabBarButtonW;
    CGFloat y             = -5;
    
    label.text = [NSString stringWithFormat:@"%@",@(num)];
    [label sizeToFit];
    
    CGRect frame = label.frame;
    label.frame = CGRectMake(x, y, MAX(frame.size.width, frame.size.height)+5, frame.size.height+3);
    label.layer.cornerRadius = frame.size.height/2;
    
    [self addSubview:label];
    [self bringSubviewToFront:label];
}

/**
 隐藏
 */
- (void)hideBadge{
    [self removeBadge];
}

/**
 移除控件
*/
- (void)removeBadge{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
}

@end
