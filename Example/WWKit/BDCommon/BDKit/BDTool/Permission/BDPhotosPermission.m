//
//  BDPhotosPermission.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/7.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "BDPhotosPermission.h"
@import Photos;
@import AVFoundation;
@implementation BDPhotosPermission

+ (void)checkPhotoLibraryPermission:(void (^)(BOOL permitted))onPermittedBlock {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (onPermittedBlock) {
        if (authStatus == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    onPermittedBlock(status == PHAuthorizationStatusAuthorized);
                });
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                onPermittedBlock(authStatus == PHAuthorizationStatusAuthorized);
            });
        }
    }
}

+ (void)checkCameraPermission:(void (^)(BOOL))onPermittedBlock {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         onPermittedBlock ? onPermittedBlock(granted) : nil;
                                     });
                                 }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            onPermittedBlock ? onPermittedBlock(authStatus == AVAuthorizationStatusAuthorized) : nil;
        });
    }
}
@end

