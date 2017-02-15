//
//  YYYiHomePageView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYYiHomePageViewDelegate <NSObject>

-(void)Click2111    ;

@end

@interface YYYiHomePageView : UIView

@property (nonatomic,weak)id<YYYiHomePageViewDelegate> propDelegate;

-(void)SetFriendData:(NSArray *)argData;

-(void)SetDonationData:(NSArray *)argData;

@end
