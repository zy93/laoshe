//
//  YYYIDonationCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/12.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiDonationCell.h"
#import "YYTitleBottomScrollView.h"

@interface YYYiDonationCell ()
{
    YYTitleBottomScrollView *m_pDonationView;
}

@end

@implementation YYYiDonationCell

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
    m_pDonationView = [[YYTitleBottomScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*[AppConfigure GetLengthAdaptRate]) andYiOrPlay:YES];
    [m_pDonationView SetTitleText:@"大众捐献"];
    [self.contentView addSubview:m_pDonationView];
}

#pragma mark - public methods
-(void)SetDonationData:(NSArray *)argData
{
    [m_pDonationView SetData:argData];
}
-(void)SetType:(NSInteger)argType
{
    [m_pDonationView SetType:argType];
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
