//
//  YYYiHomePageController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiHomePageController.h"
#import "YYYiHomePageView.h"
#import "YYShareView.h"
#import "YYYiFriendDetailController.h"
#import "YYDonationData.h"
#import "YYFriendData.h"
#import "YYRichTextDetailController.h"
#import "YYDonateListController.h"

@interface YYYiHomePageController ()
{
    YYYiHomePageView *m_pHomePageView;
    BUAFHttpRequest *m_pFriendRequest;
    BUAFHttpRequest *m_pDonateRequest;
}

@end

@implementation YYYiHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    m_pNameLabel.text = @"忆";
    m_pTopBar.hidden = YES;
    [self CreateSubViews];
    [self CreateRequest];

}

#pragma mark - private methods 
-(void)CreateSubViews
{
    m_pHomePageView = [[YYYiHomePageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - TABBAR_HEIGHT)];
    [self.view addSubview:m_pHomePageView];
}

-(void)CreateRequest
{
    m_pFriendRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Friends/getFriends"] andTag:@"friend"];
    m_pFriendRequest.propDelegate = self;
    m_pFriendRequest.propDataClass = [YYFriendData class];
    [m_pFriendRequest GetAsynchronous];
    
    m_pDonateRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Friends/getDonateList"] andTag:@"donate"];
    m_pDonateRequest.propDelegate = self;
    m_pDonateRequest.propDataClass = [YYDonationData class];
    [m_pDonateRequest GetAsynchronous];
    
    [self ShowProgressHUDWithMessage:@"Loading..."];
}
#pragma mark - public methods
-(void)ClickCheckDetailsWithData:(YYFriendData *)argData
{
    YYRichTextDetailController *pFriendDetailVC = [[YYRichTextDetailController alloc] init];
    pFriendDetailVC.propContent = argData.content;
    [self PushChildViewController:pFriendDetailVC];
}
-(void)CheckMoreContent
{
    YYDonateListController *pDonateListVC = [[YYDonateListController alloc] init];
    [self PushChildViewController:pDonateListVC];
}
-(void)RefreshData
{
    [m_pFriendRequest GetAsynchronous];
    [m_pDonateRequest GetAsynchronous];
}

#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"friend"])
    {
        [m_pHomePageView SetFriendData:argData];
    }
    if ([argRequestTag isEqualToString:@"donate"])
    {
        [m_pHomePageView SetDonationData:argData];
    }
    if (m_pDonateRequest.proRequestRunning == NO && m_pFriendRequest.proRequestRunning == NO)
    {
        [self HideProgressHUD];
    }
}
- (void)RequestErrorHappened:(BUAFHttpRequest *)argRequest withErrorMsg:(NSString *)argMsg
{
    [self RequestFailed:argRequest];
}

- (void)RequestFailed:(BUAFHttpRequest *)argRequest
{
    [self HideProgressHUD];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
