//
//  YYTitleBottomScrollView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYTitleBottomScrollViewDelegate <NSObject>

-(void)ClickCheckDetailsWithId:(NSInteger)argId andType:(NSInteger)argType;

-(void)CheckMoreContent;

@end

@interface YYTitleBottomScrollView : UIView

-(id)initWithFrame:(CGRect)frame andYiOrPlay:(BOOL)argSquare;

@property (nonatomic,weak)id<YYTitleBottomScrollViewDelegate> propDelegate;

///设置view属于对应内容的类型
-(void)SetType:(NSInteger)argType;

//设置标题内容
-(void)SetTitleText:(NSString *)argTitle;

///是否显示更多按钮
-(void)SetShowMore:(BOOL)argShow;

//设置数据
-(void)SetData:(NSArray *)argData;

//清除旧内容
-(void)ClearData;

@end
