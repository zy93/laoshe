//
//  YYRichTextDetailController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYRichTextDetailController.h"
#import "YYRichTextDetailView.h"
#import "YYShareView.h"
#import <UMSocialCore/UMSocialCore.h>


@interface YYRichTextDetailController ()<YYShareViewDelegate>
{
    YYRichTextDetailView *m_pRichTextDetailView;
    UIButton *m_pShareBtn; //分享菜单
    YYShareView *m_pShareView;
    UIButton *m_pBackBtn;
}

@end

@implementation YYRichTextDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pTopBar.hidden = YES;
    [self CreateSubViews];
    [self CreateBackButton];
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pRichTextDetailView = [[YYRichTextDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) andContent:self.propContent];
    [self.view addSubview:m_pRichTextDetailView];
}


-(void)CreateBackButton
{
    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pBackBtn.frame = CGRectMake(20, 31, 28, 28);
    [m_pBackBtn setImage:[UIImage imageNamed:@"custom_back_btn"] forState:UIControlStateNormal];
    [m_pBackBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_pBackBtn];
    
    if (self.propActId != nil)
    {
        m_pShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_pShareBtn setFrame:CGRectMake(SCREEN_WIDTH-20-28, 31, 28, 28)];
        [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
        [m_pShareBtn setImage:[UIImage imageNamed:@"share_icon_select"] forState:UIControlStateHighlighted];
        
        [m_pShareBtn addTarget:self action:@selector(ShowShareView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:m_pShareBtn];
    }

    m_pShareView = [[YYShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pShareView.propDelegate = self;
    [self.view addSubview:m_pShareView];
}

-(void)ShowShareView
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
    pMessageObject.webpageUrl = [NSString stringWithFormat:@"%@Share/activity_detail?id=%ld",[AppConfigure GetWebServiceDomain],(long)self.propActId];
    messageObject.shareObject = pMessageObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSLog(@"%@error",error);
    }];
    
}


-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
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
