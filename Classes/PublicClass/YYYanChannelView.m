//
//  YYYanChannelView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/12.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanChannelView.h"


@interface YYYanChannelView ()
{
    NSMutableArray *m_arrTags;
}
@end

@implementation YYYanChannelView

#pragma mark - private method

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_iDefaultIndex = 1;
        m_arrTags = [NSMutableArray array];
        [self SetupSubview];
    }
    return self;
}

- (void)SetupSubview
{
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    m_pScrollView.scrollEnabled = YES;
    m_pScrollView.contentOffset = CGPointMake(0, 0);
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.showsVerticalScrollIndicator = NO;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:m_pScrollView];
}

#pragma mark - public method
-(void)SetChannelCount:(NSArray *)argChannels
{
    [m_arrTags removeAllObjects];
    for (UIButton *pBtn in m_pScrollView.subviews)
    {
        [pBtn removeFromSuperview];
    }
    [m_arrTags addObjectsFromArray:argChannels];
    m_iBtnCount = argChannels.count;
    CGFloat m_fContentSize = 0;
//    CGFloat m_fWidth = 25*[AppConfigure GetLengthAdaptRate] ;
    //    CGFloat fWordWidth = 0;
    //    for (NSInteger i = 0; i < argChannels.count; i ++)
    //    {
    //        fWordWidth = fWordWidth+ [argChannels[i] boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.width;
    //    }
    //    m_fWidth = (m_pScrollView.width - fWordWidth - (15*[AppConfigure GetLengthAdaptRate] *(argChannels.count-1)))/2.0;
    for (NSInteger i = 0; i < argChannels.count; i ++)
    {
        
        UIButton *pBtn = [[UIButton alloc] init];
        pBtn.frame = CGRectMake(15*[AppConfigure GetLengthAdaptRate] + i * m_fChannelLength, 0, m_fChannelLength, self.frame.size.height - 4);
        pBtn.tag = BTN_BASE_TAG + i;
        [pBtn setTitle:argChannels[i] forState:UIControlStateNormal];
        [pBtn setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
        pBtn.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15.0];
        //        pBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //        CGFloat pWidth =[argChannels[i] boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.width;
        //        pBtn.frame = CGRectMake(m_fWidth , 0, pWidth, self.frame.size.height - 4);
        //        m_fWidth += pWidth + 30*[AppConfigure GetLengthAdaptRate];
        
        [pBtn addTarget:self action:@selector(ChannelSelect:) forControlEvents:UIControlEventTouchUpInside];
        [m_pScrollView addSubview:pBtn];
        
        if (i == m_iDefaultIndex)
        {
//            m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(0, m_pScrollView.frame.size.height-2, pBtn.bounds.size.width, 2)];
//            m_pLineView.backgroundColor = UIColorFromHex(0x3679c3);
//            [m_pScrollView addSubview:m_pLineView];
            [self SelectWithIndex:m_iDefaultIndex];
        }
        if (i == argChannels.count - 1)
        {
            m_fContentSize = CGRectGetMaxX(pBtn.frame);
        }
    }
    
    [m_pScrollView setContentSize:CGSizeMake(m_fContentSize+25*[AppConfigure GetLengthAdaptRate], 0)];
}

-(void)SetChannelLength:(CGFloat)argLength
{
    m_fChannelLength = argLength;
}

-(void)SetDefaultChannel:(NSInteger)argDefaultChannel
{
    m_iDefaultIndex = argDefaultChannel;
}

-(void)ChannelSelect:(UIButton *)argBtn
{
    NSInteger selectIndex = argBtn.tag - BTN_BASE_TAG;
    for (int i = 0; i < m_iBtnCount; i ++)
    {
        UIButton *pBtn = (UIButton *)[m_pScrollView viewWithTag:BTN_BASE_TAG + i];
        [pBtn setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
        if (i == selectIndex)
        {
            [pBtn setTitleColor:SELECTCOLOR forState:UIControlStateNormal];
        }
    }
    
    __weak YYYanChannelView *channelBar = self;
    [UIView animateWithDuration:0.3 animations:^{
        [channelBar MoveIndicator:argBtn];
    } completion:^(BOOL finished) {
        
    }];
    if (self.propDelegete != nil && [self.propDelegete respondsToSelector:@selector(SelectIndex:)])
    {
        [self.propDelegete SelectIndex:selectIndex];
    }
}

-(void)SelectWithIndex:(NSInteger)argIndex
{
    NSInteger selectIndex = -1;
    for (int i = 0; i < m_iBtnCount; i ++)
    {
        UIButton *pBtn = (UIButton *)[m_pScrollView viewWithTag:BTN_BASE_TAG + i];
        [pBtn setTitleColor:UNSELECTCOLOR forState:UIControlStateNormal];
        if (i == argIndex)
        {
            selectIndex = i;
            [pBtn setTitleColor:SELECTCOLOR forState:UIControlStateNormal];
        }
    }
    
    __weak YYYanChannelView *channelBar = self;
    UIButton *pSelectBtn = [m_pScrollView viewWithTag:(BTN_BASE_TAG + selectIndex)];
    [UIView animateWithDuration:0.3 animations:^{
        [channelBar MoveIndicator:pSelectBtn];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)MoveIndicator:(UIButton *)argBtn
{
    m_pLineView.frame = CGRectMake(m_pLineView.frame.origin.x, m_pLineView.frame.origin.y, argBtn.size.width, m_pLineView.frame.size.height);
    m_pLineView.center = CGPointMake(argBtn.center.x, m_pLineView.center.y);
}

@end
