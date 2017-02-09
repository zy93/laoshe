//
//  SXCommentCell.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/11/25.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFCommentCell.h"
#import "UIImageView+AFNetworking.h"
#import "STTimeUtility.h"

#define COMMTNTCELL @"comment_cell"

@implementation AFCommentCell

+ (instancetype)CellWithTableView:(UITableView *)argTableView
{
    AFCommentCell *pCommentCell = [argTableView dequeueReusableCellWithIdentifier:COMMTNTCELL];
    if (pCommentCell == nil)
    {
        pCommentCell = [[AFCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COMMTNTCELL];
    }
    pCommentCell.backgroundColor = [AppConfigure WhiteColor];
    return pCommentCell;
}

- (void)AddSubViews
{
    [super AddSubViews];
    if (m_pLongGest == nil)
    {
        m_pLongGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(InformComment:)];
        [self addGestureRecognizer:m_pLongGest];
    }
}

- (void)ClearData
{
    [super ClearData];
}

- (void)setPropCommentData:(AFCommentData *)propCommentData
{
//    _propCommentData = propCommentData;
//    if (![_propCommentData.toNickName isEqualToString:@""])
//    {
//        NSString *strTitle = [NSString stringWithFormat:@"%@回复%@",_propCommentData.nickName,_propCommentData.toNickName];
//        NSRange rText = [strTitle rangeOfString:@"回复"];
//        NSMutableAttributedString *strAttriTitle = [[NSMutableAttributedString alloc]initWithString:strTitle];
//        [strAttriTitle addAttributes:@{NSForegroundColorAttributeName : [AppConfigure LightGrayColor]} range:rText];
//        [m_pTitle setAttributedText:strAttriTitle];
//    }
//    else
//    {
//        m_pTitle.text = _propCommentData.nickName;
//    }
//    [m_pTypeIcon setImageWithURL:[NSURL URLWithString:_propCommentData.headImage] placeholderImage:[UIImage imageNamed:@"placehold"]];
//    
//    NSDate *pCommentDate = [NSDate dateWithTimeIntervalSince1970:_propCommentData.time];
//    m_pTime.text = [STTimeUtility GetTimeDistanceString:pCommentDate];
//    m_pContentLb.text = _propCommentData.text;
}

#pragma mark -- InformComment method
- (void)InformComment:(UILongPressGestureRecognizer *)argLongGest
{
    if (argLongGest.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet *pSheet = [[UIActionSheet alloc]initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"广告欺诈",@"淫秽色情",@"骚扰谩骂",@"反动政治",@"其他", nil];
        [pSheet showInView:self];
    }
}

#pragma mark -- UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 5)
    {
        NSArray *arrReason = @[@"广告欺诈",@"淫秽色情",@"骚扰谩骂",@"反动政治",@"其他"];
        if (self.propDel != nil && [self.propDel respondsToSelector:@selector(InformComment:Reason:)])
        {
            [self.propDel InformComment:self.propCommentData.commentId Reason:arrReason[buttonIndex]];
        }
    }
    
}

@end
