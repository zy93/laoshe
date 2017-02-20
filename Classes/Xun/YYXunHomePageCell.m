//
//  YYXunHomePageCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/26.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYXunHomePageCell.h"
#import "YYXunData.h"
#import "UIImageView+AFNetworking.h"

@interface YYXunHomePageCell ()
{
    UIImageView *m_pBackgroundView;
    UILabel *m_pTitleLab;
}

@end

@implementation YYXunHomePageCell

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
    m_pBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], 8*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH - 20*[AppConfigure GetLengthAdaptRate], 116*[AppConfigure GetLengthAdaptRate])];
//    m_pBackgroundView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:m_pBackgroundView];
    
    m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_pBackgroundView.width, m_pBackgroundView.height)];
    m_pTitleLab.text = @"英国伦敦";
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:18.0f];
    m_pTitleLab.textColor = UIColorFromHex(0xffffff);
    m_pTitleLab.textAlignment = NSTextAlignmentCenter;
    [m_pBackgroundView addSubview:m_pTitleLab];
}

#pragma mark - public methods
-(void)SetData:(YYXunData *)argData
{
    m_pTitleLab.text = argData.title;
    [m_pBackgroundView setImageWithURL:[NSURL URLWithString:argData.cover] placeholderImage:nil];
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
