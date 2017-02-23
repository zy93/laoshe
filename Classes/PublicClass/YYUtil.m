//
//  YYUtil.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYUtil.h"

@implementation YYUtil


+ (NSString *)timeWithTimeInterval:(NSTimeInterval)timeInt
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInt/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
