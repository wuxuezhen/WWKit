//
//  UIDevice+RotateRrientation.h
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/8.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (RotateRrientation)

/**
 强制旋转屏幕
 */
+ (void)changeDeviceOrientation:(UIDeviceOrientation)deviceOrientation;

/**
 强制旋转屏幕到竖屏

 @param completed 旋转完成后的回调
 */
+ (void)changeDeviceOrientationToPortrait:(nullable dispatch_block_t)completed;

@end

NS_ASSUME_NONNULL_END
