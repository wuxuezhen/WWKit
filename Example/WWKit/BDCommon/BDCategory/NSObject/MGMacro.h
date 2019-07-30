//
//  MGMacro.h
//  MiGuKit
//
//  Created by zhgz on 2018/4/19.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#ifndef MGMacro_h
#define MGMacro_h

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#ifndef YYSYNTH_DUMMY_CLASS
#define YYSYNTH_DUMMY_CLASS(_name_) \
@interface YYSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation YYSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif



#pragma mark- NavBar_StatusBar_Height_Info

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define isPad_MG ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//判断iPhoneX iPhoneXs
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad_MG : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad_MG : NO)
//判断iPhoneX iPhoneXs
#define IS_IPHONE_Xs IS_IPHONE_X
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad_MG : NO)

#define HAS_SAFEAREA (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)

//iPhoneX宏定义更新（不判断是否是iPhoneX设备，只判断有没有安全区域）
#define MG_IS_IPHONE_X HAS_SAFEAREA

// iOS系统版本
#define SYSTEM_VERSION    [[[UIDevice currentDevice] systemVersion] doubleValue]
// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT		20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT	20
// 工具栏（UINavigationController.UIToolbar）高度
#define TOOLBAR_HEIGHT 				44
// 标签栏（UITabBarController.UITabBar）高度
#define TABBAR_HEIGHT 				49
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATION_BAR_HEIGHT 		44
// STATUS_BAR_HEIGHT=SYS_STATUSBAR_HEIGHT+[HOTSPOT_STATUSBAR_HEIGHT]
#define STATUS_BAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height > 0 ? [UIApplication sharedApplication].statusBarFrame.size.height : 20)
// 根据STATUS_BAR_HEIGHT判断是否存在热点栏
#define IS_HOTSPOT_CONNECTED (STATUS_BAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)
// 无热点栏时，标准系统状态栏高度+导航栏高度
#define NORMAL_STATUS_AND_NAV_BAR_HEIGHT (SYS_STATUSBAR_HEIGHT+NAVIGATION_BAR_HEIGHT)
// 实时系统状态栏高度+导航栏高度，如有热点栏，其高度包含在STATUS_BAR_HEIGHT中。
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT+NAVIGATION_BAR_HEIGHT)
// iPhoneX底部安全区域
#define kSafeAreaBottom  (iPhoneX? 34.0f:0)
//键盘高度
#define KEYBOARD_HEIGHT       260.0

#endif /* MGMacro_h */
