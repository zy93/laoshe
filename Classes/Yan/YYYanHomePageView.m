//
//  YYYanHomePageView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanHomePageView.h"
#import "YYYanHeadView.h"
#import "YYYanHomePageCell.h"

@interface YYYanHomePageView ()<UITableViewDelegate,UITableViewDataSource>
{
    YYYanHeadView *m_pHeadView;
    UITableView *m_pTableView;
}

@end

@implementation YYYanHomePageView

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
    m_pHeadView = [[YYYanHeadView alloc] initWithFrame:CGRectMake(0, 0, self.width, 255*[AppConfigure GetLengthAdaptRate])];
    
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
    static NSString *identifier = @"YYYanHomePageCellMovie";
    YYYanHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[YYYanHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    CGFloat pMainH = 220*[AppConfigure GetLengthAdaptRate];
    return pMainH;
}

@end
