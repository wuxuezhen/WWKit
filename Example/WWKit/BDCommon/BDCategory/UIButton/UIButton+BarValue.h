//
//  UIButton+BarValue.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/4.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BarValue)
- (void)showBadge:(NSString *)text;
- (void)showBadgeWithSport:(NSInteger)num;
- (void)hideBadge;
@end
