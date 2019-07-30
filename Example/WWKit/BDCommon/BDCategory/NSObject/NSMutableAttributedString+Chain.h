//
//  NSMutableAttributedString+Chain.h
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/8.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MGAttributedString(_text, _color, _font) [NSAttributedString mg_attributedStringWithString:(_text) textColor:(_color) font:(_font)]
#define MGMutableAttributedString(_text, _color, _font) [NSMutableAttributedString mg_attributedStringWithString:(_text) textColor:(_color) font:(_font)]

@class MGAttributedMaker;

typedef MGAttributedMaker *_Nonnull (^MG_ShadowColor)(UIColor *_Nullable, CGSize);
typedef MGAttributedMaker *_Nonnull (^MG_AttValue)(id _Nullable value);

typedef MGAttributedMaker *_Nonnull (^MG_Range)(NSRange);
typedef MGAttributedMaker *_Nonnull (^MG_SubText)(NSString *);



@interface MGAttributedMaker : NSObject

/** 设置字体颜色(UIColor) */
@property (nonatomic, readonly) MG_AttValue _Nonnull textColor;

/** 设置字体背景颜色(UIColor) */
@property (nonatomic, readonly) MG_AttValue _Nonnull bgColor;

/** 设置字体(UIFont, @"14", @14) */
@property (nonatomic, readonly) MG_AttValue _Nonnull font;

/** 添加阴影 */
@property (nonatomic, readonly) MG_ShadowColor _Nonnull shadowColor;

/** for Range */
@property (nonatomic, readonly) MG_Range _Nonnull range;

/** for SubText */
@property (nonatomic, readonly) MG_SubText _Nonnull subText;

- (instancetype)initWithAtt:(NSMutableAttributedString *)att;

- (void)install;

@end


@interface NSMutableAttributedString (Chain)

- (NSMutableAttributedString *)mg_makeAttributed:(void(^)(MGAttributedMaker *make))block;

- (instancetype)insertImage:(UIImage *)image bounds:(CGRect)bounds atIndex:(NSUInteger)index;

@end

@interface NSAttributedString (MGCategory)

+ (instancetype _Nonnull)mg_attributedStringWithObjects:(NSAttributedString *_Nullable)string, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype _Nonnull)mg_attributedStringWithString:(NSString *_Nullable)string;

+ (instancetype _Nonnull)mg_attributedStringWithString:(NSString *_Nullable)string textColor:(UIColor *)color;

+ (instancetype _Nonnull)mg_attributedStringWithString:(NSString *_Nullable)string textColor:(UIColor *)color font:(UIFont *_Nullable)font;

+ (instancetype _Nonnull)mg_attributedStringWithImg:(UIImage *_Nullable)img bounds:(CGRect)bounds;

@end
