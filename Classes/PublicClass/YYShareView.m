//
//  YYShareView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/13.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYShareView.h"

#define SHAREBTNTAG 1000

@interface YYShareView ()
{
    UIView *m_pBackView;
    UIView *m_pShareView;
    UIView *m_pIconView;
    UIButton *m_pCancelBtn;
    NSMutableArray *m_arrIcon;
    NSMutableArray *m_arrSelectIcon;
    NSMutableArray *m_arrTitle;
    
}

@end

@implementation YYShareView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        m_arrTitle = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"新浪微博", nil];
        m_arrIcon = [NSMutableArray arrayWithObjects:@"share_weixin.png",@"share_pengyouquan.png",@"share_qq.png",@"share_qqkongjian.png", @"share_sina.png",nil];
        m_arrSelectIcon = [NSMutableArray arrayWithObjects:@"share_weixin_select.png",@"share_pengyouquan_select.png",@"share_qq_select.png",@"share_qqkongjian_select.png",@"share_sina_select.png", nil];
        [self CreateSubViews];
    }
    return self;
}

#pragma makr - private methods
-(void)CreateSubViews
{
    m_pBackView = [[UIView alloc] initWithFrame:self.bounds];
    m_pBackView.backgroundColor = UIColorFromHex(0x000000);
    m_pBackView.alpha = 0.5;
    [self addSubview:m_pBackView];
    
    m_pShareView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 200*[AppConfigure GetLengthAdaptRate])];
    m_pShareView.backgroundColor = UIColorFromHex(0xf2f2f2);
    [self addSubview:m_pShareView];
    
    m_pIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_pShareView.width, 140*[AppConfigure GetLengthAdaptRate])];
    m_pIconView.backgroundColor = UIColorFromHex(0xffffff);
    [m_pShareView addSubview:m_pIconView];
    
    UIImage *pIconImg = [UIImage imageNamed:m_arrIcon[0]];
    CGFloat fIconSizeW = pIconImg.size.width *[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewX = 20*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewInterval = 18*[AppConfigure GetLengthAdaptRate];
    for (NSInteger i = 0; i<m_arrIcon.count; i++)
    {
        UIButton *pButton = [[UIButton alloc] initWithFrame:CGRectMake(fBackViewX + (i * (fIconSizeW+fBackViewInterval)), 35*[AppConfigure GetLengthAdaptRate], fIconSizeW, fIconSizeW)];
        [pButton setBackgroundImage:[UIImage imageNamed:m_arrIcon[i]] forState:UIControlStateNormal];
        [pButton setBackgroundImage:[UIImage imageNamed:m_arrSelectIcon[i]] forState:UIControlStateHighlighted];
        pButton.tag = SHAREBTNTAG + i;
        [pButton addTarget:self action:@selector(ClickShareIcon:) forControlEvents:UIControlEventTouchUpInside];
        [m_pIconView addSubview:pButton];
        
        UILabel *pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(fBackViewX + (i * (fIconSizeW+fBackViewInterval)), pButton.bottom + 13*[AppConfigure GetLengthAdaptRate], fIconSizeW, 12)];
        pTitleLab.text = m_arrTitle[i];
        pTitleLab.textColor = UIColorFromHex(0x2e5597);
        pTitleLab.textAlignment = NSTextAlignmentCenter;
        pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:11.0f];
        [m_pIconView addSubview:pTitleLab];
    }
    
    m_pCancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, m_pIconView.bottom + 5*[AppConfigure GetLengthAdaptRate], self.width, 55*[AppConfigure GetLengthAdaptRate])];
    [m_pCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [m_pCancelBtn setBackgroundColor:UIColorFromHex(0xffffff)];
    [m_pCancelBtn setTitleColor:UIColorFromHex(0x2e5597) forState:UIControlStateNormal];
    [m_pCancelBtn addTarget:self action:@selector(ShowView) forControlEvents:UIControlEventTouchUpInside];
    [m_pShareView addSubview:m_pCancelBtn];
}

-(void)ClickShareIcon:(UIButton *)argBtn
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(ClickShareWithType:)])
    {
        [self ShowView];
        [self.propDelegate ClickShareWithType:argBtn.tag - SHAREBTNTAG];
    }
}

#pragma mark - public methods
-(void)ShowView
{
    BOOL bOldStatus = self.hidden;
    CGFloat fAlpha = (bOldStatus == YES) ? 1 : 0;
    CGFloat fyPos = (bOldStatus == YES) ? -(200*[AppConfigure GetLengthAdaptRate]) : 0;
    self.hidden = NO;
    __weak UIView *pWeakSelf = m_pShareView;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = fAlpha;
                         pWeakSelf.transform = CGAffineTransformMakeTranslation(0, fyPos);
                     }
                     completion:^(BOOL finished) {
                         self.hidden = !bOldStatus;
                     }];
}


@end
