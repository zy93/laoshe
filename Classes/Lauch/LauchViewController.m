//
//  LauchViewController.m
//  一起DIY
//
//  Created by 李鑫浩 on 15/7/5.
//  Copyright (c) 2015年 app17. All rights reserved.
//

#import "LauchViewController.h"
#import "UIDevice+Resolutions.h"
#import "AppDelegate.h"


@interface LauchViewController ()<UIScrollViewDelegate>

@end

@implementation LauchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子视图
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- add subviews method
- (void)initSubviews
{
    m_pSkipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pSkipBtn.frame = CGRectMake((self.view.width - 100 * [AppConfigure GetLengthAdaptRate]) / 2, self.view.height - 90 , 100 * [AppConfigure GetLengthAdaptRate] , 40 * [AppConfigure GetLengthAdaptRate]);
    m_pSkipBtn.backgroundColor = [UIColor whiteColor];
    m_pSkipBtn.layer.cornerRadius = 5;
    m_pSkipBtn.layer.masksToBounds = YES;
    m_pSkipBtn.hidden = YES;
    [m_pSkipBtn setTitle:@"进入" forState:UIControlStateNormal];
    [m_pSkipBtn setTitleColor:[AppConfigure WhiteColor] forState:UIControlStateNormal];
    m_pSkipBtn.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
    [m_pSkipBtn addTarget:self action:@selector(PushIntoMainViewController) forControlEvents:UIControlEventTouchUpInside];
    [self AddLauchView];
    [self.view addSubview:m_pSkipBtn];
}

- (void)AddLauchView
{
    m_pScrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    m_pScrollView.delegate = self;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    m_pScrollView.pagingEnabled = YES;
    m_pScrollView.bounces = NO;
    m_pScrollView.backgroundColor = [AppConfigure WhiteColor];
    
    //向UIScrollView中添加图片
    NSInteger x = 0;
    for (NSInteger index = 0; index < 3; index ++)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, self.view.width,self.view.height)];
        //想imageview中添加图片
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%li.png",(long)index]];
        [m_pScrollView addSubview:imageview];
        x += self.view.width;
    }
    m_pScrollView.contentSize = CGSizeMake(x, self.view.height);
    [self.view addSubview:m_pScrollView];
    
    //设置分页控件
    m_pPagControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.height - 50 , self.view.width, 37)];
    m_pPagControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"launch_unselct"]];
    m_pPagControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"launch_selcted"]];
    m_pPagControl.numberOfPages = 3;
    m_pPagControl.currentPage = 0;
    [self.view addSubview:m_pPagControl];
}

#pragma mark -- 增加启动页的时长
- (void)AddLaunchImagePage
{
    m_pLauchImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina35)
    {
        m_pLauchImage.image = [UIImage imageNamed:@"Default-h480"];
    }
    else if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina4)
    {
        m_pLauchImage.image = [UIImage imageNamed:@"Default-h568"];
    }
    else if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina47)
    {
        m_pLauchImage.image = [UIImage imageNamed:@"Default-h667"];
    }
    else if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina55)
    {
        m_pLauchImage.image = [UIImage imageNamed:@"Default-h736"];
    }
    [self.view addSubview:m_pLauchImage];
}

#pragma mark -- Target method
//- (void)PushIntoMainViewController
//{
//    [mAppDelegate EnterMainPage];
//    [mUserDefaults setObject:@(1) forKey:@"NotFirstLauch"];
//    [mUserDefaults synchronize];
//}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (m_pScrollView.contentOffset.x + self.view.bounds.size.width * 0.5) / self.view.bounds.size.width;
    if (page == 2)
    {
        m_pSkipBtn.hidden = NO;
    }
    else
    {
        m_pSkipBtn.hidden = YES;
    }
    m_pPagControl.currentPage = page;
}

@end
