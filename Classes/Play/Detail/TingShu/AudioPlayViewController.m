//
//  AudioPlayViewController.m
//  AudioPlay
//
//  Created by 张雨 on 2017/2/3.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "AudioPlayViewController.h"
#import "AppConfigure.h"

#import "ZYListenBookData.h"
#import "ZYAudioPlayView.h"
#import "YYShareView.h"
#import <UMSocialCore/UMSocialCore.h>





@interface AudioPlayViewController ()<YYShareViewDelegate>
{
    UIButton *m_pBackBtn;
    UIButton *m_pShareBtn; //分享菜单
    ZYAudioPlayView *m_pPlayView;
    YYShareView *m_pShareView;
    BUAFHttpRequest *m_pRequest;
}

//@property (nonatomic, strong) UIProgressView *m_progress;//缓冲进度条.



@end

@implementation AudioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createSubView];
    [self createRequest];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //进入页面后自动播放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSubView
{
    //
    m_pPlayView = [[ZYAudioPlayView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:m_pPlayView];
    
    m_pShareView = [[YYShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pShareView.propDelegate = self;
    [self.view addSubview:m_pShareView];
    
    [self createBackButton];
    [self createShareButton];
}

-(void)createBackButton
{
    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pBackBtn.frame = CGRectMake(20, 31, 28, 28);
    [m_pBackBtn setImage:[UIImage imageNamed:@"custom_back_btn"] forState:UIControlStateNormal];
    [m_pBackBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_pBackBtn];
}

-(void)createShareButton
{
    m_pShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pShareBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 28 - 20, 31, 28, 28);
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon_select"] forState:UIControlStateHighlighted];

    [m_pShareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_pShareBtn];
}

-(void)createRequest
{
    m_pRequest = [[BUAFHttpRequest alloc] initWithUrl:[NSString stringWithFormat:@"Yan/getTingBookDetail"] andTag:@"getTingBook"];
    NSDictionary *dic = @{@"mid":[NSNumber numberWithInteger:self.mid],
                          @"cid":[NSNumber numberWithInteger:self.cid]};
    m_pRequest.propParameters = dic;
    m_pRequest.propDelegate = self;
    m_pRequest.propDataClass = [ZYListenBookData class];
    [m_pRequest GetAsynchronous];
}

#pragma mark - 
-(void)back:(UIButton *)sender
{
    [self Back];
    [m_pPlayView clearPlay];
}

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
    pMessageObject.webpageUrl = [NSString stringWithFormat:@"%@Share/ting_detail&id=%ld",[AppConfigure GetShareUrl],(long)self.mid];
    messageObject.shareObject = pMessageObject;

    [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSLog(@"%@error",error);
    }];

}
#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"getTingBook"])
    {
        [m_pPlayView SetBookData:argData];
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
