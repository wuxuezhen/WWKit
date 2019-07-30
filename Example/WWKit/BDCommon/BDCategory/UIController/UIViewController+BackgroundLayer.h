//
//  UIViewController+BackgroundLayer.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/14.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BDBackgroundStatus) {
    BDBackgroundNormal      = 0,
    BDBackgroundNoData      = 1,
    BDBackgroundBroundLayer = 2,
    BDBackgroundAll         = 3,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BackgroundLayer)

-(void)bd_createBlankLabelAndBgLayer;

-(void)bd_createBlankLabel;

-(void)bd_createBackgroundLayer;

@end

NS_ASSUME_NONNULL_END
