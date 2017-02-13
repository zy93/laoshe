//
//  YYYiFriendDetailController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/13.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiFriendDetailController.h"
#import "YYShareView.h"

@interface YYYiFriendDetailController ()
{
    YYShareView *m_pShareView;
}
@end

@implementation YYYiFriendDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_pShareView = [[YYShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pShareView];
    [self CreateNavItem];
}
-(void)CreateNavItem
{
    UIImage *pImg = [UIImage imageNamed:@"share_icon.png"];
    UIButton *pShreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pImg.size.width , pImg.size.height)];
    pShreBtn.center = CGPointMake(m_pTopBar.width - 15*[AppConfigure GetLengthAdaptRate] - pShreBtn.width/2, m_pNameLabel.center.y);
    [pShreBtn setBackgroundImage:pImg forState:UIControlStateNormal];
    [pShreBtn setBackgroundImage:[UIImage imageNamed:@"share_icon_select.png"] forState:UIControlStateHighlighted];
    [m_pTopBar addSubview:pShreBtn];
    [pShreBtn addTarget:self action:@selector(ShowShareView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)ShowShareView
{
    [m_pShareView ShowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
