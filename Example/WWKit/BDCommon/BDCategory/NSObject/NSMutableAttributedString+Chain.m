//
//  NSMutableAttributedString+Chain.m
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/8.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import "NSMutableAttributedString+Chain.h"

@interface MGAttributed : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *attributedValues;
@property (nonatomic, strong) NSString *subText;
@property (nonatomic, assign) NSRange range;
@end

@implementation MGAttributed
- (NSMutableDictionary<NSAttributedStringKey,id> *)attributedValues {
    if (!_attributedValues) {
        _attributedValues = [NSMutableDictionary dictionary];
    }
    return _attributedValues;
}
@end

@interface MGAttributedMaker (){
    NSMutableAttributedString *_attString;
}
@property (nonatomic, strong) NSMutableSet<MGAttributed *> *attributedSet;
@property (nonatomic, strong) MGAttributed *tempAtt;
@end

@implementation MGAttributedMaker

- (instancetype)initWithAtt:(NSMutableAttributedString *)att {
    if (self = [super init]) {
        _attString = att;
    }
    return self;
}

- (MG_AttValue)colorWithKey:(NSAttributedStringKey)key {
    return ^(id color) {
        if (color) {
            UIColor *c = nil;
            if ([color isKindOfClass:UIColor.class]) {
                c = color;
            }
            if (c) {
                self.tempAtt.attributedValues[key] = c;
                [self saveAttNeedClean:NO];
            }
        }
        return self;
    };
}

- (MG_AttValue)textColor {
    return [self colorWithKey:NSForegroundColorAttributeName];
}

- (MG_AttValue)bgColor {
    return [self colorWithKey:NSBackgroundColorAttributeName];
}

- (MG_ShadowColor)shadowColor {
    return ^(UIColor *color, CGSize offset) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = offset;
        shadow.shadowColor = color;
        self.tempAtt.attributedValues[NSShadowAttributeName] = shadow;
        [self saveAttNeedClean:NO];
        return self;
    };
}

- (MG_AttValue)font {
    return ^(id font) {
        UIFont *f = nil;
        if ([font isKindOfClass:UIFont.class]) {
            f = font;
        } else if ([font respondsToSelector:@selector(floatValue)]) {
            f = [UIFont systemFontOfSize:[font floatValue]];
        }
        if (f) {
            self.tempAtt.attributedValues[NSFontAttributeName] = f;
            [self saveAttNeedClean:NO];
        }
        return self;
    };
}

- (MG_Range)range {
    return ^(NSRange range) {
        self.tempAtt.range = range;
        [self saveAttNeedClean:YES];
        return self;
    };
}

- (MG_SubText)subText {
    return ^(NSString *subText) {
        self.tempAtt.subText = subText;
        [self saveAttNeedClean:YES];
        return self;
    };
}

- (void)saveAttNeedClean:(BOOL)needClean {
    [self.attributedSet addObject:self.tempAtt];
    if (needClean) {
        _tempAtt = nil;
    }
}

- (NSMutableSet<MGAttributed *> *)attributedSet {
    if (!_attributedSet) {
        _attributedSet = [NSMutableSet set];
    }
    return _attributedSet;
}

- (MGAttributed *)tempAtt {
    if (!_tempAtt) {
        _tempAtt = [MGAttributed new];
    }
    return _tempAtt;
}

- (void)install {
    NSSet<MGAttributed *> *set = self.attributedSet;
    for (MGAttributed *att in set) {
        NSArray<NSAttributedStringKey> *keys = att.attributedValues.allKeys;
        if (att.subText.length > 0) {
            for (NSString *key in keys) {
                [self addAttribute:key value:att.attributedValues[key] forSubText:att.subText];
            }
        } else {
            for (NSString *key in keys) {
                [self addAttribute:key value:att.attributedValues[key] range:att.range];
            }
        }
        
    }
}

- (void)addAttribute:(NSAttributedStringKey)key value:(id)value forSubText:(NSString *)text {
    if (!key || !value || !text) {
        return;
    }
    if (text.length > 0) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:text options:0 error:nil];
        NSArray *array = [regex matchesInString:_attString.string options:0 range:NSMakeRange(0, _attString.length)];
        for (NSInteger i = array.count - 1; i >=0; --i) {
            NSTextCheckingResult *result = array[i];
            [self addAttribute:key value:value range:result.range];
        }
    }
}

- (void)addAttribute:(NSAttributedStringKey)key value:(id)value range:(NSRange)range {
    if (!key || !value) {
        return;
    }
    if (range.length + range.location > _attString.length) {
        NSString *str = [NSString stringWithFormat:@"%@ > %ld", NSStringFromRange(range), _attString.length];
        NSAssert(NO, str);
    } else {
        if (range.location + range.length == 0) {
            range = NSMakeRange(0, _attString.length);
        }
        [_attString addAttribute:key value:value range:range];
    }
    
}

@end

@implementation NSMutableAttributedString (Chain)

- (NSMutableAttributedString *)mg_makeAttributed:(void(^)(MGAttributedMaker *make))block {
    if (block) {
        MGAttributedMaker *maker = [[MGAttributedMaker alloc] initWithAtt:self];
        block(maker);
        [maker install];
    }
    return self;
}

- (instancetype)insertImage:(UIImage *)image bounds:(CGRect)bounds atIndex:(NSUInteger)index {
    if (image) {
        if (index > self.length) {
            NSAssert(NO, @"index参数越界");
            return self;
        }
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = bounds;
        NSAttributedString *imgAtt = [NSAttributedString attributedStringWithAttachment:attachment];
        [self insertAttributedString:imgAtt atIndex:index];
    }
    return self;
}

@end

@implementation NSAttributedString (MGCategory)

+ (instancetype)mg_attributedStringWithObjects:(NSAttributedString *)string, ... {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    if (!string) {
        return str;
    }
    [str appendAttributedString:string];
    va_list args;
    va_start(args, string);
    if (string) {
        NSAttributedString *otherString;
        while (YES) {
            otherString = va_arg(args, NSAttributedString *);
            if(!otherString) {
                break;
            } else if(otherString.length > 0) {
                [str appendAttributedString:otherString];
            }
        }
    }
    va_end(args);
    return str;
}

+ (instancetype)mg_attributedStringWithString:(NSString *)string {
    return [self mg_attributedStringWithString:string textColor:nil font:nil];
}

+ (instancetype)mg_attributedStringWithString:(NSString *)string textColor:(UIColor *)color {
    return [self mg_attributedStringWithString:string textColor:color font:nil];
}

+ (instancetype)mg_attributedStringWithString:(NSString *)string textColor:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (color) { attributes[NSForegroundColorAttributeName] = color; }
    if (font) { attributes[NSFontAttributeName] = font; }
    return [[self alloc] initWithString:string ?: @"" attributes:attributes];
}

+ (instancetype _Nonnull)mg_attributedStringWithImg:(UIImage *_Nullable)img bounds:(CGRect)bounds {
    if (img) {
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = img;
        attachment.bounds = bounds;
        return [NSAttributedString attributedStringWithAttachment:attachment];
    } else {
        return [[NSAttributedString alloc] init];
    }
}


@end
