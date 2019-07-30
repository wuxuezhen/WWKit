//
//  BDPhotosPermission.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/7.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPhotosPermission : NSObject
+ (void)checkPhotoLibraryPermission:(void (^)(BOOL permitted))onPermittedBlock;
+ (void)checkCameraPermission:(void (^)(BOOL permitted))onPermittedBlock;
@end
