//
//  BDTextField.m
//
//  Created by 吴振振 on 2018/6/5.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import "BDTextField.h"
#import <Masonry/Masonry.h>
@interface BDTextField()
@property (nonatomic, strong) UIView *lineView;
@end
@implementation BDTextField

-(instancetype)initWithText:(NSString *)text
                       font:(UIFont *)font
                placeHolder:(NSString *)placeHolder
                  textColor:(UIColor *)textColor
                  tintColor:(UIColor *)tintColor
                  lineColor:(UIColor *)lineColor{
    
    if (self = [super init]) {
        _lineColor = lineColor;
        self.text = text;
        self.font = font;
        self.textColor = textColor;
        if (tintColor) {
             self.tintColor = tintColor;
        }
        self.placeholder = placeHolder;
        self.lineView.backgroundColor = lineColor;
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

@end
