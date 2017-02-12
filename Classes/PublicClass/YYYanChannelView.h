//
//  YYYanChannelView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/12.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTN_BASE_TAG 1000

#define SELECTCOLOR UIColorFromHex(0x455cc7)
#define UNSELECTCOLOR UIColorFromHex(0xffffff)

@protocol YYYanChannelViewDelegate <NSObject>

@optional
-(void)SelectTag:(NSString *)argTagId Index:(NSInteger)argIndex;
-(void)SelectIndex:(NSInteger)argIndex;
@end

@interface YYYanChannelView : UIView
{
    UIButton *m_pCurrentActiveBtn;
    UIScrollView *m_pScrollView;
    UIView *m_pLineView;
    NSInteger m_iBtnCount;
    CGFloat m_fChannelLength;
    NSInteger m_iDefaultIndex;
}

@property (nonatomic, weak)id<YYYanChannelViewDelegate> propDelegete;
//@property (nonatomic, assign)BOOL propIsXShowChannel;               //是否是星秀页面
///赋值
-(void)SetChannelCount:(NSArray *)argChannels;

///每个频道的宽度
-(void)SetChannelLength:(CGFloat)argLength;

///默认选中的频道
-(void)SetDefaultChannel:(NSInteger)argDefaultChannel;

///选择频道
-(void)SelectWithIndex:(NSInteger)argIndex;

@end
