//
//  YYOtherDetilView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYOtherDetilView.h"
#import "UIImageView+AFNetworking.h"
#import "YYOtherDetailViewController.h"
#import "YYOtherTableCell.h"
#import "YYOtherHeadView.h"

@interface YYOtherDetilView() <UITableViewDelegate, UITableViewDataSource>
{
    UIButton *m_pBackBtn;
    
    YYOtherHeadView *m_pTableHaderView;
    UITableView *m_pTableView;
    
    YYPLayOtherData *m_pData;
}

@end

@implementation YYOtherDetilView

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
        [self createSubview];
    }
    return self;
}

-(void)createSubview
{
//    [self createFristView];
    
    m_pTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    m_pTableView.dataSource = self;
    m_pTableView.delegate = self;
    m_pTableView.backgroundColor = [UIColor clearColor];
    m_pTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:m_pTableView];
    
    m_pTableView.tableHeaderView = [self createHeaderView];
    
    [self createNavBtn];
//    [self createSecondView];

}

-(void)createNavBtn
{
    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pBackBtn setFrame:CGRectMake(20, 31, 28, 28)];
    [m_pBackBtn setImage:[UIImage imageNamed:@"custom_back_btn"] forState:UIControlStateNormal];
    [m_pBackBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_pBackBtn];
    
    

}

-(UIView *)createHeaderView
{
    if (!m_pTableHaderView) {
        m_pTableHaderView = [[YYOtherHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270*[AppConfigure GetLengthAdaptRate])];
        
        
        
    }
    return m_pTableHaderView;
}


-(void)createFristView
{
}

-(UILabel*)createLabel:(CGRect)frame size:(CGFloat)size space:(CGFloat)ySpace isBold:(BOOL)isBold isWhiteColor:(BOOL)isWhite;
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)+ySpace, SCREEN_WIDTH-(30*[AppConfigure GetLengthAdaptRate])-CGRectGetMinX(frame), size)];
    lab.text = @"人这一辈子";
    if (isWhite) {
        [lab setTextColor:[UIColor whiteColor]];
    }
    else {
        [lab setTextColor:[UIColor blackColor]];
    }
    if (isBold) {
        [lab setFont:[UIFont boldSystemFontOfSize:size]];
    }
    else {
        [lab setFont:[UIFont systemFontOfSize:size]];
    }
    [self addSubview:lab];
    return lab;
}

-(CGRect)computeTextSize:(NSString *)text boundSize:(CGSize)boundSize textFont:(CGFloat)font
{
    if (strIsEmpty(text)) {
        text = @"  ";
    }
    NSAttributedString *s = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    NSRange range = NSMakeRange(0, text.length);
    NSDictionary *dic = [s attributesAtIndex:0 effectiveRange:&range];
    CGRect rect = [text boundingRectWithSize:boundSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect;
}

-(void)setData:(YYPLayOtherData *)data
{
    
    m_pData = data;
    [m_pTableHaderView setData:data];
    [m_pTableView reloadData];
    
}

#pragma mark - action

-(void)back:(UIButton *)sender
{
    [(YYOtherDetailViewController *)[self GetSubordinateControllerForSelf] Back];
}


#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat sum = 30;
    CGFloat titlH = 18;
    sum += titlH;
    CGRect rect;
    CGFloat labWidth = SCREEN_WIDTH - 40;
    CGSize boundSize = CGSizeMake(labWidth, FLT_MAX);


    switch (indexPath.row) {
        case 0:
        {
            rect = [self computeTextSize:m_pData.company boundSize:boundSize textFont:14];
            
        }
            break;
        case 1:
        {
            rect = [self computeTextSize:m_pData.honor boundSize:boundSize textFont:14];
        }
            break;
        case 2:
        {
            rect = [self computeTextSize:m_pData.introduce boundSize:boundSize textFont:14];
        }
            break;
            
        default:
            break;
    }
    
    sum += rect.size.height;
    return  sum;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYOtherTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYOtherTableCell"];
    if (cell == nil) {
        cell = [[YYOtherTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYOtherTableCell"];
    }
    
    NSString *str = nil;
    int type = [m_pData.type intValue];
    switch (type) {
        case 1:
            str = @"电影概述";
            break;
        case 2:
            str = @"电视剧概述";
            break;
        case 3:
            str = @"话剧概述";
            break;
        case 4:
            str = @"曲剧概述";
            break;
        default:
            str = @"概述";
            break;
    }
    
    NSString *title = indexPath.row == 0 ? @"制作公司": indexPath.row == 1 ? @"荣誉": str;
    cell.m_pTitle = title;
    cell.m_pSubtitle = indexPath.row == 0 ? m_pData.company: indexPath.row == 1 ? m_pData.honor : m_pData.introduce;
    
    return cell;
}


@end
