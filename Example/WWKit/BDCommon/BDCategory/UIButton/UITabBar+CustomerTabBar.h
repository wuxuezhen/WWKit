//
//  UITabBar+CustomerTabBar.h
//  TuoDian
//
//  Created by wxz on 2017/8/18.
//  Copyright © 2017年 wxz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (CustomerTabBar)

- (void)showBadgeOnItemIndex:(int)index;

- (void)hideBadgeOnItemIndex:(int)index;

@end
