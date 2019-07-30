//
//  BDKeyManager.h
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *BDSystemVersion    = @"CFBundleShortVersionString";
static NSString *BDSystemBuild      = @"CFBundleVersion";
static NSString *BDBundleIdentifier = @"CFBundleIdentifier";
static NSString *BDAppDisplayName   = @"CFBundleDisplayName";
static NSString *BDAppBundleName    = @"CFBundleName";

static NSString *AppStoreURL       = @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1175471973";
static NSString *AppStoreAppraiseURL = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1175471973&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8";


static NSString *BDOpenLocationMessage = @"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)";
static NSString *BDIPhoneMap           = @"苹果自带地图";

@interface BDKeyManager : NSObject

@end
