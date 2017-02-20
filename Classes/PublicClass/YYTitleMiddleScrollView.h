//
//  YYTitleMiddleScrollView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/26.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//  好友的滑动试图

#import <UIKit/UIKit.h>
@class YYFriendData;

@protocol YYTitleMiddleScrollViewDelegate <NSObject>

-(void)ClickCheckDetailsWithData:(YYFriendData *)argData;

@end

@interface YYTitleMiddleScrollView : UIView

@property (nonatomic,weak)id<YYTitleMiddleScrollViewDelegate> propDelegate;

-(void)SetData:(NSArray *)argData;

@end
