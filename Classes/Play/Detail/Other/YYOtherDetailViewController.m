//
//  YYOtherDetailViewController.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYOtherDetailViewController.h"
#import "YYPLayOtherData.h"
#import "YYOtherDetilView.h"

@interface YYOtherDetailViewController ()
{
    YYOtherDetilView *m_pOtherView;
    BUAFHttpRequest *m_pRequest;

}
@end

@implementation YYOtherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pTopBar.hidden = YES;
    [self createSubview];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSubview
{
    m_pOtherView = [[YYOtherDetilView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:m_pOtherView];
}

-(void)createRequest
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Yan/getMovieDetail"] andTag:@"getOtherDeiail"];
    NSDictionary *dic = @{@"mid":[NSNumber numberWithInteger:self.mid]};
    m_pRequest.propParameters = dic;
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [YYPLayOtherData class];
    [m_pRequest GetAsynchronous];
}

#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"getOtherDeiail"])
    {
        [m_pOtherView setData:argData.firstObject];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
