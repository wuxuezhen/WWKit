//
//  UIView+Event.h
//  MiGuKit
//
//  Created by zhgz on 2018/3/28.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchBlock)(void);

@interface UIView (Event)<UIGestureRecognizerDelegate>

- (void)blockClick:(TouchBlock)block;
- (void)blockLongPress:(TouchBlock)block;
- (void)blockDoubleClick:(TouchBlock)block;
- (void)blockTwoFingerTapped:(TouchBlock)block;

@end
