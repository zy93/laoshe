//
//  YYDonateListView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYDonateListView.h"
#import "YYDonateListCell.h"

@interface YYDonateListView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *m_pTableView;
    NSMutableArray *m_arrData;
}

@end

@implementation YYDonateListView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrData = [NSMutableArray array];
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    m_pTableView.delegate = self;
    m_pTableView.dataSource = self;
    m_pTableView.backgroundColor = [UIColor clearColor];
    m_pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:m_pTableView];
}

#pragma mark - public methods
-(void)SetData:(NSArray *)argData
{
    [m_arrData removeAllObjects];
    [m_arrData addObjectsFromArray:argData];
    [m_pTableView reloadData];
}

#pragma mark - UITableViewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YYDonateListCell";
    YYDonateListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[YYDonateListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0)
    {
        [cell SetLineViewShow:YES];
    }else
    {
        [cell SetLineViewShow:NO];
    }
    [cell ClearData];
//    cell.propDelegate = self;
    [cell SetDonateData:m_arrData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat fHeight = [YYDonateListCell GetHeight:m_arrData[indexPath.row]];
    return  fHeight;
}



@end
