//
//  UIViewController+BackgroundLayer.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/14.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "UIViewController+BackgroundLayer.h"
#import "CommondBackgroundLayer.h"

@interface UIViewController ()
@property (nonatomic, strong) UILabel *blankLabel;
@property (nonatomic, strong) CommondBackgroundLayer *bgLayer;
@end

@implementation UIViewController (BackgroundLayer)


-(void)bd_createBlankLabelAndBgLayer{
    [self bd_createBlankLabel];
    [self bd_createBackgroundLayer];
}

-(void)bd_createBlankLabel{
    if (!self.blankLabel) {
        self.blankLabel = [[UILabel alloc] init];
        self.blankLabel.textAlignment = NSTextAlignmentCenter;
        self.blankLabel.font = [UIFont systemFontOfSize:17];
        self.blankLabel.textColor = [UIColor grayColor];
        self.blankLabel.text = @"数据暂未对外开放";
        
        [self.view addSubview:self.blankLabel];
        [self.blankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
    }
}

-(void)bd_createBackgroundLayer{
    if (!self.bgLayer) {
        self.bgLayer = [CommondBackgroundLayer layer];
        self.bgLayer.frame = self.view.frame;
        self.bgLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.bgLayer setNeedsDisplay];
        [self.view.layer addSublayer:self.bgLayer];
    }
}


#pragma mark - abjc runtime
- (UILabel *)blankLabel {
    return objc_getAssociatedObject(self, @selector(blankLabel));
}

- (void)setBlankLabel:(UILabel *)blankLabel {
    objc_setAssociatedObject(self, @selector(blankLabel), blankLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CommondBackgroundLayer *)bgLayer {
    return objc_getAssociatedObject(self, @selector(bgLayer));
}

- (void)setBgLayer:(CommondBackgroundLayer *)bgLayer{
    objc_setAssociatedObject(self, @selector(bgLayer), bgLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

