//
//  BDProgressCircleView.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/5/28.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDProgressCircleView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign,getter=isGradual) BOOL gradual;

/**
 @param gradual 开启渐变,默认关闭;
 */
- (void)setGradual:(BOOL)gradual;
/**
 @param progress 进度 [0,1],默认开启
 */
- (void)setProgress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
