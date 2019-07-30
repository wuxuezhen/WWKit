//
//  NSString+NSStringHandle.m
//
//  Created by 吴振振 on 2018/1/4.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import "NSString+NSStringHandle.h"

@implementation NSString (NSStringHandle)


/**
 获取字符串的首字母
 @return 首字母字符
 */
-(char)firstLetter{
    char firstChar;
    if ([self isChinaFirst]){
        NSString *pinyinName = [self transformPinYinWithChinese];
        firstChar = [pinyinName characterAtIndex:0];
    }else{
        if ([self isEnglishFirst]){
            NSString *subString = [[self substringWithRange:NSMakeRange(0, 1)] uppercaseString];
            firstChar = [subString characterAtIndex:0];
        }else{
            firstChar = '#';
        }
    }
    return firstChar;
}


/**
 判断字符串是不是中文
 @return YES/NO
 */
- (BOOL)isChinaFirst{
    if (self.length == 0) return NO;
    //判断是不是以字母开头
    //是否以中文开头（unicode中文编码范围是0x4e00 ～ 0x9fa5）
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [self getBytes:buffer
                  maxLength:2
                 usedLength:NULL
                   encoding:NSUTF16LittleEndianStringEncoding
                    options:NSStringEncodingConversionExternalRepresentation
                      range:range remainingRange:NULL];
    
    return (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5));
}


/**
 判断字符串是不是英文
 @return YES/NO
 */
- (BOOL)isEnglishFirst{
    if (self.length == 0) return NO;
    NSString *ZIMU = @"^[A-Za-z ]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ZIMU];
    return [regextestA evaluateWithObject:self];
}

/**
 判断字符串是不是数字
 @return YES/NO
 */
- (BOOL)isNumberFirst{
    if (self.length == 0) return NO;
    NSString *ZIMU = @"^[0-9]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ZIMU];
    return [regextestA evaluateWithObject:self];
}

/**
 中文转拼音
 @return 拼音字符串
 */
- (NSString *)transformPinYinWithChinese{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

/**
 模糊搜索
 */
-(void)fuzzySearchWithDatas:(NSArray *)datas
                completion:(void (^_Nullable)(NSArray *_Nullable ))completion{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        NSString *pykey = [self isEnglishFirst] ? self : [self transformPinYinWithChinese];
        
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
        
        for (NSString *obj in datas) {
            if ([obj rangeOfString:self options:NSCaseInsensitiveSearch].length > 0) {
                [results addObject:obj];
            }
        }
        
        if (self.length == 1 && ([self isEnglishFirst] || [self isNumberFirst])) {
            for (NSString *obj in datas) {
                if (![results containsObject:obj]) {
                    NSString *pinyin = [obj transformPinYinWithChinese];
                    if ([pinyin firstLetter] == [pykey characterAtIndex:0]) {
                        [results addObject:obj];
                    }
                }
            }
        }else{
            for (NSString *obj in datas) {
                if (![results containsObject:obj]) {
                    if ([obj isEnglishFirst]) {
                        if ([obj rangeOfString:pykey options:NSCaseInsensitiveSearch].length > 0) {
                            [results addObject:obj];
                        }
                    }else{
                        NSString *pinyin = [obj transformPinYinWithChinese];
                        if ([pinyin rangeOfString:pykey options:NSCaseInsensitiveSearch].length > 0) {
                            [results addObject:obj];
                        }
                    }
                }
            }
         }
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                completion ? completion(results) : nil;
            });
       
     
    });
}


/**
 *数字以逗号隔开 例：123，321.11
 */
- (NSString *)bd_numberSplitWithComma{
    if ([self bd_isNumber]) {
        NSMutableString *muString = [NSMutableString stringWithString:self];
        return [self bd_insert:muString withPunctuation:@","];
    }else{
        return self;
    }
}

- (NSString *)bd_numberSplitWithPunctutaion:(NSString *)puctutation{
    if ([self bd_isNumber]) {
        NSMutableString *muString = [NSMutableString stringWithString:self];
        return [self bd_insert:muString withPunctuation:puctutation];
    }else{
        return self;
    }
}

- (NSMutableString *)bd_insert:(NSMutableString *)string withPunctuation:(NSString *)punctuation{
    NSUInteger maxLength = string.length;
    if ([string containsString:punctuation]) {
        maxLength = [string rangeOfString:punctuation].location;
    }else if ([string containsString:@"."]){
        maxLength = [string rangeOfString:@"."].location;
    }
    if (maxLength-([string containsString:@"-"]?1:0)>3) {
        [string insertString:punctuation atIndex:(maxLength-3)];
        [self bd_insert:string withPunctuation:punctuation];
    }else{
        return string;
    }
    return string;
}

- (Boolean)bd_isNumber{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[-0-9.]*$"];
    if ([predicate evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


/**
 最多保留小数点几位
 @param count 位数
 */
-(NSString *)bd_decimal:(NSInteger)count{
    if (self && [self containsString:@"."]) {
        NSString *lastStr  = [self componentsSeparatedByString:@"."].lastObject;
        if (lastStr.length > count) {
            NSString *format = [@"%." stringByAppendingFormat:@"%@f",@(count)];
            return [NSString stringWithFormat:format,self.doubleValue];
        }else{
            return self;
        }
    }else{
        return self;
    }
    
}

+(NSString *)bd_decimalWithValue:(double)value count:(NSInteger)count{
    return [[NSNumber numberWithDouble:value].stringValue bd_decimal:count];
}
@end
