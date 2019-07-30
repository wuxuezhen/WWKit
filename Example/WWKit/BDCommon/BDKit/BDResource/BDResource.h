//
//  BDResource.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/5/6.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BDResource : NSObject

+ (UIImage *)imageNamed:(NSString *)name;

+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString*)bundleName;

@end

NS_ASSUME_NONNULL_END
