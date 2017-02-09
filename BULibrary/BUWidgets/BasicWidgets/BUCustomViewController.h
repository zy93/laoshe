//
//  BUCustomViewController.h
//  DaoTingTuShuo
//
//  Created by -3 on 14-7-17.
//  Copyright (c) 2014年  MultiMedia Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfigure.h"
#import "BUVerticalAlignLabel.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "AFTabBarViewController.h"
#import "BUAFHttpRequest.h"

typedef void(^BackAction)(id object);

//Controller基类，所有Controller继承自本类
@interface BUCustomViewController : UIViewController<UIAlertViewDelegate,BUAFHttpRequestDelegate>
{
    BUVerticalAlignLabel* m_pNameLabel;        //页面红条上标题
    UIButton* m_pBackButton;                   //返回按钮
    UIView* m_pTopBar;                         //顶条
    UIView *m_pLineView;
    UIAlertView *showErrorAlert;
    UILabel *m_pFlagMsgV;    ///标签信息视图
    
    MBProgressHUD *m_pProgressHUD;    ///数据加载进度标示
}

@property(nonatomic,copy)BackAction propBackAction;

//返回或关闭
-(void)Back;

/**
 *  push到下一级级子控制器
 *
 *  @param pController 子控制器对象
 */
-(void)PushChildViewController:(UIViewController*)pController;

/**
 *  接收到通知后，push到下一级子控制器
 *
 *  @param pController 子控制器对象
 */
-(void)NotifyPushChildViewController:(UIViewController*)pController;

/**
 *  显示数据加载进度标示(有加载指示器)
 *
 * @param argMessage 提示信息
 */
- (void)ShowProgressHUDWithMessage:(NSString *)argMessage;

/**
 *  显示加载结果信息(没有加载指示器)
 *
 *  @param argMessage 提示信息
 */
- (void)ShowHUDWithMessage:(NSString *)argMessage;

/**
 *  隐藏数据加载进度标示
 */
- (void)HideProgressHUD;

@end
