//
//  NSString+VideoSave.m
//  HNLandTax
//
//  Created by caiyi on 2018/9/12.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "NSString+VideoSave.h"
#import <Photos/Photos.h>
#import "BDTip.h"
@implementation NSString (VideoSave)
-(void)jm_saveVideoToAlbums{
    
    // 1.获取用户授权状态,状态有四种
    // 1) PHAuthorizationStatusNotDetermined  不确定
    // 2) PHAuthorizationStatusRestricted, 家长控制,拒绝
    // 3) PHAuthorizationStatusDenied, 拒绝
    // 4) PHAuthorizationStatusAuthorized 授权
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self savePhoto];
                }
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized:
            [self savePhoto];
            break;
        default:{
            dispatch_async(dispatch_get_main_queue(), ^{
                [BDTip showCenterWithText:@"进入设置界面->找到当前应用->打开允许访问相册开关"];
            });
        }
            break;
    }
    
}

#pragma mark - 保存图片的方法

- (void)savePhoto {
    
    //修改系统相册用PHPhotoLibrary单例,调用performChanges,否则苹果会报错,并提醒你使用
    static NSString *title = @"我的";
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // 调用判断是否已有该名称相册
        PHAssetCollection *assetCollection = [self fetchAssetColletion:title];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        
        if (assetCollection) {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        }
        
        // 2.保存你需要保存的图片到系统相册
        NSURL *url = [NSURL fileURLWithPath:self];
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
        
        // 3.把创建好图片添加到自己相册
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        [assetCollectionChangeRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [BDTip showCenterWithText:@"保存失败"];
            } else {
                [BDTip showCenterWithText:@"保存成功"];
            }
        });
        
    }];
    
}

#pragma mark - 该方法获取在图库中是否已经创建该App的相册

- (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle {
    // 获取所有的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                     subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                     options:nil];
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

@end
