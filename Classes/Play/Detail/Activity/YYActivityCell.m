//
//  YYActivityCell.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYActivityCell.h"
#import "YYUtil.h"

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
    if (self) {
        [self createSubview];
    }
    
    return self;
}

-(void)createSubview
{
    
    _m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(35*[AppConfigure GetLengthAdaptRate], 0, 1, 180*[AppConfigure GetLengthAdaptRate])];
    _m_pLineView.backgroundColor = UIColorFromHex(0xcccccc);
    [self addSubview:_m_pLineView];
    
    _m_pTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    _m_pTimeLab.center = CGPointMake(CGRectGetMinX(_m_pLineView.frame), 33);
    _m_pTimeLab.backgroundColor = UIColorFromHex(0x7bb63d);
    _m_pTimeLab.layer.cornerRadius = 33/2;
    _m_pTimeLab.clipsToBounds = YES;
    _m_pTimeLab.font = [UIFont systemFontOfSize:10.f];
    _m_pTimeLab.textAlignment = NSTextAlignmentCenter;
    _m_pTimeLab.text = @"12-25";
//    _m_pTitleLab.layer.
    [self addSubview:_m_pTimeLab];
    
    
    _m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(60*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], 200, 14)];
    _m_pTitleLab.textAlignment = NSTextAlignmentLeft;
    _m_pTitleLab.text = @"fFFFFFFFFFFFFFFF";
    _m_pTitleLab.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:_m_pTitleLab];
    
    _m_pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(59*[AppConfigure GetLengthAdaptRate], 52*[AppConfigure GetLengthAdaptRate], SCREEN_WIDTH, 131*[AppConfigure GetLengthAdaptRate])];
    [_m_pImageView setImage:[UIImage imageNamed:@"1126"]];
    [self addSubview:_m_pImageView];
    
}

-(void)setData:(YYActivityData *)data
{
    __weak UIImageView *weakVIew = _m_pImageView;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:data.banner];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakVIew setImage:image];
        });
    });
    
    NSInteger time = [data.startDate integerValue];
    
    [_m_pTimeLab setText:[NSString stringWithFormat:@"%@",[YYUtil timeForYearWithTimeInterval:time*1000]]];
    [_m_pTitleLab setText:data.title];
    
}

-(void)setColor:(UIColor *)color
{
    [_m_pTimeLab setBackgroundColor:color];
}

@end
