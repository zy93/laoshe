//
//  NSDate+Compare.m
//  pbuShiJianQiYueClient
//
//  Created by 周杰 on 2016/11/16.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "NSDate+Compare.h"

@implementation NSDate(Compare)



/**
 
 *  是否为今年
 
 */

- (BOOL)isThisYear

{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitYear;
    
    
    
    // 1.获得当前时间的年月日
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    
    
    // 2.获得self的年月日
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    
    
    return nowCmps.year == selfCmps.year;
    
}


@end
