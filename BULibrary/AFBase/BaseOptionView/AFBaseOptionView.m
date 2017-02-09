//
//  SXOptionBaseView.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/10.
//  Copyright © 2015年 . All rights reserved.
//

#import "AFBaseOptionView.h"

@interface AFBaseOptionView ()

@end

@implementation AFBaseOptionView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self CreatNeedShowModule];
    }
    return self;
}

#pragma mark -- Private AddSubview method
- (void)CreatNeedShowModule
{
    m_pTopView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44 * [AppConfigure GetLengthAdaptRate])];
    m_pTopView.backgroundColor = [AppConfigure WhiteColor];
    m_pTopView.delegate = self;
    m_pTopView.alwaysBounceHorizontal = YES;
    [self addSubview:m_pTopView];
    
    m_pScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44 * [AppConfigure GetLengthAdaptRate], self.width, self.height - 44 * [AppConfigure GetLengthAdaptRate])];
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.bounces = NO;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    m_pScrollView.pagingEnabled = YES;
    m_pScrollView.delegate = self;
    [self addSubview:m_pScrollView];

    UIImageView *pBottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44 * [AppConfigure GetLengthAdaptRate] - 0.5, self.width, 0.5)];
    pBottomLine.backgroundColor = [AppConfigure GrayColor];
    [self addSubview:pBottomLine];
}

#pragma mark -- Public Addsubview method
- (void)CreatTopViewWithTitles:(NSArray *)argKind
{
    CGFloat fWidth = argKind.count > 6 ? self.width / 6.0f : self.width / argKind.count;
    [m_pTopView setContentSize:CGSizeMake(fWidth * argKind.count, 0)];

    for (NSInteger iIndex = 0; iIndex < argKind.count; iIndex ++)
    {
        UIButton *pFunctionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pFunctionBtn.frame = CGRectMake(iIndex * fWidth, 0, fWidth, m_pTopView.height);
        [pFunctionBtn setTitleColor:[AppConfigure OrangeColor] forState:UIControlStateDisabled];
        [pFunctionBtn setTitleColor:[AppConfigure BlackColor] forState:UIControlStateNormal];
        pFunctionBtn.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
        [pFunctionBtn setTitle:argKind[iIndex] forState:UIControlStateNormal];
        pFunctionBtn.backgroundColor = [UIColor clearColor];
        [pFunctionBtn addTarget:self action:@selector(CheckRelatedContent:) forControlEvents:UIControlEventTouchUpInside];
        pFunctionBtn.tag = 100 + iIndex;
        [m_pTopView addSubview:pFunctionBtn];
        
        if (iIndex == 0)
        {
            m_pMark = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fWidth, 4)];
            m_pMark.backgroundColor = [AppConfigure OrangeColor];
            m_pMark.center = CGPointMake(pFunctionBtn.center.x, m_pTopView.bottom - 2);
            [m_pTopView addSubview:m_pMark];
            
            [self CheckRelatedContent:pFunctionBtn];
            [self MakeCorrespondingEventAction];
        }
    }
//    m_pRow= [[UIImageView alloc]initWithFrame:CGRectMake(self.width / 2.0f - 0.25, 15 * [AppConfigure GetLengthAdaptRate], 0.5, m_pTopView.height - 30 * [AppConfigure GetLengthAdaptRate])];
//    m_pRow.backgroundColor = [AppConfigure LineGrayColor];
//    [m_pTopView addSubview:m_pRow];
}

- (void)CreatMainSubviewsWithViews:(NSArray *)argViews
{
    [m_pScrollView setContentSize:CGSizeMake(argViews.count * self.width, 0)];
    for (NSInteger i = 0; i < argViews.count; i ++)
    {
        UIView *pView = argViews[i];
        CGRect rFrame = pView.frame;
        rFrame.origin.x = m_pScrollView.size.width * i;
        rFrame.origin.y = 0;
        pView.frame = rFrame;
        [m_pScrollView addSubview:pView];
    }
}

- (NSInteger)GetCurrentPage
{
    NSInteger iPage = roundf(m_pScrollView.contentOffset.x / m_pScrollView.width);
    return iPage;
}

- (void)MakeCorrespondingEventAction
{
    
}

#pragma mark -- Target method
- (void)CheckRelatedContent:(UIButton *)argBtn
{
    if (argBtn != m_pSelectedBtn)
    {
        m_pSelectedBtn.enabled = YES;
        m_pSelectedBtn = argBtn;
        m_pSelectedBtn.enabled = NO;
        
        __weak UIView *weakMark = m_pMark;
        [UIView animateWithDuration:0.3f animations:^{
            weakMark.center = CGPointMake(argBtn.center.x,m_pMark.center.y);
        }];
        
        [m_pScrollView setContentOffset:CGPointMake(self.width * (m_pSelectedBtn.tag - 100), 0) animated:YES];
    }
}

#pragma mark -- scroll method
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == m_pScrollView)
    {
        NSInteger iSelectedIndex = 100 + roundf(scrollView.contentOffset.x / self.width);
        UIButton *pSelectedBtn = [m_pTopView viewWithTag:iSelectedIndex];
        [self CheckRelatedContent:pSelectedBtn];
        [self MakeCorrespondingEventAction];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self MakeCorrespondingEventAction];
}

@end
