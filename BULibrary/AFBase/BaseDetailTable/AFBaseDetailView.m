//
//  SXBaseDetailView.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/15.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFBaseDetailView.h"
#import "NSString+IntValue.h"
#import "AFCommentData.h"
//#import "SXLoginTool.h"

@implementation AFBaseDetailView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self SetupSendCommentView];
        [self AddRefreshHeader];
        [self AddRefreshFooter];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  发表评论的模块
 */
- (void)SetupSendCommentView
{
    m_pBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 50, self.width, 50)];
    m_pBottomView.backgroundColor = [UIColor blackColor];
    [self addSubview:m_pBottomView];
    
    UIImageView *pBG = [[UIImageView alloc]initWithFrame:CGRectMake(20 * [AppConfigure GetLengthAdaptRate], 10 , 275 * [AppConfigure GetLengthAdaptRate] , m_pBottomView.height - 20 )];
    pBG.userInteractionEnabled = YES;
    pBG.backgroundColor = [AppConfigure WhiteColor];
    pBG.layer.cornerRadius = pBG.height / 2;
    pBG.layer.masksToBounds = YES;
    pBG.layer.borderWidth = 1;
    pBG.layer.borderColor = [[AppConfigure GrayColor]CGColor];
    [m_pBottomView addSubview:pBG];
    
    m_pCommentText = [[UITextView alloc]initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 0, 265 * [AppConfigure GetLengthAdaptRate], pBG.height)];
    m_pCommentText.delegate = self;
    m_pCommentText.returnKeyType = UIReturnKeySend;
    m_pCommentText.font = [UIFont fontWithName:[AppConfigure RegularFont] size:13];
    [pBG addSubview:m_pCommentText];
    
    
    m_pSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pSendBtn.frame = CGRectMake(pBG.right + 10 * [AppConfigure GetLengthAdaptRate], 0, self.width - pBG.right - 20 * [AppConfigure GetLengthAdaptRate], m_pBottomView.height );
    [m_pSendBtn setTitle:@"评论" forState:UIControlStateNormal];
    [m_pSendBtn setTitleColor:[AppConfigure BlackColor] forState:UIControlStateNormal];
    m_pSendBtn.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
    [m_pSendBtn addTarget:self action:@selector(SendComment) forControlEvents:UIControlEventTouchUpInside];
    [m_pBottomView addSubview:m_pSendBtn];
    
    m_pActivityIndicatorV = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    m_pActivityIndicatorV.center = CGPointMake(self.width / 2.0f, self.height / 2.0f - 50 * [AppConfigure GetLengthAdaptRate]);
    [self addSubview:m_pActivityIndicatorV];
    [self bringSubviewToFront:m_pActivityIndicatorV];
    [m_pActivityIndicatorV startAnimating];
}

#pragma mark -- super method
- (void)SetupBaseTableView
{
    [super SetupBaseTableView];
     [self sendSubviewToBack:m_pBaseTable];
    m_pBaseTable.hidden = YES;
    m_pBaseTable.frame = CGRectMake(0, 0, self.width, self.height - 50);
    [self sendSubviewToBack:m_pBaseTable];
}

#pragma mark -- public method
- (void)setPropNewsId:(NSInteger)propNewsId
{
    _propNewsId = propNewsId;
}

- (void)SetHeaderData:(id)argData
{
    [m_pBaseDetailHeaderV SetData:argData];
}

- (void)SetupTableHeaderView:(Class)argClass
{
    /**
     设置表首
     */
    m_pBaseDetailHeaderV = [[[argClass class] alloc]initWithFrame:CGRectMake(0, 0, self.width, 100)];
    m_pBaseDetailHeaderV.propDel = self;
    m_pBaseDetailHeaderV.frame = CGRectMake(0, 0, self.width, [m_pBaseDetailHeaderV GetViewHeight]);
    m_pBaseTable.tableHeaderView = m_pBaseDetailHeaderV;
}

- (void)SetSendCommentParam:(NSString *)argUrl IdType:(NSString *)argIdType
{
    m_strDetailNewsUrl = argUrl;
    m_strIdType = argIdType;
}

#pragma mark -- sendcomment method
/**
 *  发表评论
 */
- (void)SendComment
{
//    [m_pCommentText resignFirstResponder];
//     if ([SXLoginTool sharedSXLoginTool].propLoginSucceed == NO)
//     {
//         return;
//    }
//    m_pSendCommentRequest = [[BUAFHttpRequest alloc]initWithUrl:m_strDetailNewsUrl andTag:SEND_COMMENT];
//    [m_pSendCommentRequest SetParamValue:[NSString IntergerString:[SXLoginTool sharedSXLoginTool].propUserData.uid] forKey:@"uid"];
//    if (m_pCommentData == nil)
//    {
//        [m_pSendCommentRequest SetParamValue:[NSString IntergerString:0] forKey:@"toUid"];
//    }
//    else
//    {
//        [m_pSendCommentRequest SetParamValue:[NSString IntergerString:m_pCommentData.uid] forKey:@"toUid"];
//    }
//    [m_pSendCommentRequest SetParamValue:[NSString IntergerString:self.propNewsId] forKey:m_strIdType];
//    [m_pSendCommentRequest SetParamValue:m_pCommentText.text forKey:@"text"];
//    m_pSendCommentRequest.propSilent = YES;
//    m_pSendCommentRequest.propDelegate = self;
//    [m_pSendCommentRequest PostAsynchronous];
//    m_pCommentText.text = @"";
}

#pragma mark -- UITableViewDatasource method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return m_arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SXCommentCell *pCommentCell = [SXCommentCell CellWithTableView:tableView];
//    [pCommentCell ClearData];
//    pCommentCell.propCommentData = m_arrData[indexPath.row];
//    pCommentCell.propDel = self;
//    return pCommentCell;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SXCommentData *pCommentData = m_arrData[indexPath.row];
//    CGSize pCommentSize = [pCommentData.text boundingRectWithSize:CGSizeMake(self.width - 60 * [AppConfigure GetLengthAdaptRate], 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:[AppConfigure RegularFont] size:13]} context:nil].size;
//    return 30 * [AppConfigure GetLengthAdaptRate] + SIZE_HEIGHT(13) + pCommentSize.height;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 20 * [AppConfigure GetLengthAdaptRate];
    }
    return 40 * [AppConfigure GetLengthAdaptRate];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (m_pAllComments == nil)
    {
        m_pAllComments = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 40 * [AppConfigure GetLengthAdaptRate])];
        m_pAllComments.textColor = [AppConfigure BlackColor];
        m_pAllComments.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
        m_pAllComments.backgroundColor = [UIColor whiteColor];
        m_pAllComments.text = @"全部评论";
    }
    return m_pAllComments;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    SXCommentCell *pCommentCell = [tableView cellForRowAtIndexPath:indexPath];
//    m_pCommentData = pCommentCell.propCommentData;
//    m_pCommentText.placeholder = [NSString stringWithFormat:@"回复:%@",m_pCommentData.nickName];
//    [m_pCommentText becomeFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    m_pCommentText.placeholder = @"发表你的看法";
//    [m_pCommentText resignFirstResponder];
}

#pragma mark -- keyboard notification method
- (void)KeyboardWillHide:(NSNotification *)argNotification
{
     m_pBottomView.transform = CGAffineTransformIdentity;
}

- (void)KeyboardWillShow:(NSNotification *)argNotification
{
//    if ([SXLoginTool sharedSXLoginTool].propLoginSucceed == NO)
//    {
//        if ([SXLoginTool sharedSXLoginTool].propHadPopLoginPage == NO)
//        {
//            [self endEditing:YES];
//            if ([self.propDelegate respondsToSelector:@selector(Login)] && self.propDelegate != nil)
//            {
//                [self.propDelegate Login];
//            }
//        }
//        return;
//    }
    CGFloat fDuration = [argNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat fKeyboardY = [argNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat fHeight = self.height +  45+[AppConfigure GetYStartPos];
    CGFloat fInterval = fHeight - fKeyboardY;
    m_pBottomView.transform = CGAffineTransformIdentity;
    __weak UIView *weakView = m_pBottomView;
    [UIView animateWithDuration:fDuration animations:^{
        weakView.transform = CGAffineTransformMakeTranslation(0, -fInterval);
    }];
}

#pragma mark -- private method
- (void)PersonSendComment
{
    m_pCommentData = nil;
    [self SendComment];
}

#pragma mark -- UITextViewDelegate method
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])//判断输入的字是否是回车，即按下return
    {
        [self SendComment];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

#pragma mark -- SXCommentCellDelegate method
- (void)InformComment:(NSInteger)argCommentId Reason:(NSString *)argReason
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(InformComment:Reason:)])
    {
        [self.propDelegate InformComment:argCommentId Reason:argReason];
    }
}

#pragma mark -- SXDetailNewsHeaderViewDelegate method
- (void)ChangeDetailNewsHeaderHeight:(CGFloat)argHeight
{
    m_pBaseDetailHeaderV.frame = CGRectMake(0, 0, self.width, argHeight);
    m_pBaseTable.tableHeaderView = m_pBaseDetailHeaderV;
    m_pBaseTable.hidden = NO;
    [m_pActivityIndicatorV stopAnimating];
}

#pragma  mark -- BUAFHttpRequestDelegate method
- (void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:SEND_COMMENT])
    {
        [self performSelector:@selector(PopAlertView) withObject:nil afterDelay:0.5f];
        [self StartRefresh];
    }
}

- (void)PopAlertView
{
    UIAlertView *pAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评论成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [pAlert show];
}

@end
