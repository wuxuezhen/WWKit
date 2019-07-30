//
//  BDDateFormat.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "BDDateFormat.h"

@implementation BDDateFormat

/**
 请求单例
 
 @return 单例对象
 */
+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NSDateFormatter alloc] init];
        manager.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"HTK"];
    });
    return manager;
}

+(double)bd_currentTimestamp{
    return [[NSDate date] timeIntervalSince1970];
}


+(NSInteger)bd_timesampWithDate:(NSString *)date format:(NSString *)format{
    return  [[self bd_dateWithTime:date format:format] timeIntervalSince1970];
}


+(NSDate *)bd_dateWithTime:(NSString *)date format:(NSString *)format{
    [[self dateFormatter] setDateFormat:format ? :@"yyyy-MM-dd"];
    return [[self dateFormatter] dateFromString:date];
}


+(NSString *)bd_currentDateFormatString:(BDDateFormatType)type Style:(BDSeparatorCharStyle)style{
    double timeStamp = [[NSDate date] timeIntervalSince1970];
    return [self bd_formateDate:timeStamp withFormate:[self timeFormatString:type AndStyle:style]];
}


+(NSString *)bd_formatWithDefault:(double)timestamp{
    return [self bd_formateDate:timestamp withFormate:@"yyyy-MM-dd"];
}

+(NSString *)bd_dateWithTimestamp:(double)timestamp FormatString:(BDDateFormatType)type Style:(BDSeparatorCharStyle)style{
    return [self bd_formateDate:timestamp withFormate:[self timeFormatString:type AndStyle:style]];
}

+(NSString *)bd_formateDate:(double)timestamp withFormate:(NSString *)formatString{
    if (formatString == nil || formatString.length == 0) {
        formatString = @"yyyy-MM-dd";
    }
    NSDate *date=  [NSDate dateWithTimeIntervalSince1970:timestamp];
    [[self dateFormatter] setDateFormat:formatString];
    return [[self dateFormatter] stringFromDate:date];
}

+(NSString *)bd_formatWithDate:(NSDate *)date withFormate:(NSString *)formatString{
    if (formatString == nil || formatString.length == 0) {
        formatString = @"yyyy-MM-dd";
    }
    [[self dateFormatter] setDateFormat:formatString];
    return [[self dateFormatter] stringFromDate:date];
}

+(NSString *)timeFormatString:(BDDateFormatType)formatType AndStyle:(BDSeparatorCharStyle)SeparatorCharStyle{
    NSString *formatSting;
    
    switch (formatType) {
        case BDDateFormatTypeNormal:
            formatSting = @"yyyy-MM-dd";
            break;
        case BDDateFormatTypeTominutes:
            formatSting = @"yyyy-MM-dd HH:mm";
            break;
        case BDDateFormatTypeAll:
            formatSting = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            break;
    }
    
    if (SeparatorCharStyle == BDSeparatorCharStyleChinese) {
        switch (formatType) {
            case BDDateFormatTypeNormal:
                formatSting = @"yyyy年MM月dd日";
                break;
            case BDDateFormatTypeTominutes:
                formatSting = @"yyyy年MM月dd日 HH:mm";
                break;
            case BDDateFormatTypeAll:
                formatSting = @"yyyy年MM月dd日 HH:mm:ss";
                break;
            default:
                break;
        }
    }else{
        switch (SeparatorCharStyle) {
            case BDSeparatorCharStylePoint:
                formatSting =  [formatSting stringByReplacingOccurrencesOfString:@"-" withString:@"."];
                break;
            case BDSeparatorCharStyleObliqueLine:
                formatSting =  [formatSting stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                break;
            default:
                break;
        }
        
    }
    return formatSting;
}


+(NSDateComponents *)getconstellationWithTimeStamp:(NSTimeInterval)timeStamp{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                       fromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
}
+(NSDateComponents *)bd_getCurrCalender{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    return [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitWeekday|NSCalendarUnitCalendar
                       fromDate:[NSDate date]];
}

+(NSInteger)bd_dayCountOfMonth:(NSDate *)date{
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                             inUnit:NSCalendarUnitMonth
                                                            forDate:date];
    return daysInMonth.length;
}

@end
