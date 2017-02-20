//
//  YYPlayActivityCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYPlayActivityCell.h"
#import "YYDonationData.h"
#import "UIImageView+AFNetworking.h"

@interface YYPlayActivityCell ()
{
    UIView *m_pBackView;
    UIView *m_pLineView;
    UILabel *m_pTitleLab;
    UIButton *m_pMoreBtn;
    UIImageView *m_pCoverView;
    UILabel *m_pActNameLab;
}

@end

@implementation YYPlayActivityCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 288*[AppConfigure GetLengthAdaptRate])];
    m_pBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:m_pBackView];
    
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 0, SCREEN_WIDTH - 40*[AppConfigure GetLengthAdaptRate], 2*[AppConfigure GetLengthAdaptRate])];
    m_pLineView.backgroundColor = UIColorFromHex(0xf2f2f2);
    [m_pBackView addSubview:m_pLineView];
    
    m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pLineView.bottom + 10*[AppConfigure GetLengthAdaptRate], (SCREEN_WIDTH -40*[AppConfigure GetLengthAdaptRate]) /2.0, 36*[AppConfigure GetLengthAdaptRate])];
    m_pTitleLab.text = @"活动";
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:16.0f];
    m_pTitleLab.textColor = UIColorFromHex(0x333333);
    [m_pBackView addSubview:m_pTitleLab];
    
    m_pMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(m_pTitleLab.right, m_pTitleLab.top, m_pTitleLab.width, m_pTitleLab.height)];
    [m_pMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [m_pMoreBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
    m_pMoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [m_pMoreBtn addTarget:self action:@selector(MoreActivity) forControlEvents:UIControlEventTouchUpInside];
    [m_pBackView addSubview:m_pMoreBtn];
    
    
    m_pCoverView = [[UIImageView alloc] initWithFrame:CGRectMake(m_pTitleLab.left, m_pTitleLab.bottom + 9*[AppConfigure GetLengthAdaptRate], m_pLineView.width, 180*[AppConfigure GetLengthAdaptRate])];
//    m_pCoverView.backgroundColor = [UIColor redColor];
    [m_pBackView addSubview:m_pCoverView];
    
    m_pActNameLab = [[UILabel alloc] initWithFrame:CGRectMake(28*[AppConfigure GetLengthAdaptRate], m_pCoverView.bottom + 12*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH - 56*[AppConfigure GetLengthAdaptRate] /2.0, 15.0)];
    m_pActNameLab.text = @"活动";
    m_pActNameLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14.0f];
    m_pActNameLab.textColor = UIColorFromHex(0x333333);
    [m_pBackView addSubview:m_pActNameLab];
}

-(void)MoreActivity
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(CheckMoreActivity)])
    {
        [self.propDelegate CheckMoreActivity];
    }
}

#pragma mark - public methods
-(void)SetPlayActivityData:(YYDonationData *)argData
{
    [m_pCoverView setImageWithURL:[NSURL URLWithString:argData.cover] placeholderImage:nil];
    m_pActNameLab.text = argData.title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
