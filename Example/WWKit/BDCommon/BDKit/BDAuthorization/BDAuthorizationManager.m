//
//  BDAuthorizationManager.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/30.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDAuthorizationManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>
#import "NSObject+CurrentNav.h"
#import "WWAppSettings.h"
#import "UIViewController+Alert.h"
#import "BDDevice.h"
@implementation BDAuthorizationManager

+ (void)requestAuthorization:(BDAuthorizationType)type
           completionHandler:(void(^)(BOOL granted, BOOL isFirst))completionHandler {
    [self requestAuthorization:type
                     showAlert:YES
             completionHandler:completionHandler];
}

+ (void)requestAuthorization:(BDAuthorizationType)type
                   showAlert:(BOOL)showAlert
           completionHandler:(void(^)(BOOL granted, BOOL isFirst))completionHandler {
    switch (type) {
        case BDAuthorizationTypePhotoLibrary: {
            PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
            BOOL isFirst = (photoAuthorStatus == PHAuthorizationStatusNotDetermined);
            if (photoAuthorStatus == PHAuthorizationStatusDenied) {
                if (completionHandler) {
                    completionHandler(NO, isFirst);
                }
                if (showAlert) {
                    [self showAlert:@"访问相册"];
                }
            } else {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completionHandler) {
                            completionHandler(status == PHAuthorizationStatusAuthorized, isFirst);
                        }
                    });
                }];
            }
        } break;
            
        case BDAuthorizationTypeCamera:
        case BDAuthorizationTypeMicrophone: {
            AVMediaType t = (type == BDAuthorizationTypeCamera ? AVMediaTypeVideo : AVMediaTypeAudio);
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:t];
            BOOL isFirst = (status == AVAuthorizationStatusNotDetermined);
            if (status == AVAuthorizationStatusDenied) {
                if (completionHandler) {
                    completionHandler(NO, isFirst);
                }
                if (showAlert) {
                    [self showAlert:(type == BDAuthorizationTypeCamera ? @"访问相机" : @"访问麦克风")];
                }
            } else {
                [AVCaptureDevice requestAccessForMediaType:t completionHandler:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completionHandler) {
                            completionHandler(granted, isFirst);
                        }
                    });
                }];
            }
        } break;
            
        case BDAuthorizationTypeContacts: {
            if (@available(iOS 9.0, *)) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                BOOL isFirst = (status == CNAuthorizationStatusNotDetermined);
                if (status == CNAuthorizationStatusDenied) {
                    if (completionHandler) {
                        completionHandler(NO, isFirst);
                    }
                    if (showAlert) {
                        [self showAlert:@"访问通讯录"];
                    }
                } else {
                    CNContactStore *contactStore = [[CNContactStore alloc] init];
                    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completionHandler) {
                                completionHandler(granted, isFirst);
                            }
                        });
                    }];
                }
            } else {
                ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
                BOOL isFirst = (status == kABAuthorizationStatusNotDetermined);
                if (status == kABAuthorizationStatusDenied) {
                    if (completionHandler) {
                        completionHandler(NO, isFirst);
                    }
                    if (showAlert) {
                        [self showAlert:@"访问通讯录"];
                    }
                } else {
                    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completionHandler) {
                                completionHandler(granted, isFirst);
                            }
                        });
                        CFRelease(addressBook);
                    });
                }
            }
        } break;
            
        case BDAuthorizationTypeCalendars:
        case BDAuthorizationTypeReminder: {
            EKEntityType t = (type == BDAuthorizationTypeCalendars ? EKEntityTypeEvent : EKEntityTypeReminder);
            EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:t];
            BOOL isFirst = (status == EKAuthorizationStatusNotDetermined);
            if (status == EKAuthorizationStatusDenied) {
                if (completionHandler) {
                    completionHandler(NO, isFirst);
                }
                if (showAlert) {
                    [self showAlert:(type == BDAuthorizationTypeCalendars ? @"访问日历" : @"访问备忘录")];
                }
            } else {
                EKEventStore *store = [[EKEventStore alloc] init];
                [store requestAccessToEntityType:t completion:^(BOOL granted, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completionHandler) {
                            completionHandler(granted, isFirst);
                        }
                    });
                }];
            }
        } break;
            
        default:
            break;
    }
}


+ (void)showAlert:(NSString *)string {
    NSString *appName = [BDDevice bd_appDisplayName] ? : [BDDevice bd_appBundleName];
    NSString *message = [NSString stringWithFormat:@"请在[设置]中允许%@%@", appName, string];
    
    [[UIApplication sharedApplication].currentNav bd_showAlertWithTitle:@"提示"
                                                                message:message
                                                 destructiveActionTitle:@"去设置"
                                                      cancelActionTitle:@"取消"
                                                          confirmAction:^{
                                                          [WWAppSettings bd_openAppSettings];
                                                      } cancelAction:nil];
}


@end

