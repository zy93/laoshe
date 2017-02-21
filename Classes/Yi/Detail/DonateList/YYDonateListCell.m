//
//  YYDonateListCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYDonateListCell.h"
#import "YYDonateData.h"

@interface YYDonateListCell ()
{
    UIView *m_pLineView;
    UIImageView *m_pCoverImgView;
    UILabel *m_pTitleLab;
}

@end

@implementation YYDonateListCell

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
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 0, SCREEN_WIDTH - 40*[AppConfigure GetLengthAdaptRate], 1)];
    m_pLineView.backgroundColor = UIColorFromHex(0xf2f2f2);
    [self.contentView addSubview:m_pLineView];
    
    m_pCoverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pLineView.bottom + 10*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH - 40*[AppConfigure GetLengthAdaptRate], 200*[AppConfigure GetLengthAdaptRate])];
    m_pCoverImgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:m_pCoverImgView];
    
    m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pCoverImgView.bottom, SCREEN_WIDTH-40*[AppConfigure GetLengthAdaptRate], 36*[AppConfigure GetLengthAdaptRate])];
    m_pTitleLab.text = @"什么鬼辣鸡";
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14.0f];
    m_pTitleLab.textColor = UIColorFromHex(0x333333);
    [self addSubview:m_pTitleLab];
}

#pragma mark - public methods
-(void)SetLineViewShow:(BOOL)argShow
{
    m_pLineView.hidden = argShow;
}
-(void)SetDonateData:(YYDonateData *)argData
{
    m_pTitleLab.text = argData.title;
}

@end
