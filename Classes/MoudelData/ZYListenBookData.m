//
//  ZYListenBookData.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "ZYListenBookData.h"
#import "RMMapper.h"


@implementation Chapter



@end

@implementation ZYListenBookData


-(void)setAllChapter:(NSArray *)allChapter
{
    if ([allChapter isKindOfClass:[NSArray class]])
    {
       _allChapter = [RMMapper arrayOfClass:[Chapter class] fromArrayOfDictionary:allChapter];
    }
}

@end
