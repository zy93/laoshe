//
//  LauchViewController.h
//  一起DIY
//
//  Created by 李鑫浩 on 15/7/5.
//  Copyright (c) 2015年 app17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LauchViewController : UIViewController
{
    //滑块视图
    UIScrollView *m_pScrollView;
    //分页控制器
    UIPageControl *m_pPagControl;
    ///跳过按钮
    UIButton *m_pSkipBtn;
    //启动页
    UIImageView *m_pLauchImage;
}

@end
