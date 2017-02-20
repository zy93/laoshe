//
//  YYPlayHomePageView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYActivityData;

@protocol YYPlayHomePageViewDelegate <NSObject>

-(void)CheckDetail:(YYActivityData *)argData;

@end

@interface YYPlayHomePageView : UIView

@property (nonatomic,weak)id<YYPlayHomePageViewDelegate> propDelegate;

-(void)SetPlayData:(NSArray *)argData;

-(NSArray *)GetAccivity;

@end
