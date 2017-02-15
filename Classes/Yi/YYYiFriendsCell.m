//
//  YYYiFriendsCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/8.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiFriendsCell.h"
#import "YYTitleMiddleScrollView.h"


@interface YYYiFriendsCell ()
{
    YYTitleMiddleScrollView *m_pFriendsScrollView;
}

@end

@implementation YYYiFriendsCell

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
    m_pFriendsScrollView = [[YYTitleMiddleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 144*[AppConfigure GetLengthAdaptRate])];
    [self.contentView addSubview:m_pFriendsScrollView];
}
#pragma mark - public methods
-(void)SetFriendData:(NSArray *)argData
{
    [m_pFriendsScrollView SetData:argData];
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
