//
//  YYActivityCell.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYActivityCell.h"
#import "YYUtil.h"
#import "UIImageView+AFNetworking.h"

@interface YYActivityCell()

@property (nonatomic, strong) UIView *m_pLineView;
@property (nonatomic, strong) UILabel *m_pTimeLab;
@property (nonatomic, strong) UILabel *m_pTitleLab;
@property (nonatomic, strong) UIImageView *m_pImageView;


@end

@implementation YYActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createSubview];
    }
    
    return self;
}

-(void)createSubview
{
    
    _m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(35*[AppConfigure GetLengthAdaptRate], 0, 1, 185*[AppConfigure GetLengthAdaptRate])];
    _m_pLineView.backgroundColor = UIColorFromHex(0xcccccc);
    [self.contentView addSubview:_m_pLineView];
    
    _m_pTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    _m_pTimeLab.center = CGPointMake(CGRectGetMinX(_m_pLineView.frame), 33);
    _m_pTimeLab.backgroundColor = UIColorFromHex(0x7bb63d);
    _m_pTimeLab.layer.cornerRadius = 33/2;
    _m_pTimeLab.clipsToBounds = YES;
    _m_pTimeLab.font = [UIFont systemFontOfSize:10.f];
    _m_pTimeLab.textAlignment = NSTextAlignmentCenter;
    _m_pTimeLab.text = @"12-25";
//    _m_pTitleLab.layer.
    [self.contentView addSubview:_m_pTimeLab];
    
    
    _m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(60*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH - 80*[AppConfigure GetLengthAdaptRate], 14)];
    _m_pTitleLab.textAlignment = NSTextAlignmentLeft;
    _m_pTitleLab.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_m_pTitleLab];
    
    _m_pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(59*[AppConfigure GetLengthAdaptRate], 52*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH-59*[AppConfigure GetLengthAdaptRate], 131*[AppConfigure GetLengthAdaptRate])];
    [self.contentView addSubview:_m_pImageView];
    
}

-(void)setData:(YYActivityData *)data
{
    [_m_pImageView setImageWithURL:[NSURL URLWithString:data.cover1] placeholderImage:nil];
    _m_pImageView.contentMode = UIViewContentModeScaleAspectFill;
    _m_pImageView.clipsToBounds = YES;

    [_m_pTimeLab setText:[NSString stringWithFormat:@"%@",[YYUtil timeForYearWithTimeInterval:data.startDate*1000]]];
    [_m_pTitleLab setText:data.title];
    
}

-(void)setColor:(UIColor *)color
{
    [_m_pTimeLab setBackgroundColor:color];
}

@end
