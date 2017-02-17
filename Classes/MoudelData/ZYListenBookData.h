//
//  ZYListenBookData.h
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "AFBaseModuleData.h"


@interface Chapter : AFBaseModuleData

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *error_msg;

@end

@interface Data : AFBaseModuleData

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *chapter;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSArray *allChapter;

@end

@interface ZYListenBookData : AFBaseModuleData

@property (nonatomic, copy) NSString *state_code;
@property (nonatomic, copy) NSString *error_msg;
@property (nonatomic, copy) Data *data;

@end