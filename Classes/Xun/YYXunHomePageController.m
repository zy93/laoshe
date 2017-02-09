//
//  YYXunHomePageController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYXunHomePageController.h"
#import "YYXunHomePageView.h"

@interface YYXunHomePageController ()
{
    YYXunHomePageView *m_pHomePageView;
}
@end

@implementation YYXunHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pNameLabel.text = @"寻";
    [self CreateSubViews];
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pHomePageView = [[YYXunHomePageView alloc] initWithFrame:CGRectMake(0, m_pTopBar.bottom, self.view.width, self.view.height-m_pTopBar.bottom - TABBAR_HEIGHT)];
    [self.view addSubview:m_pHomePageView];
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
