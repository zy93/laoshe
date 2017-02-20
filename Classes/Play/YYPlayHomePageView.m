//
//  YYPlayHomePageView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYPlayHomePageView.h"
#import "YYPlayHeadView.h"
#import "YYPlayHomePageCell.h"
#import "YYPlayHomePageController.h"
#import "YYPlayData.h"

@interface YYPlayHomePageView ()<UITableViewDelegate,UITableViewDataSource,YYPlayHomePageCellDelgate>
{
    YYPlayHeadView *m_pHeadView;
    UITableView *m_pTableView;
    NSMutableArray *m_arrTitle;
    NSMutableArray *m_arrData;
    YYPlayData *m_pData;
}
@end
@implementation YYPlayHomePageView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrData = [NSMutableArray array];
        m_arrTitle = [NSMutableArray arrayWithObjects:@"电影",@"电视剧",@"话剧",@"曲剧",@"其他",@"听书",@"活动",nil];
        self.backgroundColor = [UIColor whiteColor];
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pHeadView = [[YYPlayHeadView alloc] initWithFrame:CGRectMake(0, 0, self.width, 255*[AppConfigure GetLengthAdaptRate])];
    
    m_pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    m_pTableView.delegate = self;
    m_pTableView.dataSource = self;
    m_pTableView.backgroundColor = [UIColor clearColor];
    m_pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:m_pTableView];
    
    m_pTableView.tableHeaderView = m_pHeadView;
}

#pragma mark - public methods
-(void)SetPlayData:(NSArray *)argData
{
    m_pData = [argData firstObject];
    [m_arrData removeAllObjects];
    [m_arrData addObjectsFromArray:argData];
    [m_pTableView reloadData];
}

-(NSArray *)GetAccivity
{
    return m_pData.activity;
}

#pragma mark - UITableViewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrTitle.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YYPlayHomePageCell";
    YYPlayHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[YYPlayHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    [cell ClearData];
    cell.propDelegate = self;
    [cell SetType:indexPath.row];
    switch (indexPath.row)
    {
        case 0:
            [cell SetPlayData:m_pData.movie];
            break;
        case 1:
            [cell SetPlayData:m_pData.TVSeries];
            break;
        case 2:
            [cell SetPlayData:m_pData.drama];
            break;
        case 3:
            [cell SetPlayData:m_pData.opera];
            break;
        case 4:
            [cell SetPlayData:m_pData.other];
            break;
        case 5:
            [cell SetPlayData:m_pData.tingBook];
            break;
        case 6:
            [cell SetPlayData:m_pData.activity];
            break;
        default:
            break;
    }
    [cell SetDirectoryTitle:m_arrTitle[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == m_arrMessage.count - 1)
    //    {
    //        CGFloat pMainH = 82*[AppConfigure GetLengthAdaptRate];
    //        return pMainH;
    //    }
    CGFloat pMainH = 220*[AppConfigure GetLengthAdaptRate];
    return pMainH;
}

#pragma mark - YYPlayHomePageCellDelgate methods
-(void)ClickCheckDetailsWithId:(NSInteger)argId argType:(NSInteger)argType
{
    [(YYPlayHomePageController *)[self GetSubordinateControllerForSelf] ClickCheckDetailsWithId:argId argType:argType];
}

@end
