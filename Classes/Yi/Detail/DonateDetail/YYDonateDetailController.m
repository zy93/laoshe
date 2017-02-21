//
//  YYDonateDetailController.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYDonateDetailController.h"
#import "YYDonateDetailView.h"
#import "YYDonateData.h"


@interface YYDonateDetailController ()
{
    YYDonateDetailView *m_pDonateDetailView;
    BUAFHttpRequest *m_pRequest;
}
@end

@implementation YYDonateDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSubview
{
    m_pDonateDetailView = [[YYDonateDetailView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:m_pDonateDetailView];
}

-(void)createRequest
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Friends/getDonateList"] andTag:@"donate"];
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [YYDonateData class];
    [m_pRequest GetAsynchronous];
}

#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"donate"])
    {
//        [m_pDonateDetailView SetFriendData:argData];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
