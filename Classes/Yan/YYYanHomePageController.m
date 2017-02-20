//
//  YYYanHomePageController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanHomePageController.h"
#import "YYYanHomePageView.h"
#import "YYYanData.h"
#import "NSString+IntValue.h"

@interface YYYanHomePageController ()
{
    YYYanHomePageView *m_pHomePageView;
    BUAFHttpRequest *m_pRequest;
}
@end

@implementation YYYanHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pNameLabel.text = @"研";
    m_pTopBar.hidden = YES;
    [self CreateSubViews];
    [self CreateRequest:1];
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pHomePageView = [[YYYanHomePageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - TABBAR_HEIGHT)];
    [self.view addSubview:m_pHomePageView];
}
-(void)CreateRequest:(NSInteger)argType
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Yan/getContentbyType"] andTag:@"getContentbyType"];
    [m_pRequest SetParamValue:[NSString IntergerString:argType] forKey:@"type"];
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [YYYanData class];
    [m_pRequest GetAsynchronous];
}

#pragma mark - public methods
-(void)RequestWithType:(NSInteger)argType
{
    [m_pRequest SetParamValue:[NSString IntergerString:argType] forKey:@"type"];
    [m_pRequest GetAsynchronous];
}

#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"getContentbyType"])
    {
        [m_pHomePageView SetYanData:argData];
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
