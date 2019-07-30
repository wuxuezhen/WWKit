//
//  BDMenuView.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/26.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BDMenuStyle) {
    BDMenuStyleNormal,
    BDMenuStyleCover
};
NS_ASSUME_NONNULL_BEGIN

@interface BDMenuView : UIView
@property (nonatomic, strong) NSArray    *titles;
@property (nonatomic, assign) NSInteger   selectItem;
@property (nonatomic, assign) CGFloat     fontSize;
@property (nonatomic, assign) BDMenuStyle style;
@property (nonatomic, assign) BOOL        hiddenLine;

@property (nonatomic, copy) void (^bd_selectBlock) (NSInteger item, NSString *title);

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
-(instancetype)initWithTitles:(NSArray *)titles;
-(instancetype)initWithTitles:(NSArray *)titles height:(CGFloat)itemHeight;

@end

NS_ASSUME_NONNULL_END
