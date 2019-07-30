//
//  BDChartWebViewController.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/24.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDChartWebViewController : RootViewController

-(instancetype)initWithParams:(NSDictionary *)params;

// 参数1 json
@property (nonatomic, copy) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
