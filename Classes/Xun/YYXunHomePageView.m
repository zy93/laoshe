//
//  YYXunHomePageView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/26.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYXunHomePageView.h"
#import "YYXunHomePageCell.h"
#import "YYXunData.h"

@interface YYXunHomePageView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *m_pTableView;
    NSMutableArray *m_arrData;
}

@end

@implementation YYXunHomePageView

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
-(void)SetXunHomePageData:(NSArray *)argData
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
    static NSString *identifier = @"YYXunHomePageCell";
    YYXunHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[YYXunHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell SetData:m_arrData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == m_arrData.count - 1)
    {
        CGFloat pMainH = 134*[AppConfigure GetLengthAdaptRate];
        return pMainH;
    }
    CGFloat pMainH = 124*[AppConfigure GetLengthAdaptRate];
    return pMainH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(CheckDetail:)])
    {
        [self.propDelegate CheckDetail:m_arrData[indexPath.row]];
    }
}



@end
