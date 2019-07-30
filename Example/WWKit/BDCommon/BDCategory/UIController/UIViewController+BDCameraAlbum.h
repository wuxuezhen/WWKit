//
//  UIViewController+BDCameraAlbum.h
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^bd_getImageBlock)(UIImage *);

@interface UIViewController (BDCameraAlbum)

-(void)bd_getCameraAlbumImageBlock:(bd_getImageBlock)getImageBlock;

@end

NS_ASSUME_NONNULL_END
