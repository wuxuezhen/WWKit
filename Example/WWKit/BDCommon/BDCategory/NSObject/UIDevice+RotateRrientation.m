//
//  UIDevice+RotateRrientation.m
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/8.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import "UIDevice+RotateRrientation.h"

@implementation UIDevice (RotateRrientation)

+ (void)changeDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    [UIDevice.currentDevice setValue:@(UIDeviceOrientationFaceUp) forKey:@"orientation"];
    [UIDevice.currentDevice setValue:@(deviceOrientation) forKey:@"orientation"];
}

+ (void)changeDeviceOrientationToPortrait:(dispatch_block_t)completed {
    CGFloat delay = 0.0;
    if (!UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        [self changeDeviceOrientation:UIDeviceOrientationPortrait];
        delay = 0.3;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(),^(){
        if (completed) {
            completed();
        }
    });
}

@end
