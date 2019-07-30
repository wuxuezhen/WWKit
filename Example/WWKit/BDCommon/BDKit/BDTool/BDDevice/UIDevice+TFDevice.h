//
//  UIDevice+TFDevice.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/24.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (TFDevice)
/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end

NS_ASSUME_NONNULL_END
