//
//  YYYiHomePageView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiHomePageView.h"
#import "YYYiHeadView.h"
#import "YYYiFriendsCell.h"
#import "YYYiDonationCell.h"
#import "YYYiHomePageController.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>

@interface YYYiHomePageView ()<UITableViewDelegate,UITableViewDataSource,YYYiFriendsCellDelegate,YYYiDonationCellDelegate>
{
    YYYiHeadView *m_pHeadView;
    UITableView *m_pTableView;
    NSMutableArray *m_arrFriendData;
    NSMutableArray *m_arrDonationData;
}

@end

@implementation YYYiHomePageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrFriendData = [NSMutableArray array];
        m_arrDonationData = [NSMutableArray array];
        [self CreateSubViews];
        [self AddRefreshHeader];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    CGFloat fHeadViewHeight = [YYYiHeadView GetHeight];
    m_pHeadView = [[YYYiHeadView alloc] initWithFrame:CGRectMake(0, 0, self.width, fHeadViewHeight)];
    
    m_pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    m_pTableView.delegate = self;
    m_pTableView.dataSource = self;
    m_pTableView.backgroundColor = [UIColor clearColor];
    m_pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:m_pTableView];
    
    m_pTableView.tableHeaderView = m_pHeadView;

}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UITableView *pTableView = m_pTableView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    if (m_pTableView.mj_footer != nil && [m_pTableView.mj_footer isRefreshing])
    {
        [m_pTableView.mj_footer endRefreshing];
    }
    [(YYYiHomePageController *)[self GetSubordinateControllerForSelf] RefreshData];
}

- (void)StopRefresh
{
    if (m_pTableView.mj_header != nil && [m_pTableView.mj_header isRefreshing])
    {
        [m_pTableView.mj_header endRefreshing];
    }
}

#pragma mark - public methods
-(void)SetFriendData:(NSArray *)argData
{
    [m_arrFriendData removeAllObjects];
    [m_arrFriendData addObjectsFromArray:argData];
    [m_pTableView reloadData];
    [self StopRefresh];
}
-(void)SetDonationData:(NSArray *)argData
{
    [m_arrDonationData removeAllObjects];
    [m_arrDonationData addObjectsFromArray:argData];
    [m_pTableView reloadData];
    [self StopRefresh];
}

/////  获取音频文件的时长
//
//-(NSInteger)durationWithVideo:(NSURL *)urlPath
//
//{
//    
//    AVURLAsset *audioAsset=[AVURLAsset assetWithURL:urlPath];
//    CMTime   durationTime = audioAsset.duration;
//    NSInteger    reultTime=0;
//    reultTime = CMTimeGetSeconds(durationTime);
//    return  reultTime;
//    
//}

#pragma mark - UITableViewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *identifier = @"YYYiFriendsCell";
        YYYiFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[YYYiFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.propDelegate = self;
        [cell SetFriendData:m_arrFriendData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        static NSString *identifier = @"YYYiDonationCell";
        YYYiDonationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[YYYiDonationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row == 2) {
            cell.backgroundColor = [UIColor redColor];
        }
        [cell SetType:-1];
        cell.propDelegate = self;
        [cell SetDonationData:m_arrDonationData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 )
    {
        return  200*[AppConfigure GetLengthAdaptRate];
    }
    CGFloat pMainH = 144*[AppConfigure GetLengthAdaptRate];
    return pMainH;
}

#pragma mark - YYYiFriendsCell Delegate
-(void)ClickCheckDetailsWithData:(YYFriendData *)argData
{
    [(YYYiHomePageController *)[self GetSubordinateControllerForSelf] ClickCheckDetailsWithData:argData];
}

#pragma mark - YYYiDonationCellDelegate methods
-(void)CheckMoreContent
{
    [(YYYiHomePageController *)[self GetSubordinateControllerForSelf] CheckMoreContent];
}

@end
