//
//  AppDelegate.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/22.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "AppDelegate.h"
#import "AFTabBarViewController.h"
#import "LauchViewController.h"
#import "YYYiHomePageController.h"
#import "YYYanHomePageController.h"
#import "YYPlayHomePageController.h"
#import "YYXunHomePageController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ////lllllllLTTTTT
    // Override point for customization after application launch.
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58a69455bbea830de0001b2f"];
    
    [self ConfigUSharePlatforms];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self EnterLauchPage];
    return YES;
}

#pragma mark - private methods

-(void)ConfigUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxea16a6da91f9aaa8" appSecret:@"cd290e671987b2cb918a4c1ecac6acc0" redirectURL:@"http://mobile.umeng.com/social"];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105989160"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2287708255"  appSecret:@"1f320e822e4c1f3ee9e7988ab634276d" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (void)EnterLauchPage
{
//    BOOL bNotFirstLauch = [[mUserDefaults valueForKeyPath:@"NotFirstLauch"] boolValue];
//    if (!bNotFirstLauch)
//    {
//        LauchViewController *pLauchVC = [[LauchViewController alloc]init];
//        self.window.rootViewController = pLauchVC;
//    }
//    else
//    {
        [self EnterMainPage];
//    }
}

- (void)EnterMainPage
{
    AFTabBarViewController *pMainVC = [[AFTabBarViewController alloc]init];
    pMainVC.propViewControllerClasses = @[[YYYiHomePageController class],[YYYanHomePageController class],[YYPlayHomePageController class],[YYXunHomePageController class]];
    pMainVC.propTabBarNormalImages = @[@"tabbar_yi",@"tabbar_yan",@"tabbar_play",@"tabbar_xun"];
    pMainVC.propTabBarSelectedImages = @[@"tabbar_yi_select",@"tabbar_yan_select",@"tabbar_play_select",@"tabbar_xun_select"];
    pMainVC.propTabBarTitles = @[@"忆",@"研",@"演",@"寻"];
    self.window.rootViewController = pMainVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
