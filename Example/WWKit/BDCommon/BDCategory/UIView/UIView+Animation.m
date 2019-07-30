//
//  UIView+Animation.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/3/6.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

-(void)bd_addAnimationMoveDown{
    CGPoint center = self.center;
    CGFloat startp = self.center.y - CGRectGetHeight(self.frame);
    CGFloat endp   = self.center.y;
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(center.x, startp)];
    anima1.toValue   = [NSValue valueWithCGPoint:CGPointMake(center.x, endp)];
    anima1.duration  = 0.3f;
    anima1.fillMode  = kCAFillModeForwards;
    anima1.removedOnCompletion = YES;
    // 设置动画执行时间
    [self.layer addAnimation:anima1 forKey:nil];
}

-(void)bd_addAnimationMoveUpForDelegate:(id)delegate{
    CGPoint center = self.center;
    CGFloat endp   = center.y - CGRectGetHeight(self.frame);
    CGFloat startp = self.center.y;
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(center.x, startp)];
    anima1.toValue   = [NSValue valueWithCGPoint:CGPointMake(center.x, endp)];
    anima1.delegate = delegate;
    anima1.duration  = 0.3f;
    anima1.fillMode  = kCAFillModeForwards;
    anima1.removedOnCompletion = YES;
    // 设置动画执行时间
    [self.layer addAnimation:anima1 forKey:@"rmAnimation"];
}
@end
