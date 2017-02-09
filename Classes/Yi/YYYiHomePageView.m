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

@interface YYYiHomePageView ()<UITableViewDelegate,UITableViewDataSource>
{
    YYYiHeadView *m_pHeadView;
    UITableView *m_pTableView;
}

@end

@implementation YYYiHomePageView

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

#pragma mark - UITableViewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YYYiFriendsCell";
    YYYiFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[YYYiFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
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
    CGFloat pMainH = 144*[AppConfigure GetLengthAdaptRate];
    return pMainH;
}

@end
