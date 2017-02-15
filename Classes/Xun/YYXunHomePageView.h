//
//  YYXunHomePageView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/26.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYXunData;

@protocol YYXunHomePageViewDelegate <NSObject>

-(void)CheckDetail:(YYXunData *)argData;

@end

@interface YYXunHomePageView : UIView

@property (nonatomic,weak)id<YYXunHomePageViewDelegate> propDelegate;

-(void)SetXunHomePageData:(NSArray *)argData;

@end
