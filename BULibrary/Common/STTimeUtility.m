//
//  STTimeUtility.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/18.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "STTimeUtility.h"

@implementation STTimeUtility
+ (NSString *)GetCurrentDate
{
    NSDate *pDate = [NSDate date];
    NSDateFormatter *pDF = [[NSDateFormatter alloc]init];
    [pDF setDateFormat:@"yyyy-MM-dd"];
    return [pDF stringFromDate:pDate];
}

+ (NSString*)GetTimeLabelString:(NSDate*)argTime
{
    // Get the calender
    NSCalendar* pCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Set components
    NSUInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *pComponents = [pCalender components:units fromDate:argTime];
    
    // Format the date string
    NSString *strTimeLabel = [NSString stringWithFormat:@"%ld年%ld月%ld日　%ld:%ld", (long)[pComponents year], (long)[pComponents month], (long)[pComponents day], (long)[pComponents hour], (long)[pComponents minute]];
    
    return strTimeLabel;
}

+ (NSString*)GetShortTimeString:(NSDate*)argTime
{
    // Get the calender
    NSCalendar* pCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Set components
    NSUInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *pComponents = [pCalender components:units fromDate:argTime];
    
    // Format the date string
    NSString *strTimeLabel = [NSString stringWithFormat:@"%ld月%ld日 %ld:%ld", (long)[pComponents month], (long)[pComponents day], (long)[pComponents hour], (long)[pComponents minute]];
    
    return strTimeLabel;
}

+(NSString*)GetTimeDistanceString:(NSDate*)argTime
{
    NSString* strTime;
    NSTimeInterval interval = [argTime timeIntervalSinceNow ];
    interval = 0 - interval;
    if(interval<0)
        interval = 0;
    
    int iMinute = 60;
    int iHour = 60* iMinute;
    int iDay = 24*iHour;
    int iMonth = 30*iDay;
    int iYear = 365*iMonth;
    if( (int)(interval/iYear) != 0)
    {
        strTime = [NSString stringWithFormat:@"%d年前", (int)(interval/iYear)];
    }
    else if((int)(interval/iMonth) != 0)
        strTime = [NSString stringWithFormat:@"%d个月前", (int)(interval/iMonth)];
    else if((int)(interval/iDay) != 0)
        strTime = [NSString stringWithFormat:@"%d天前", (int)(interval/iDay)];
    else if((int)(interval/iHour) != 0)
        strTime = [NSString stringWithFormat:@"%d小时前", (int)(interval/iHour)];
    else if((int)(interval/iMinute) != 0)
        strTime = [NSString stringWithFormat:@"%d分钟前", (int)(interval/iMinute)];
    else
        strTime = [NSString stringWithFormat:@"%d秒前", (int)(interval)];
    
    return strTime;
}


+(NSString*)GetTimeString:(NSTimeInterval)argTime
{
    NSDate* timer = [[NSDate alloc] initWithTimeIntervalSince1970:argTime/1000];
    NSTimeInterval currentInterval = [NSDate date].timeIntervalSince1970;
    NSTimeInterval interval = currentInterval - argTime/1000;
    
    if(interval<0)
        interval = 0;
    
    int iDay = 24*60*60;
    int iYear = 365*iDay;
    
    if((interval/iYear)>=1)
    {
        return [STTimeUtility GetTimeLabelString:timer];
    }
    if((interval/iDay*2)>=1)
    {
        return [STTimeUtility GetShortTimeString:timer];
    }
    else
        return [STTimeUtility GetTimeDistanceString:timer];
}


#pragma mark - 时间格式
+(NSString *)GetTimeWithBasicFormat:(NSString *)argTime
{

    NSDateFormatter *pDF = [[NSDateFormatter alloc]init];
    [pDF setDateFormat:@"yyyy年MM月dd号 HH:mm"];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:[argTime floatValue]];
    return [NSString stringWithFormat:@"%@",[pDF stringFromDate: pDate]];
}

#pragma mark -- 时间直接拼接
+ (NSString *)GetTimeConcatenationString:(NSDate *)argDate
{
    // Get the calender
    NSCalendar* pCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Set components
    NSUInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *pComponents = [pCalender components:units fromDate:argDate];
    
    NSString *strTimeLabel = [NSString stringWithFormat:@"%04ld%02ld%02ld%02ld%02ld%02ld",(long)[pComponents year], (long)[pComponents month], (long)[pComponents day], (long)[pComponents hour], (long)[pComponents minute],(long)[pComponents second]];
    return strTimeLabel;
}

+ (ConcatenationTime)FormatterTimeConcatenationString:(NSString *)argTime
{
    ConcatenationTime time;
    time.year = [[argTime substringWithRange:NSMakeRange(0, 4)] integerValue];
    time.month = [[argTime substringWithRange:NSMakeRange(4, 2)] integerValue];
    time.day = [[argTime substringWithRange:NSMakeRange(6, 2)] integerValue];
    time.hour = [[argTime substringWithRange:NSMakeRange(8, 2)] integerValue];
    time.minute = [[argTime substringWithRange:NSMakeRange(10, 2)] integerValue];
    time.second = [[argTime substringWithRange:NSMakeRange(12, 2)] integerValue];
    return time;
}

@end
