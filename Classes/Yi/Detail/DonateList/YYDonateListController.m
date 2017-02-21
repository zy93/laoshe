//
//  YYDonateListController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYDonateListController.h"
#import "YYDonateListView.h"
#import "YYDonateData.h"

@interface YYDonateListController ()
{
    YYDonateListView *m_pDonateListView;
    BUAFHttpRequest *m_pRequest;
}
@end

@implementation YYDonateListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pNameLabel.text = @"捐献目录";
    [self CreateSubViews];
    [self createRequest];
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pDonateListView = [[YYDonateListView alloc] initWithFrame:CGRectMake(0, m_pTopBar.bottom, self.view.width, self.view.height - m_pTopBar.bottom)];
    [self.view addSubview:m_pDonateListView];
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
        [m_pDonateListView SetData:argData];
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
