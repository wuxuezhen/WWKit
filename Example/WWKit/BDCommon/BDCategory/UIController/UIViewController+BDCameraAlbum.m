//
//  UIViewController+BDCameraAlbum.m
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#import "UIViewController+BDCameraAlbum.h"
#import "UIViewController+FITAppSettings.h"
#import "UIViewController+LoadingHud.h"
#import "UIViewController+Alert.h"
#import "BDTip.h"
#import "BDPhotosPermission.h"
#import <objc/runtime.h>
@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, copy) bd_getImageBlock imageBlock;

@end
@implementation UIViewController (BDCameraAlbum)

#pragma mark - 添加图片

-(void)bd_getCameraAlbumImageBlock:(bd_getImageBlock)getImageBlock{
    self.imageBlock = getImageBlock;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *setAlert = [UIAlertAction actionWithTitle:@"拍照"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [self callCameraOrPhotoWithType:UIImagePickerControllerSourceTypeCamera];
                                                     }];
    
    UIAlertAction *PhoneAlert = [UIAlertAction actionWithTitle:@"从相册选择"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self callCameraOrPhotoWithType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                       }];
    UIAlertAction *hidAlert = [UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alert addAction:setAlert];
    [alert addAction:PhoneAlert];
    [alert addAction:hidAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma UIImagePickerControllerDelegate
//相册或则相机选择上传的实现
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:NO completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageBlock(image);
    }];
}



//选择照片
-(void)callCameraOrPhotoWithType:(UIImagePickerControllerSourceType)sourceType{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [BDPhotosPermission checkCameraPermission:^(BOOL permitted) {
            if (!permitted) {
                [self bd_showAlertWithTitle:@"请打开设置，允许使用相机"
                                    message:@"打开设置，开启相机权限"
                              confirmAction:^{
                                  [self fit_openAppSettings];
                              } cancelAction:^{
                                  
                              }];
                return ;
            }
            BOOL isCamera = YES;
            if (sourceType == UIImagePickerControllerSourceTypeCamera) {//判断是否有相机
                isCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
            }
            if (isCamera) {
                [self openCameraOrPhotoWithType:sourceType];
            } else {
                [BDTip showCenterWithText:@"请查看相机是否启用"];
            }
            
        }];
        
    }else{
        [BDPhotosPermission checkPhotoLibraryPermission:^(BOOL permitted) {
            if (!permitted) {
                [self bd_showAlertWithTitle:@"请打开设置，允许使用照片"
                                    message:@"打开设置，开始照片权限"
                              confirmAction:^{
                                  [self fit_openAppSettings];
                              } cancelAction:^{
                                  
                              }];
                return ;
            }
            [self openCameraOrPhotoWithType:sourceType];
            
        }];
    }
}

-(void)openCameraOrPhotoWithType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;//为NO，则不会出现系统的编辑界面
    imagePicker.sourceType = sourceType;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - 类别添加属性
- (bd_getImageBlock)imageBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageBlock:(bd_getImageBlock)imageBlock {
    objc_setAssociatedObject(self, @selector(imageBlock), imageBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

