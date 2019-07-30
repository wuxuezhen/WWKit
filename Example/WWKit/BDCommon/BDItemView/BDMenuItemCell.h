//
//  BDMenuItemCell.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/26.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDMenuItemCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selectItem;
@property (nonatomic, assign) BOOL coverStyle;
@end

NS_ASSUME_NONNULL_END
