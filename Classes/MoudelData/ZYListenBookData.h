//
//  ZYListenBookData.h
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "AFBaseModuleData.h"


@interface ZYChapter : AFBaseModuleData

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *cover1;
@property (nonatomic, copy) NSString *chapter;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *mid;



@end


@interface ZYListenBookData : AFBaseModuleData

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *chapter;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSArray *allChapter;

@end
