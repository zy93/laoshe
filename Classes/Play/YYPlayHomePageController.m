
//
//  YYPlayHomePageController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYPlayHomePageController.h"
#import "YYPlayHomePageView.h"
#import "AudioPlayViewController.h"
#import "YYActivityViewController.h"
#import "YYOtherDetailViewController.h"
#import "YYPlayData.h"
#import "YYRichTextDetailController.h"
#import "YYListenBookViewController.h"
#import "YYActivityData.h"
#import "YYBannerData.h"

@interface YYPlayHomePageController ()<YYPlayHomePageViewDelegate>
{
    YYPlayHomePageView *m_pHomePageView;
    BUAFHttpRequest *m_pRequest;
    BUAFHttpRequest *m_pBannerRequest;
}

@end

@implementation YYPlayHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pNameLabel.text = @"演";
    m_pTopBar.hidden = YES;
    [self CreateSubViews];
    [self CreateRequest];
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pHomePageView = [[YYPlayHomePageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - TABBAR_HEIGHT)];
    m_pHomePageView.propDelegate = self;
    [self.view addSubview:m_pHomePageView];
}

-(void)CreateRequest
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Yan/getYan"] andTag:@"getYan"];
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [YYPlayData class];
    [m_pRequest GetAsynchronous];
    
    m_pBannerRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Banner/getBanner"] andTag:@"getBanner"];
    m_pBannerRequest.propDelegate = self;
    m_pBannerRequest.propDataClass = [YYBannerData class];
    [m_pBannerRequest GetAsynchronous];
}
#pragma mark - public methods
-(void)ClickCheckDetailsWithId:(NSInteger)argId argType:(NSInteger)argType
{
    
    NSLog(@"----------");
    
    switch (argType) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        {
            YYOtherDetailViewController *pDetailVC = [[YYOtherDetailViewController alloc] init];
            pDetailVC.mid = argId;
            [self PushChildViewController:pDetailVC];
        }
            break;
        case 5:
        {
            AudioPlayViewController *pTingShuDetailVC = [[AudioPlayViewController alloc] init];
            pTingShuDetailVC.mid = argId;
            pTingShuDetailVC.cid = 0;
            [self PushChildViewController:pTingShuDetailVC];
        }
            break;
        case 6:
        {
            YYActivityViewController *pActivityDetailVC = [[YYActivityViewController alloc] init];
            pActivityDetailVC.m_pActivityList = [m_pHomePageView GetAccivity];
            [self PushChildViewController:pActivityDetailVC];
        }
            break;
            
            
        default:
            break;
    }
    
    
}

#pragma mark - YYPlayHomePageViewDelegate methods
-(void)CheckDetail:(YYActivityData *)argData
{
    YYRichTextDetailController *pActDetailVC = [[YYRichTextDetailController alloc] init];
    pActDetailVC.propContent = argData.content;
    pActDetailVC.propActId = argData.mid;
    [self PushChildViewController:pActDetailVC];
}

-(void)ClickListenBookMore:(NSArray *)argData
{
    YYListenBookViewController *pActivityDetailVC = [[YYListenBookViewController alloc] init];
    pActivityDetailVC.m_pDataArr = argData;
    [self PushChildViewController:pActivityDetailVC];
}

#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"getYan"])
    {
        [m_pHomePageView SetPlayData:argData];
    }
    if ([argRequestTag isEqualToString:@"getBanner"])
    {
        [m_pHomePageView SetBannerData:argData];
    }
    if (m_pRequest.proRequestRunning == NO && m_pBannerRequest.proRequestRunning == NO)
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
