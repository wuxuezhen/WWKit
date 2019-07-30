//
//  BDDateFormat.h
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BDDateFormatType) {
    BDDateFormatTypeNormal      =  0,
    BDDateFormatTypeTominutes,
    BDDateFormatTypeAll
};

typedef NS_ENUM(NSInteger, BDSeparatorCharStyle) {
    BDSeparatorCharStyleHoriLine    =  0,
    BDSeparatorCharStyleObliqueLine,
    BDSeparatorCharStylePoint,
    BDSeparatorCharStyleChinese
};

@interface BDDateFormat : NSObject

/**获取当前时间戳**/
+(double)bd_currentTimestamp;


/**
 根据时间字符串获取时间戳

 @param date 时间字符串
 @param format 时间样式
 @return 时间戳
 */
+(NSInteger)bd_timesampWithDate:(NSString *)date format:(NSString *)format;


/**
 根据时间字符串获取时间
 
 @param date 时间字符串
 @param format 时间样式
 @return 时间
 */
+(NSDate *)bd_dateWithTime:(NSString *)date format:(NSString *)format;


/**获取当前日历**/
+(NSDateComponents *)bd_getCurrCalender;

/**获取当前时间**/
+(NSString *)bd_currentDateFormatString:(BDDateFormatType)type
                                  Style:(BDSeparatorCharStyle)style;

/**默认格式**/
+(NSString *)bd_formatWithDefault:(double)timestamp;

/**根据日期类型和风格得到时间**/
+(NSString *)bd_dateWithTimestamp:(double)timestamp
                     FormatString:(BDDateFormatType)type
                            Style:(BDSeparatorCharStyle)style;

/**自定义格式**/
+(NSString *)bd_formateDate:(double)timestamp
                withFormate:(NSString *)formatString;

/**自定义格式 NSDate **/
+(NSString *)bd_formatWithDate:(NSDate *)date
                   withFormate:(NSString *)formatString;

+(NSDateComponents *)getconstellationWithTimeStamp:(NSTimeInterval)timeStamp;

+(NSInteger)bd_dayCountOfMonth:(NSDate *)date;

@end
