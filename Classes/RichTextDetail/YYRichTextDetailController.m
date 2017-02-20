//
//  YYRichTextDetailController.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYRichTextDetailController.h"
#import "YYRichTextDetailView.h"

@interface YYRichTextDetailController ()
{
    YYRichTextDetailView *m_pRichTextDetailView;
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
