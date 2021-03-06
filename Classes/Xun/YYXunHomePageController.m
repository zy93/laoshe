//
//  YYXunHomePageController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYXunHomePageController.h"
#import "YYXunHomePageView.h"
#import "YYXunData.h"
#import "YYRichTextDetailController.h"

@interface YYXunHomePageController ()<YYXunHomePageViewDelegate>
{
    YYXunHomePageView *m_pHomePageView;
    BUAFHttpRequest *m_pRequest;
}
@end

@implementation YYXunHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pNameLabel.text = @"寻";
    m_pBackButton.hidden = YES;
    [self CreateSubViews];
    [self CreateRequest];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


#pragma mark - private methods
-(void)CreateSubViews
{
    m_pHomePageView = [[YYXunHomePageView alloc] initWithFrame:CGRectMake(0, m_pTopBar.bottom, self.view.width, self.view.height-m_pTopBar.bottom - TABBAR_HEIGHT)];
    m_pHomePageView.propDelegate = self;
    [self.view addSubview:m_pHomePageView];
}

-(void)CreateRequest
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Xun/getXun"] andTag:@"xunHomePage"];
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [YYXunData class];
    [m_pRequest GetAsynchronous];
    [self ShowProgressHUDWithMessage:@"Loading..."];
}

#pragma mark - YYXunHomePageView Delegate
-(void)CheckDetail:(YYXunData *)argData
{
    YYRichTextDetailController *pXunDetailVC = [[YYRichTextDetailController alloc] init];
    pXunDetailVC.propContent = argData.content;
    [self PushChildViewController:pXunDetailVC];
}


#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"xunHomePage"])
    {
        [m_pHomePageView SetXunHomePageData:argData];
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
