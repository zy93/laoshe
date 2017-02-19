//
//  ZYBookListView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "ZYBookListView.h"
#import "ZYListenBookData.h"
#import "YYUtil.h"
#import "ZYBookListViewCell.h"

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
        [self createSubviewWithFrame:frame];
    }
    
    return self;
}

-(void)createSubviewWithFrame:(CGRect)frame
{
    CGFloat tabHigth = 394*[AppConfigure GetLengthAdaptRate];
    
    m_topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), frame.size.height-tabHigth)];
    m_topView.backgroundColor = [UIColor clearColor];
    [self addSubview:m_topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    //    tap.delegate = self;
    [m_topView addGestureRecognizer:tap];
    
    
    m_table = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, CGRectGetWidth(frame), tabHigth) style:UITableViewStylePlain];
    m_table.separatorStyle =UITableViewCellSeparatorStyleNone;
    m_table.delegate = self;
    m_table.dataSource = self;
    [self addSubview:m_table];
}

-(void)tapView:(UITapGestureRecognizer *)tap
{
    [self hiddenBookMenu];
}

-(void)setM_bookList:(NSArray *)m_bookList
{
    _m_bookList = m_bookList;
    [m_table reloadData];
}

-(void)showView
{
    self.hidden = NO;
    CGFloat tabHigth =394*[AppConfigure GetLengthAdaptRate];
    [UIView animateWithDuration:0.5 animations:^{
        [m_table setFrame:CGRectMake(0, self.frame.size.height-tabHigth, CGRectGetWidth(self.frame), tabHigth)];
    }];
}

-(void)hiddenBookMenu
{
    CGFloat h =394*[AppConfigure GetLengthAdaptRate];
    [UIView animateWithDuration:0.5 animations:^{
        [m_table setFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), h)];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
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
    ZYBookListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BOOKListCell"];
    if (cell == nil) {
        cell = [[ZYBookListViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BOOKListCell"];
    }
    ZYChapter *chapter = self.m_bookList[indexPath.row];
    [cell.m_pTitleLabel setText:[NSString stringWithFormat:@"%@ %@", chapter.title, chapter.chapter]];
    [cell.m_pSubtitleLab setText:chapter.time];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    if (indexPath.row == _playBookIndex) {
        [cell.m_pTitleLabel setTextColor: UIColorFromHex(blue_45)];
        [cell.m_pSubtitleLab setTextColor: UIColorFromHex(blue_45)];
    }
    else {
        [cell.m_pTitleLabel setTextColor: UIColorFromHex(black_66)];
        [cell.m_pSubtitleLab setTextColor: UIColorFromHex(black_66)];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hiddenBookMenu];
    if ([_delegate respondsToSelector:@selector(selectBookIndex:)]) {
        [_delegate selectBookIndex:indexPath.row];
    }
}


@end
