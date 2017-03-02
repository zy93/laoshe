//
//  YYYiHomePageController.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//  忆

#import "BUCustomViewController.h"
@class YYFriendData;

@interface YYYiHomePageController : BUCustomViewController

-(void)ClickCheckDetailsWithData:(YYFriendData *)argData;

-(void)CheckMoreContent;

-(void)RefreshData;

@end
