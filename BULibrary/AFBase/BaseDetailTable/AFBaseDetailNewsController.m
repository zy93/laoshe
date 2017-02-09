//
//  SXBaseDetailNewsController.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/16.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFBaseDetailNewsController.h"
#import "NSString+IntValue.h"
#import "AFCommentData.h"
//#import "SXLoginController.h"
//#import "SXShareView.h"
//#import "UMSocial.h"

@interface AFBaseDetailNewsController ()<AFBaseDetailViewDelegate>
{
//    SXShareView *m_pShareV;
}

@end

@implementation AFBaseDetailNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetupTopBar];
    
//    m_pShareV = [[SXShareView alloc]initWithFrame:self.view.bounds];
//    m_pShareV.propDelegate = self;
//    [self.view addSubview:m_pShareV];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)SetupTopBar
{
    NSString *strOnlineParam = [[NSUserDefaults standardUserDefaults]objectForKey:@"OnlineParam"];
    if ([strOnlineParam isEqualToString:@"1"] && strOnlineParam != nil)
    {
        UIButton *pShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 39 - 10 * [AppConfigure GetLengthAdaptRate],0+[AppConfigure GetYStartPos],44 , 44)];
        [pShareBtn setImageEdgeInsets:UIEdgeInsetsMake(5 , 5 , 5 , 5 )];
        [pShareBtn setExclusiveTouch:YES];
        [pShareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [pShareBtn addTarget:self action:@selector(ShareToOthers) forControlEvents:UIControlEventTouchUpInside];
        [m_pTopBar addSubview:pShareBtn];
    }
}

#pragma mark -- public method
- (void)AddMainView:(Class)argClass
{
    m_pBaseDetailV = [[[argClass class] alloc]initWithFrame:CGRectMake(0, m_pTopBar.bottom, self.view.width, self.view.height - m_pTopBar.bottom)];
    m_pBaseDetailV.propNewsId = self.propNewsId;
    m_pBaseDetailV.proDelegate = self;
    m_pBaseDetailV.propDelegate = self;
    [self.view addSubview:m_pBaseDetailV];
}

- (void)StartRequestDataWithParam:(NSString*)argDetailNewsUrl DetailNewsDataClass:(Class)argDataClass CommentUrl:(NSString*)argCommentUrl NewsIdType:(NSString*)argIdType InformUrl:(NSString *)argInformUrl
{
    m_strDetailNewsUrl = argDetailNewsUrl;
    m_strCommentUrl = argCommentUrl;
    m_classData = argDataClass;
    m_strIdType = argIdType;
    m_strInformUrl = argInformUrl;
    [self StartRequestDetailNews:self.propNewsId];
    [self StartRequestComment:self.propNewsId StartId:0];
    
    if ([argIdType isEqualToString:@"newsId"])
    {
        m_strShareUrl = [NSString stringWithFormat:@"http://share.sxgajt.com/message.php?id=%li",self.propNewsId];
    }
    else if ([argIdType isEqualToString:@"citySpeedInfoId"])
    {
        m_strShareUrl = [NSString stringWithFormat:@"http://share.sxgajt.com/citySpeed.php?id=%li",self.propNewsId];
    }
    else if ([argIdType isEqualToString:@"highRoadInfoId"])
    {
        m_strShareUrl = [NSString stringWithFormat:@"http://share.sxgajt.com/roadInfo.php?id=%li",self.propNewsId];
    }
}

#pragma mark -- 数据请求接口
- (void)StartRequestDetailNews:(NSInteger)argNewsId
{
    m_pDetailNewsRequest = [[BUAFHttpRequest alloc]initWithUrl:m_strDetailNewsUrl andTag:REQUEST_DETAIL_NEWS];
    [m_pDetailNewsRequest SetParamValue:[NSString IntergerString:argNewsId] forKey:m_strIdType];
    m_pDetailNewsRequest.propDataClass = m_classData;
    m_pDetailNewsRequest.propDelegate = self;
    [m_pDetailNewsRequest GetAsynchronous];
}

- (void)StartRequestComment:(NSInteger)argNewsId StartId:(NSInteger)argStartId
{
    [m_pCommentRequest Cancel];
    m_pCommentRequest = [[BUAFHttpRequest alloc]initWithUrl:m_strCommentUrl andTag:REQUEST_COMMENTS];
    [m_pCommentRequest SetParamValue:[NSString IntergerString:argNewsId] forKey:m_strIdType];
    [m_pCommentRequest SetParamValue:[NSString IntergerString:argStartId] forKey:@"startId"];
    [m_pCommentRequest SetParamValue:[NSString IntergerString:10] forKey:@"count"];
    m_pCommentRequest.propDataClass = [AFCommentData class];
    m_pCommentRequest.propDelegate = self;
    [m_pCommentRequest GetAsynchronous];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private method
/**
 *  分享
 */
- (void)ShareToOthers
{
//    [self.view bringSubviewToFront:m_pShareV];
//    [m_pShareV ShowShareView];
}

#pragma mark -- SXShareViewDelegate method
//- (void)ShareToSina
//{
//    [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@%@",m_pBaseDetailV->m_pBaseDetailHeaderV->m_strShareContent,m_strShareUrl]
//                                                            shareImage:nil
//                                                      socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//}
//
////实现回调方法
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}
//
//- (void)ShareToWeiXin
//{
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = m_pBaseDetailV->m_pBaseDetailHeaderV->m_strShareTitle;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = m_strShareUrl;
//    //微信好友
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession]
//                                                        content:m_pBaseDetailV->m_pBaseDetailHeaderV->m_strShareContent
//                                                          image:m_pBaseDetailV->m_pBaseDetailHeaderV->m_pImage
//                                                       location:nil
//                                                    urlResource:nil
//                                            presentedController:self
//                                                     completion:^(UMSocialResponseEntity *response)
//     {
//         if (response.responseCode == UMSResponseCodeSuccess)
//         {
//             NSLog(@"分享成功！");
//         }
//     }];
//}
//
//- (void)ShareToWeiXinFriend
//{
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = m_pBaseDetailV->m_pBaseDetailHeaderV->m_strShareTitle;
//    NSString *strUrl= m_strShareUrl;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = strUrl;
//    
//    //微信朋友圈
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline]
//                                                        content:m_pBaseDetailV->m_pBaseDetailHeaderV->m_strShareContent
//                                                          image:m_pBaseDetailV->m_pBaseDetailHeaderV->m_pImage
//                                                       location:nil
//                                                    urlResource:nil
//                                            presentedController:self
//                                                     completion:^(UMSocialResponseEntity *response)
//     {
//         if (response.responseCode == UMSResponseCodeSuccess)
//         {
//             NSLog(@"分享成功！");
//         }
//     }];
//}

#pragma mark -- SXBaseTableViewDelegate method
- (void)RefreshDataWithStartId:(NSInteger)argStartId
{
    [self StartRequestComment:self.propNewsId StartId:argStartId];
}

- (void)PushToNextPage:(id)argData
{
    
}

#pragma mark -- SXBaseDetailViewDelegate method
//- (void)Login
//{
//    SXLoginController *pLoginVC = [[SXLoginController alloc]init];
//    UINavigationController *pLoginNVC = [[UINavigationController alloc]initWithRootViewController:pLoginVC];
//    [self presentViewController:pLoginNVC animated:YES completion:nil];
//}
//
//- (void)InformComment:(NSInteger)argCommentId Reason:(NSString *)argReason
//{
//    m_pInformCommentRequest = [[BUAFHttpRequest alloc]initWithUrl:m_strInformUrl andTag:@"InformComment"];
//    [m_pInformCommentRequest SetParamValue:[NSString IntergerString:[SXLoginTool sharedSXLoginTool].propUserData.uid] forKey:@"uid"];
//    [m_pInformCommentRequest SetParamValue:[SXLoginTool sharedSXLoginTool].propUserData.token forKey:@"token"];
//    [m_pInformCommentRequest SetParamValue:[NSString IntergerString:argCommentId] forKey:@"commentId"];
//    [m_pInformCommentRequest SetParamValue:argReason forKey:@"reason"];
//    m_pInformCommentRequest.propSilent = YES;
//    m_pInformCommentRequest.propDataClass = [SXCommentData class];
//    m_pInformCommentRequest.propDelegate = self;
//    [m_pInformCommentRequest PostAsynchronous];
//}

#pragma mark -- BUAFHttpRequestDelegate Method
- (void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:REQUEST_DETAIL_NEWS])
    {
        [m_pBaseDetailV SetHeaderData:argData[0]];
    }
    else if ([argRequestTag isEqualToString:REQUEST_COMMENTS])
    {
        [m_pBaseDetailV SetTableViewData:argData];
    }
    else if ([argRequestTag isEqualToString:@"InformComment"])
    {
        UIAlertView *pAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"举报成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [pAlert show];
    }
}

- (void)RequestErrorHappened:(BUAFHttpRequest *)argRequest withErrorMsg:(NSString *)argMsg
{
    [self RequestFailed:argRequest];
}

- (void)RequestFailed:(BUAFHttpRequest *)argRequest
{
    if ([argRequest.propRequestTag isEqualToString:REQUEST_COMMENTS])
    {
        [m_pBaseDetailV SetTableViewData:nil];
    }
}

@end
