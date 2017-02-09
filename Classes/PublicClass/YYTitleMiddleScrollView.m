//
//  YYTitleMiddleScrollView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/26.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYTitleMiddleScrollView.h"

@interface YYTitleMiddleScrollView ()<UIScrollViewDelegate>
{
    UIScrollView *m_pScrollView;
    UIView *m_pLineView;
    UILabel *m_pTitleLab;
    UILabel *m_pNameLab;
    UIView *m_pBackgroupView;
    NSMutableArray *m_arrBackgroupColor;
}

@end

@implementation YYTitleMiddleScrollView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrBackgroupColor = [NSMutableArray arrayWithObjects:UIColorFromHex(0x7bb6d3),UIColorFromHex(0xda9ca7),UIColorFromHex(0x98a6ce),UIColorFromHex(0xe6daa2),UIColorFromHex(0x88b9b0), nil];
        [self CreateSubViews];
    }
    return self;
}


#pragma mark - private methods
-(void)CreateSubViews
{
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 0, self.width - 40*[AppConfigure GetLengthAdaptRate], 2*[AppConfigure GetLengthAdaptRate])];
    m_pLineView.backgroundColor = UIColorFromHex(0xf2f2f2);
    [self addSubview:m_pLineView];
    
    m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pLineView.bottom + 10*[AppConfigure GetLengthAdaptRate], self.width-40*[AppConfigure GetLengthAdaptRate], 36*[AppConfigure GetLengthAdaptRate])];
    m_pTitleLab.text = @"好友";
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:16.0f];
    m_pTitleLab.textColor = UIColorFromHex(0x333333);
    [self addSubview:m_pTitleLab];
    
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, m_pTitleLab.bottom + 9*[AppConfigure GetLengthAdaptRate], self.width, self.height - m_pTitleLab.bottom - 9*[AppConfigure GetLengthAdaptRate])];
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.clipsToBounds = NO;
    [self addSubview:m_pScrollView];
    
    CGFloat fBackViewSize = 71*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewX = 20*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewInterval = 8*[AppConfigure GetLengthAdaptRate];
    for (NSInteger i = 0; i < 10; i++)
    {
        UIView *pBackgroupView = [[UIView alloc] initWithFrame:CGRectMake(fBackViewX+(i * (fBackViewSize + fBackViewInterval)), 0, fBackViewSize, fBackViewSize)];
        pBackgroupView.backgroundColor = m_arrBackgroupColor[i%5];
        [m_pScrollView addSubview:pBackgroupView];
        
        UILabel *pNameLab = [[UILabel alloc] initWithFrame:pBackgroupView.frame];
        pNameLab.text = @"好友";
        pNameLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:16.0f];
        pNameLab.textColor = UIColorFromHex(0xfefefe);
        pNameLab.textAlignment = NSTextAlignmentCenter;
        [m_pScrollView addSubview:pNameLab];
    }
    m_pScrollView.contentSize = CGSizeMake(fBackViewX+(10 * (fBackViewSize+fBackViewInterval)), 0);

}

@end
