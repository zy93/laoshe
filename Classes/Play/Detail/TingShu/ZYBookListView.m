//
//  ZYBookListView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "ZYBookListView.h"

@implementation ZYBookListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        m_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) style:UITableViewStylePlain];
        m_table.delegate = self;
        m_table.dataSource = self;
        [self addSubview:m_table];
    }
    
    return self;
}

-(void)setM_bookList:(NSArray *)m_bookList
{
    _m_bookList = m_bookList;
    [m_table reloadData];
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_bookList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BOOKListCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BOOKListCell"];
    }
    
    cell.textLabel.text = @"我这一辈子 第一章";
    cell.detailTextLabel.text = @"03:09";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(selectBookIndex:)]) {
        [_delegate selectBookIndex:indexPath.row];
    }
}


@end
