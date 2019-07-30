//
//  BDLabel.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2018/3/2.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HandleStyle) {
    HandleStyleNone       = 0,
    HandleStyleUser       = 1,
    HandleStyleTopic      = 2,
    HandleStyleLink       = 3,
    HandleStyleAgreement  = 4,
    HandleStyleUserDefine = 5
};

@class BDLabel;

@protocol BDLabelDelegate <NSObject>

-(void)bd_label:(BDLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(HandleStyle)style inRange:(NSRange)range;

@end


@interface BDLabel : UILabel

/** 普通文字颜色 */
@property(nonatomic, strong) UIColor *jm_textColor;

/** 话题文字大小 */
@property(nonatomic, strong)UIFont *topicFont;

/* 行距 */
@property(nonatomic, assign)CGFloat spacing;

/** 选中是高亮背景色 */
@property(nonatomic, strong) UIColor *jm_textHightLightBackGroundColor;

/** 自定义要高亮匹配的 字符串+显示颜色 字典数组, 请把要匹配的文字用string这个key存入字典, 把要高亮的颜色用color这个key存入字典, 具体见demo */
@property(nonatomic, strong) NSArray <NSDictionary *> *jm_matchArr;

/** 点击事件block */
@property(nonatomic, copy) void (^handleTapBlock) (UILabel *, HandleStyle, NSString *, NSRange);
/** 代理 */
@property(nonatomic, weak) id<BDLabelDelegate>  delegate;

/** 给不同种类的高亮文字设置颜色 */
-(void)setHightLightTextColor:(UIColor *)hightLightColor forHandleStyle:(HandleStyle)handleStyle;

@end
