//
//  YYPlayData.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/16.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYPlayData.h"
#import "YYDonationData.h"
#import "RMMapper.h"

@implementation YYPlayData

-(void)setMovie:(NSArray *)movie
{
    if ([movie isKindOfClass:[NSArray class]])
    {
        _movie = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:movie];
    }
}

-(void)setTVSeries:(NSArray *)TVSeries
{
    if ([TVSeries isKindOfClass:[NSArray class]])
    {
        _TVSeries = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:TVSeries];
    }
}

-(void)setDrama:(NSArray *)drama
{
    if ([drama isKindOfClass:[NSArray class]])
    {
        _drama = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:drama];
    }
}

-(void)setOpera:(NSArray *)opera
{
    if ([opera isKindOfClass:[NSArray class]])
    {
        _opera = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:opera];
    }
}

-(void)setOther:(NSArray *)other
{
    if ([other isKindOfClass:[NSArray class]])
    {
        _other = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:other];
    }
}

-(void)setTingBook:(NSArray *)tingBook
{
    if ([tingBook isKindOfClass:[NSArray class]])
    {
        _tingBook = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:tingBook];
    }
}

-(void)setActivity:(NSArray *)activity
{
    if ([activity isKindOfClass:[NSArray class]])
    {
        _activity = [RMMapper arrayOfClass:[YYDonationData class] fromArrayOfDictionary:activity];
    }
}




@end
