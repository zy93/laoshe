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
#import <UMSocialCore/UMSocialCore.h>
#import "YYShareView.h"

@interface YYOtherDetailViewController ()<YYShareViewDelegate>
{
    YYOtherDetilView *m_pOtherView;
    YYShareView *m_pShareView;
    BUAFHttpRequest *m_pRequest;
    UIButton *m_pShareBtn;

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
    
    m_pShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pShareBtn setFrame:CGRectMake(SCREEN_WIDTH-20-28, 31, 28, 28)];
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon_select"] forState:UIControlStateHighlighted];
    
    [m_pShareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_pShareBtn];
    
    m_pShareView = [[YYShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pShareView.propDelegate = self;
    [self.view addSubview:m_pShareView];
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

//分享
-(void)share:(UIButton *)sender
{
    [m_pShareView ShowView];
}

#pragma mark - YYShareViewDelegate methods
-(void)ClickShareWithType:(NSInteger)argType
{
    UMSocialPlatformType socialPlatformType;
    switch (argType)
    {
        case 0:
            socialPlatformType = UMSocialPlatformType_WechatSession;
            break;
        case 1:
            socialPlatformType = UMSocialPlatformType_WechatTimeLine;
            break;
        case 2:
            socialPlatformType = UMSocialPlatformType_QQ;
            break;
        case 3:
            socialPlatformType = UMSocialPlatformType_Qzone;
            break;
        case 4:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
        default:
            break;
    }
    NSString *pTitle = @"永远的老舍";
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = pTitle;
    
    UMShareWebpageObject *pMessageObject = [UMShareWebpageObject shareObjectWithTitle:pTitle descr:@"永远的老舍" thumImage:[UIImage imageNamed:@"shareIcon-1024.png"]];
    pMessageObject.webpageUrl = [NSString stringWithFormat:@"%@Share/movie_detail&id=%ld",[AppConfigure GetShareUrl],(long)self.mid];
    messageObject.shareObject = pMessageObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSLog(@"%@error",error);
    }];
    
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
