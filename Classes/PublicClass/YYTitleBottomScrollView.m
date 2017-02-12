//
//  YYTitleBottomScrollView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYTitleBottomScrollView.h"

#define VIEWBTNTAG 1000

@interface YYTitleBottomScrollView ()
{
    UIScrollView *m_pScrollView;
    UIView *m_pLineView;
    UILabel *m_pTitleLab;
    UILabel *m_pNameLab;
    UIView *m_pBackgroupView;
    UIButton *m_pMoreBtn;
    CGFloat m_fBackViewSizeW;
    CGFloat m_fBackViewSizeH;
    CGFloat m_fFont;
}

@end

@implementation YYTitleBottomScrollView

-(id)initWithFrame:(CGRect)frame andYiOrPlay:(BOOL)argSquare
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (argSquare == YES)
        {
            m_fFont = 14.0f;
            m_fBackViewSizeW = 71*[AppConfigure GetLengthAdaptRate];
            m_fBackViewSizeH = 71*[AppConfigure GetLengthAdaptRate];
        }else
        {
            m_fFont = 16.0f;
            m_fBackViewSizeW = 90*[AppConfigure GetLengthAdaptRate];
            m_fBackViewSizeH = 115*[AppConfigure GetLengthAdaptRate];
        }
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
    m_pTitleLab.text = @"电影";
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:16.0f];
    m_pTitleLab.textColor = UIColorFromHex(0x333333);
    [self addSubview:m_pTitleLab];
    
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, m_pTitleLab.bottom + 9*[AppConfigure GetLengthAdaptRate], self.width, self.height - m_pTitleLab.bottom - 9*[AppConfigure GetLengthAdaptRate])];
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.clipsToBounds = NO;
    m_pScrollView.showsVerticalScrollIndicator = NO;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:m_pScrollView];
    
    CGFloat fBackViewX = 20*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewInterval = 4*[AppConfigure GetLengthAdaptRate];
    for (NSInteger i = 0; i < 10; i++)
    {
        UIImageView *pBackgroupView = [[UIImageView alloc] initWithFrame:CGRectMake(fBackViewX+(i * (m_fBackViewSizeW + fBackViewInterval)), 0, m_fBackViewSizeW, m_fBackViewSizeH)];
        pBackgroupView.backgroundColor = [UIColor redColor];
        [m_pScrollView addSubview:pBackgroupView];
        
        UIButton *pPhotoBtn = [[UIButton alloc] initWithFrame:pBackgroupView.frame];
        pPhotoBtn.backgroundColor = [UIColor clearColor];
        [pPhotoBtn addTarget:self action:@selector(ClickCheckDetails:) forControlEvents:UIControlEventTouchUpInside];
        pPhotoBtn.tag = VIEWBTNTAG + i;
        [m_pScrollView addSubview:pPhotoBtn];
        
        UILabel *pNameLab = [[UILabel alloc] initWithFrame:CGRectMake(fBackViewX+(i * (m_fBackViewSizeW + fBackViewInterval)), pBackgroupView.bottom, m_fBackViewSizeW, 42*[AppConfigure GetLengthAdaptRate])];
        pNameLab.text = @"我这一辈子";
        pNameLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:m_fFont];
        pNameLab.textColor = UIColorFromHex(0x333333);
        pNameLab.textAlignment = NSTextAlignmentLeft;
        [m_pScrollView addSubview:pNameLab];
    }
    m_pScrollView.contentSize = CGSizeMake(fBackViewX+(10 * (m_fBackViewSizeW+fBackViewInterval)), 0);
    
}

-(void)ClickCheckDetails:(UIButton *)argBtn
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(ClickCheckDetailsWithId:)])
    {
        [self.propDelegate ClickCheckDetailsWithId:argBtn.tag - VIEWBTNTAG];
    }
}

#pragma mark - public methods
-(void)SetTitleText:(NSString *)argTitle
{
    m_pTitleLab.text = argTitle;
}


@end
