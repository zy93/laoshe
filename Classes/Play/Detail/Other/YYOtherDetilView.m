//
//  YYOtherDetilView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYOtherDetilView.h"
#import "UIImageView+AFNetworking.h"

@interface YYOtherDetilView()
{
    UIButton *m_pBackBtn;
    UIButton *m_pShareBtn;
    
    UIImageView *m_pBGImageView;
    UIImageView *m_pDetailImageView;
    UILabel *m_pTitleLab;
    UILabel *m_pSubtitleLab;
    UILabel *m_pDirectorLab; //导演
    UILabel *m_pWriterLab;   //编剧
    UILabel *m_pStarringLab; //主演
    
    UILabel *m_pCompanyTitle;
    UILabel *m_pCompanyLab;
    UILabel *m_pHonorTitle;
    UILabel *m_pHonorLab;
    UILabel *m_pIntroduceTitle;
    UILabel *m_pIntroduceLab;
}

@end

@implementation YYOtherDetilView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

-(void)createSubview
{
    [self createFristView];
    
    [self createNavBtn];
    [self createSecondView];

}

-(void)createNavBtn
{
    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pBackBtn setFrame:CGRectMake(20, 31, 28, 28)];
    [m_pBackBtn setImage:[UIImage imageNamed:@"custom_back_btn"] forState:UIControlStateNormal];
    [m_pBackBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_pBackBtn];
    
    
    m_pShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pShareBtn setFrame:CGRectMake(SCREEN_WIDTH-20-28, 31, 28, 28)];
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon_select"] forState:UIControlStateHighlighted];

    [m_pShareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_pShareBtn];}

-(void)createFristView
{
    m_pBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270*[AppConfigure GetLengthAdaptRate])];
    [m_pBGImageView setImage:[UIImage imageNamed:@"我这一辈子"]];
    [self addSubview:m_pBGImageView];
    //模糊效果
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    view.frame = m_pBGImageView.bounds;
    [self addSubview:view];
    
    
    
    m_pDetailImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, 82*[AppConfigure GetLengthAdaptRate], 120*[AppConfigure GetLengthAdaptRate], 159*[AppConfigure GetLengthAdaptRate])];
    [m_pDetailImageView setImage:[UIImage imageNamed:@"我这一辈子"]];
    [m_pDetailImageView setBackgroundColor:[UIColor grayColor]];
//    [m_pBGImageView addSubview:m_pDetailImageView];
    [self addSubview:m_pDetailImageView];
    
    m_pTitleLab     = [self createLabel:CGRectMake(CGRectGetMaxX(m_pDetailImageView.frame)+(14*[AppConfigure GetLengthAdaptRate]), CGRectGetMinY(m_pDetailImageView.frame), 0, 0) size:18 space:0 isBold:YES isWhiteColor:YES];
    CGRect rect = m_pTitleLab.frame;
    m_pSubtitleLab  = [self createLabel:rect size:12 space:12 isBold:NO isWhiteColor:YES];
    rect = m_pSubtitleLab.frame;
    m_pDirectorLab  = [self createLabel:rect size:14 space:38 isBold:NO isWhiteColor:YES];
    rect = m_pDirectorLab.frame;
    m_pWriterLab    = [self createLabel:rect size:14 space:8 isBold:NO isWhiteColor:YES];
    rect = m_pWriterLab.frame;
    m_pStarringLab  = [self createLabel:rect size:14 space:8 isBold:NO isWhiteColor:YES];

    
}

-(UILabel*)createLabel:(CGRect)frame size:(CGFloat)size space:(CGFloat)ySpace isBold:(BOOL)isBold isWhiteColor:(BOOL)isWhite;
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)+ySpace, SCREEN_WIDTH-(30*[AppConfigure GetLengthAdaptRate])-CGRectGetMinX(frame), size)];
    lab.text = @"人这一辈子";
    if (isWhite) {
        [lab setTextColor:[UIColor whiteColor]];
    }
    else {
        [lab setTextColor:[UIColor blackColor]];
    }
    if (isBold) {
        [lab setFont:[UIFont boldSystemFontOfSize:size]];
    }
    else {
        [lab setFont:[UIFont systemFontOfSize:size]];
    }
//    [lab setBackgroundColor:[UIColor redColor]];
    [self addSubview:lab];
    return lab;
}

-(void)createSecondView
{
    CGRect rect = CGRectMake(20, CGRectGetMaxY(m_pBGImageView.frame), SCREEN_WIDTH-50, 15);
    m_pCompanyTitle = [self createLabel:rect size:15 space:0 isBold:YES isWhiteColor:NO];
    rect = m_pCompanyTitle.frame;
    m_pCompanyLab = [self createLabel:rect size:14 space:10 isBold:NO isWhiteColor:NO];
    rect = m_pCompanyLab.frame;
    m_pHonorTitle = [self createLabel:rect size:15 space:21 isBold:YES isWhiteColor:NO];
    rect = m_pHonorTitle.frame;
    m_pHonorLab = [self createLabel:rect size:14 space:10 isBold:NO isWhiteColor:NO];
    rect = m_pHonorLab.frame;
    m_pIntroduceTitle = [self createLabel:rect size:15 space:21 isBold:YES isWhiteColor:NO];
    rect = m_pIntroduceTitle.frame;
    m_pIntroduceLab = [self createLabel:rect size:14 space:10 isBold:NO isWhiteColor:NO];

}


-(void)updateView
{
    //更新view
}

-(void)setData:(YYPLayOtherData *)data
{
    [m_pTitleLab setText:data.title];
    [m_pSubtitleLab setText:data.strring];
    [m_pDirectorLab setText:[NSString stringWithFormat:@"导演：%@",data.director]];
    [m_pWriterLab setText:[NSString stringWithFormat:@"编剧：%@", data.writers]];
    [m_pStarringLab setText:[NSString stringWithFormat:@"主演：%@", data.strring]];
    [m_pCompanyTitle setText:[NSString stringWithFormat:@"制作公司"]];
    [m_pCompanyLab setText:[NSString stringWithFormat:@"%@", data.company]];
    [m_pHonorTitle setText:[NSString stringWithFormat:@"荣誉"]];
    [m_pHonorLab setText:[NSString stringWithFormat:@"%@", data.honor]];
    [m_pIntroduceTitle setText:[NSString stringWithFormat:@"电影概述"]];
    [m_pIntroduceLab setText:[NSString stringWithFormat:@"%@", data.introduce]];
    
    [m_pBGImageView setImageWithURL:[NSURL URLWithString:data.cover] placeholderImage:nil];
    [m_pDetailImageView setImageWithURL:[NSURL URLWithString:data.cover] placeholderImage:nil];
}

#pragma mark - action

-(void)back:(UIButton *)sender
{
    
}

-(void)share:(UIButton *)sender
{
    
}

@end
