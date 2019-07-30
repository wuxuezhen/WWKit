//
//  UIView+BDWaterLayer.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/5/22.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "UIView+BDWaterLayer.h"
#import "CommondBackgroundLayer.h"
@implementation UIView (BDWaterLayer)
-(void)bd_addWaterLayer:(CGRect)frame{
    if (!self.backLayer) {
        self.backLayer = [CommondBackgroundLayer layer];
        self.backLayer.frame = frame;
        self.backLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.backLayer setNeedsDisplay];
        [self.layer addSublayer:self.backLayer];
    }
}

- (CommondBackgroundLayer *)backLayer {
    return objc_getAssociatedObject(self, @selector(backLayer));
}

- (void)setBackLayer:(CommondBackgroundLayer *)backLayer{
    objc_setAssociatedObject(self, @selector(backLayer), backLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
