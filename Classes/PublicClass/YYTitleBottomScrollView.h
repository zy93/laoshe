//
//  YYTitleBottomScrollView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYTitleBottomScrollViewDelegate <NSObject>

-(void)ClickCheckDetailsWithId:(NSInteger)argId;

@end

@interface YYTitleBottomScrollView : UIView

-(id)initWithFrame:(CGRect)frame andYiOrPlay:(BOOL)argSquare;

@property (nonatomic,weak)id<YYTitleBottomScrollViewDelegate> propDelegate;

-(void)SetTitleText:(NSString *)argTitle;

-(void)SetData:(NSArray *)argData;

@end
