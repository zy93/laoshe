//
//  ZYBookListViewCell.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "ZYBookListViewCell.h"
#import "AppConfigure.h"


@implementation ZYBookListViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    
    return self;
}

-(void)createSubview
{
    _m_pTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], 200, 14)];
    _m_pTitleLabel.textAlignment = NSTextAlignmentLeft;
    _m_pTitleLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:_m_pTitleLabel];
    
    _m_pSubtitleLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-122)*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], 100, 14)];
    _m_pSubtitleLab.textAlignment = NSTextAlignmentRight;
    _m_pSubtitleLab.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:_m_pSubtitleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 54.f, SCREEN_WIDTH-40, 1)];
    line.backgroundColor = UIColorFromHex(0xf2f2f2);
    [self addSubview:line];
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
