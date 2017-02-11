//
//  YYYanHomePageCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanHomePageCell.h"
#import "YYTitleBottomScrollView.h"

@interface YYYanHomePageCell ()
{
    YYTitleBottomScrollView *m_pYanDirectoryScrollView;
}
@end

@implementation YYYanHomePageCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pYanDirectoryScrollView = [[YYTitleBottomScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 144*[AppConfigure GetLengthAdaptRate])];
    [self.contentView addSubview:m_pYanDirectoryScrollView];
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
