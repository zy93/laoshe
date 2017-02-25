//
//  BUCustomViewController.m
//  DaoTingTuShuo
//
//  Created by -3 on 14-7-17.
//  Copyright (c) 2014年  MultiMedia Lab. All rights reserved.
//

#import "BUCustomViewController.h"
#import "BUVerticalAlignLabel.h"
#import "BUCoreUtility.h"
#import "BUSystemVersion.h"

// This category (i.e. class extension) is a workaround to get the
// Image PickerController to appear in landscape mode.
@interface UIImagePickerController(Nonrotating)
- (BOOL)shouldAutorotate;
@end

@implementation UIImagePickerController(Nonrotating)

- (BOOL)shouldAutorotate
{
    return NO;
}
@end


@interface BUCustomViewController ()
{
    BOOL m_bIsMainPageViewController;    ///是否是分栏项主页面控制器
}

@end

@implementation BUCustomViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        m_bIsMainPageViewController = NO;
    }
    return self;
}
-(void)dealloc
{
    [self HideProgressHUD];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     NSLog(@"释放");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    if([AppConfigure iOSVersion]>=7.0)
        self.automaticallyAdjustsScrollViewInsets = NO;
    m_pTopBar =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44+[AppConfigure GetYStartPos])];
    m_pTopBar.backgroundColor = UIColorFromHex(0xffffff);
    [self.view addSubview:m_pTopBar];
    
    //Name Lable
    m_pNameLabel = [[BUVerticalAlignLabel alloc] initWithFrame:CGRectMake(65,0+[AppConfigure GetYStartPos], self.view.bounds.size.width-130, 45)];
    m_pNameLabel.backgroundColor = [UIColor clearColor];
    m_pNameLabel.textAlignment = NSTextAlignmentCenter;
    m_pNameLabel.verticalAlignment = VerticalAlignmentMiddle;
    m_pNameLabel.textColor = UIColorFromHex(0x455cc7);
    [m_pNameLabel setFont:[UIFont fontWithName:[AppConfigure RegularFont] size:19]];
    [m_pTopBar addSubview:m_pNameLabel];
    
   //Back button
    m_pBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0+[AppConfigure GetYStartPos],55, 44)];
    [m_pBackButton setExclusiveTouch:YES];
//    [m_pBackButton setTitle:@"返回" forState:UIControlStateNormal];
    [m_pBackButton setTitleColor:[AppConfigure WhiteColor] forState:UIControlStateNormal];
    m_pBackButton.titleLabel.font = [UIFont fontWithName:[AppConfigure LightFont] size:15];
    [m_pBackButton setImage:[BUCoreUtility newImageFromResource:@"back.png"] forState:UIControlStateNormal];
    [m_pBackButton setImage:[BUCoreUtility newImageFromResource:@"back_select.png"] forState:UIControlStateHighlighted];
    [m_pBackButton addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [m_pTopBar addSubview:m_pBackButton];
    
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pTopBar.frame) - 1, self.view.frame.size.width, 1)];
    m_pLineView.backgroundColor = UIColorFromHex(0xcccccc);
    [m_pTopBar addSubview:m_pLineView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
//    [[[UIApplication sharedApplication] keyWindow] endEditing:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (m_bIsMainPageViewController)
    {
        m_bIsMainPageViewController = NO;
        [(AFTabBarViewController *)self.tabBarController ShowTabBar];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- target method

-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.propBackAction) {
        self.propBackAction(nil);
    }
}

#pragma mark -- public method
-(void)PushChildViewController:(UIViewController*)pController
{
    m_bIsMainPageViewController = self.navigationController.viewControllers.count == 1;
    [(AFTabBarViewController *)self.tabBarController HideTabBar];
    [self.navigationController pushViewController:pController animated:YES];
}

-(void)NotifyPushChildViewController:(UIViewController*)pController
{
    m_bIsMainPageViewController = self.navigationController.viewControllers.count == 1;
    [(AFTabBarViewController *)self.tabBarController HideTabBar];
    [self.navigationController pushViewController:pController animated:NO];
}

- (void)ShowProgressHUDWithMessage:(NSString *)argMessage
{
    if (m_pProgressHUD != nil)
    {
        [self HideProgressHUD];
    }
    m_pProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    m_pProgressHUD.detailsLabelText = argMessage;
    m_pProgressHUD.removeFromSuperViewOnHide = YES;
    m_pProgressHUD.userInteractionEnabled = NO;
}

- (void)ShowHUDWithMessage:(NSString *)argMessage
{
    if (m_pProgressHUD != nil)
    {
        [self HideProgressHUD];
    }
    m_pProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    m_pProgressHUD.mode = MBProgressHUDModeText;
    m_pProgressHUD.detailsLabelFont = [UIFont boldSystemFontOfSize:14];
    m_pProgressHUD.detailsLabelText = argMessage;
    m_pProgressHUD.removeFromSuperViewOnHide = YES;
    m_pProgressHUD.userInteractionEnabled = NO;
    [m_pProgressHUD hide:YES afterDelay:2];
}

- (void)HideProgressHUD
{
    [m_pProgressHUD hide:YES];
    [m_pProgressHUD removeFromSuperview];
    m_pProgressHUD = nil;
}

@end
