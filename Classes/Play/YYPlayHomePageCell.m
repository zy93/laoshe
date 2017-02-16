//
//  YYPlayHomePageCell.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYPlayHomePageCell.h"
#import "YYTitleBottomScrollView.h"

@interface YYPlayHomePageCell ()<YYTitleBottomScrollViewDelegate>
{
    YYTitleBottomScrollView *m_pYanDirectoryScrollView;
}

@end

@implementation YYPlayHomePageCell

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
    m_pYanDirectoryScrollView = [[YYTitleBottomScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220*[AppConfigure GetLengthAdaptRate]) andYiOrPlay:NO];
    m_pYanDirectoryScrollView.propDelegate = self;
    [self.contentView addSubview:m_pYanDirectoryScrollView];
}

#pragma mark - public methods
-(void)SetDirectoryTitle:(NSString *)argTitle
{
    [m_pYanDirectoryScrollView SetTitleText:argTitle];
}
-(void)SetPlayData:(NSArray *)argData
{
    [m_pYanDirectoryScrollView ClearData];
    [m_pYanDirectoryScrollView SetData:argData];
}
-(void)SetType:(NSInteger)argType
{
    [m_pYanDirectoryScrollView SetType:argType];
}
#pragma mark - YYTitleBottomScrollViewDelegate methods
-(void)ClickCheckDetailsWithId:(NSInteger)argId andType:(NSInteger)argType
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(ClickCheckDetailsWithId:)])
    {
        NSLog(@"argType =======  %ld",(long)argType);
        [self.propDelegate ClickCheckDetailsWithId:argId];
    }
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
