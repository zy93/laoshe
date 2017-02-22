//
//  ViewController.m
//  bookMore
//
//  Created by 张雨 on 2017/2/21.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "YYListenBookViewController.h"
#import "YYListenBookView.h"
#import "AudioPlayViewController.h"

@interface YYListenBookViewController ()// <UICollectionViewDelegate,UICollectionViewDataSource,CardLayoutDelegate>
{
    UIButton *m_pBackBtn;
    UIButton *m_pShareBtn;
    YYListenBookView *m_pListenBookView;
}

@end

@implementation YYListenBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubview];
    [self createBackButton];
    [self createShareButton];
}


-(void)createSubview
{
    m_pListenBookView = [[YYListenBookView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:m_pListenBookView];
    
    [m_pListenBookView setData:self.m_pDataArr];
}

-(void)createBackButton
{
    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pBackBtn.frame = CGRectMake(20, 31, 28, 28);
    [m_pBackBtn setImage:[UIImage imageNamed:@"custom_back_btn"] forState:UIControlStateNormal];
    [m_pBackBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
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



-(void)ClickCheckBookWithId:(NSString *)mId
{
    AudioPlayViewController *pTingShuDetailVC = [[AudioPlayViewController alloc] init];
    pTingShuDetailVC.mid = [mId integerValue];
    pTingShuDetailVC.cid = 0;
    [self PushChildViewController:pTingShuDetailVC];
}

#pragma mark - action
-(void)share:(UIButton *)sender
{
    
}

@end
