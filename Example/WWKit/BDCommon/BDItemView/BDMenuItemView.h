//
//  BDMenuItemView.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/6/13.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BDMenuItemStyle) {
    BDMenuItemStyleNormal,
    BDMenuItemStyleImage,
    BDMenuItemStyleText
};
NS_ASSUME_NONNULL_BEGIN

@interface BDMenuItemView : UIView

@property (nonatomic, copy) void(^bd_selectItemBlock)(NSInteger item , NSString *title);

-(instancetype)initWithHeight:(CGFloat)height
                   minSpacing:(CGFloat)minSpacing;

-(instancetype)initWithFrame:(CGRect)frame
                       style:(BDMenuItemStyle)style
                  minSpacing:(CGFloat)minSpacing;

-(void)bd_setTitles:(NSArray *)titles
         imageNames:(NSArray *)imageNames;


@end

NS_ASSUME_NONNULL_END
