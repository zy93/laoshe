//
//  STTimeUtility.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/18.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
}ConcatenationTime;

@interface STTimeUtility : NSObject

//获取当前日期   年月日
+ (NSString *)GetCurrentDate;
//年月日  时分
+ (NSString*)GetTimeLabelString:(NSDate*)argTime;
//月日  时分
+ (NSString*)GetShortTimeString:(NSDate*)argTime;
//多少分钟前   多少小时前  多少天前 ........
+(NSString*)GetTimeDistanceString:(NSDate*)argTime;
//根据时间挫的长短   选择时间显示的方式
+(NSString*)GetTimeString:(NSTimeInterval)argTime;


#pragma mark - 时间格式
+(NSString *)GetTimeWithBasicFormat:(NSString *)argTime;

#pragma mark -- 时间直接拼接
+ (NSString *)GetTimeConcatenationString:(NSDate *)argDate;
+ (ConcatenationTime)FormatterTimeConcatenationString:(NSString *)argTime;

@end
