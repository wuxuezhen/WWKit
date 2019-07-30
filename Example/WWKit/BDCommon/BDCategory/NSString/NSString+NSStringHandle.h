//
//  NSString+NSStringHandle.h
//
//  Created by 吴振振 on 2018/1/4.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (NSStringHandle)

/**
 获取字符串的首字母
 @return 首字母字符
 */
-(char)firstLetter;


/**
 判断字符串是不是中文
 @return YES/NO
 */
- (BOOL)isChinaFirst;


/**
 判断字符串是不是英文
 @return YES/NO
 */
- (BOOL)isEnglishFirst;

/**
 判断字符串是不是数字
 @return YES/NO
 */
- (BOOL)isNumberFirst;

/**
 中文转拼音
 @return 拼音字符串
 */
- (NSString *)transformPinYinWithChinese;

/**
 模糊搜索
 */
- (void)fuzzySearchWithDatas:(NSArray *)datas
                  completion:(void (^_Nullable)(NSArray *_Nullable ))completion;


/**
 *数字以逗号隔开 例：123，321.11
 */
- (NSString *)bd_numberSplitWithComma;

/**
 *@param puctutation 符合
 *数字以某个符合隔开 例：123，321.11
 */
- (NSString *)bd_numberSplitWithPunctutaion:(NSString *)puctutation;

/**
 最多保留小数点几位
 @param count 位数
 */
-(NSString *)bd_decimal:(NSInteger)count;


+(NSString *)bd_decimalWithValue:(double)value count:(NSInteger)count;

@end
NS_ASSUME_NONNULL_END
