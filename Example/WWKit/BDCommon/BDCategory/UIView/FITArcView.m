//
//  FITArcView.m
//  FitBody
//
//  Created by caiyi on 2018/8/29.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "FITArcView.h"

@interface FITArcView ()

@property (assign, nonatomic) CGFloat imageviewAngle;

@end

@implementation FITArcView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self startAnimation];
    }
    return self;
}


- (void)startAnimation{
    
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = 1;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [self.layer addAnimation:animation forKey:@"rotate"];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                     radius:15
                                                 startAngle:0
                                                   endAngle:M_PI*1.7
                                                  clockwise:YES].CGPath;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound; //线条拐角
    shapeLayer.lineJoin = kCALineJoinRound; //终点处理
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask = shapeLayer;
    
    //    非渐变颜色
    //    UIColor *color = [UIColor blueColor];
    //    [color set]; //设置线条颜色
    //
    //    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
    //                                                         radius:15
    //                                                     startAngle:0
    //                                                       endAngle:M_PI*1.7
    //                                                      clockwise:YES];
    //    aPath.lineWidth = 1.0;
    //    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    //    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    //
    //    [aPath stroke];
    
}

@end
