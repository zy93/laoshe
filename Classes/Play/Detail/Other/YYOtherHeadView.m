//
//  YYOtherHeaderView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/24.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYOtherHeadView.h"
#import "UIImageView+AFNetworking.h"
#import "YYUtil.h"

@interface YYOtherHeadView ()
{
    UIImageView *m_pBGImageView;
    UIImageView *m_pDetailImageView;
    UILabel *m_pTitleLab;
    UILabel *m_pSubtitleLab;
    UILabel *m_pDirectorLab; //导演
    UILabel *m_pWriterLab;   //编剧
    UILabel *m_pStarringLab; //主演
}

@end


@implementation YYOtherHeadView

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
    m_pBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270*[AppConfigure GetLengthAdaptRate])];
//    [m_pBGImageView setImage:[UIImage imageNamed:@"我这一辈子"]];
    [self addSubview:m_pBGImageView];
    //模糊效果
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    view.frame = m_pBGImageView.bounds;
    [self addSubview:view];
    
    
    
    m_pDetailImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, 82*[AppConfigure GetLengthAdaptRate], 120*[AppConfigure GetLengthAdaptRate], 159*[AppConfigure GetLengthAdaptRate])];
//    [m_pDetailImageView setImage:[UIImage imageNamed:@"我这一辈子"]];
    [m_pDetailImageView setBackgroundColor:[UIColor grayColor]];
    //    [m_pBGImageView addSubview:m_pDetailImageView];
    [self addSubview:m_pDetailImageView];
    
    m_pTitleLab  = [self createLabel:CGRectMake(CGRectGetMaxX(m_pDetailImageView.frame)+(14*[AppConfigure GetLengthAdaptRate]), CGRectGetMinY(m_pDetailImageView.frame), 0, 0) size:18 space:0 isBold:YES isWhiteColor:YES];
    CGRect rect = m_pTitleLab.frame;
    m_pSubtitleLab  = [self createLabel:rect size:12 space:12 isBold:NO isWhiteColor:YES];
    [m_pSubtitleLab setNumberOfLines:0];
    rect = m_pSubtitleLab.frame;
    m_pDirectorLab  = [self createLabel:rect size:14 space:38 isBold:NO isWhiteColor:YES];
    rect = m_pDirectorLab.frame;
    m_pWriterLab    = [self createLabel:rect size:14 space:8 isBold:NO isWhiteColor:YES];
    rect = m_pWriterLab.frame;
    m_pStarringLab  = [self createLabel:rect size:14 space:8 isBold:NO isWhiteColor:YES];
    [m_pStarringLab setNumberOfLines:0];
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
    [self addSubview:lab];
    return lab;
}


-(void)setData:(YYPLayOtherData *)data
{
    [m_pTitleLab setText:data.title];
    [m_pSubtitleLab setText:data.introduce];
    [m_pDirectorLab setText:[NSString stringWithFormat:@"导演：%@",data.director]];
    [m_pWriterLab setText:[NSString stringWithFormat:@"编剧：%@", data.writers]];
    [m_pStarringLab setText:[NSString stringWithFormat:@"主演：%@",data.strring]];
    [m_pBGImageView setImageWithURL:[NSURL URLWithString:data.cover] placeholderImage:nil];
    [m_pDetailImageView setImageWithURL:[NSURL URLWithString:data.cover] placeholderImage:nil];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize boundSize;
    CGRect rect;
    boundSize = CGSizeMake(CGRectGetWidth(m_pTitleLab.frame), FLT_MAX);
    //first
    rect = [YYUtil computeTextSize:m_pSubtitleLab.text boundSize:boundSize textFont:m_pSubtitleLab.font.pointSize];
    if (rect.size.height > 42) {
        [m_pSubtitleLab setFrame:CGRectMake(CGRectGetMinX(m_pTitleLab.frame), CGRectGetMaxY(m_pTitleLab.frame)+8, CGRectGetWidth(m_pTitleLab.frame), 43)];
    }
    else {
        [m_pSubtitleLab setFrame:CGRectMake(CGRectGetMinX(m_pTitleLab.frame), CGRectGetMaxY(m_pTitleLab.frame)+8, CGRectGetWidth(m_pTitleLab.frame), rect.size.height)];
    }

    rect = [YYUtil computeTextSize:m_pStarringLab.text boundSize:boundSize textFont:m_pStarringLab.font.pointSize];
    if (rect.size.height > 15) {
        CGFloat selfH = self.frame.size.height; //200
        CGFloat starMaxY = CGRectGetMaxY(m_pStarringLab.frame); // 180;
        
        CGFloat contentH = CGRectGetMaxY(m_pDetailImageView.frame) - CGRectGetMinY(m_pStarringLab.frame);
        
        CGFloat hight = selfH - starMaxY < 20 ? 14 : rect.size.height>contentH ? contentH : rect.size.height;
        [m_pStarringLab setFrame:CGRectMake(CGRectGetMinX(m_pWriterLab.frame), CGRectGetMaxY(m_pWriterLab.frame)+8, CGRectGetWidth(m_pWriterLab.frame), hight)];
    }
    else {
        [m_pStarringLab setFrame:CGRectMake(CGRectGetMinX(m_pWriterLab.frame), CGRectGetMaxY(m_pWriterLab.frame)+8, CGRectGetWidth(m_pWriterLab.frame), rect.size.height)];
    }
}


@end
