//
//  JJBirthdayRemindCell.m
//  pbuJaaaJa
//
//  Created by  on 16/2/4.
//  Copyright © 2016年 . All rights reserved.
//

#import "AFTitleBannerCell.h"

@implementation AFTitleBannerCell

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self AddSubviews];
    }
    return self;
}

- (void)AddSubviews
{
    m_pShowTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pShowTitle setTitleColor:[AppConfigure GrayColor] forState:UIControlStateNormal];
    [m_pShowTitle setTitle:@"今天妈妈的生日" forState:UIControlStateNormal];
//    [m_pBirthday setImage:[UIImage imageNamed:@"keeper_calendar"] forState:UIControlStateNormal];
    m_pShowTitle.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
    m_pShowTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [m_pBirthday setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    m_pShowTitle.userInteractionEnabled = NO;
    [self.contentView addSubview:m_pShowTitle];
}

- (void)ClearData
{
    [m_pShowTitle setTitle:@"" forState:UIControlStateNormal];
}

- (void)SetTitleData:(NSString *)argTitle
{
    [m_pShowTitle setTitle:argTitle forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    m_pShowTitle.frame = self.bounds;
}

@end
