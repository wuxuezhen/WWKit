//
//  BDDateSelectView.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/29.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
BD_EVENT_KEY(BDPreNextDayEventKey)
BD_EVENT_KEY(BDPickDateEventKey)
@interface BDDateSelectView : UIView
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSDate *maxDate;
@end

NS_ASSUME_NONNULL_END
