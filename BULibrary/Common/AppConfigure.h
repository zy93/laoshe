//
//  AppConfigure.h
//  pbuWorldMysteryLite
//
//  Created by Yan Xue on 12-2-13.
//  Copyright (c) 2012年 ShootingChance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewExt.h"


#pragma mark - UIColor defines
#define UIColorFromHexWithAlpha(hexValue,a)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF)) /255.0 \
alpha:a]

#define UIColorFromHex(hexValue)         UIColorFromHexWithAlpha(hexValue,1.0)

#pragma mark - NSString
#define IS_NULL(x)                  (!x || [x isKindOfClass:[NSNull class]])
#define IS_EMPTY_STRING(x)          (IS_NULL(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define AFWeak         __weak __typeof(self) weakSelf = self

#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif
//----------方法简写
#define mAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define TABBAR_HEIGHT 49.0
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//判断字符串是否为空
#define strIsEmpty(str) (str == nil || [str length]<1 ? YES : NO )

#define SIZE_HEIGHT(i)  [@"占位符" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:i]} context:nil].size.height

#define SAVE_TEST_QUSTION_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test_question.sqlist"]



//#define kECAppId @"8aaf070857dc0e780157f4cc4e121484"
//#define kECAppToken @"9d71ce4d223676d64c565a18e7e65635"

//#define kECAppId @"8a216da85741a1b9015746e582fe0455"
//#define kECAppToken @"e0a1358cabd0d8a43e1ce057d6fdf68b"

#define kECAppId @"8aaf070858cd982e0158e26197040d54"
#define kECAppToken @"81d9281a70268f6439c803588f34f01a"

#define kLoginSucceedNotifity @"LoginSucceedNotifity"                ///登陆成功通知
#define kReleaseSucceedNotifity @"ReleaseSucceedNotifity"         ///活动发布成功通知
#define kItemRefreshNotifity @"ItemRefreshNotifity"                        ///分栏项刷新通知
#define kNotifyEnterForeground @"EnterForeground"                      ///进入到前台通知
#define kAccountData @"AccountData"                                            ///用户账号信息

#define kAlipayUrlScheme @"QiYueAlipayUrlScheme"                      ///支付宝支付回调链接
#define kBaiDuMapUrlScheme @"baidumapsdk://mapsdk.baidu.com"                      ///支付宝支付回调链接

@interface AppConfigure : NSObject

+ (NSString*)GetWebServiceDomain;

+ (NSString*)GetFileDomain;

+(NSString *)GetShareUrl;

+ (NSString*)RegularFont;

+ (NSString*)LightFont;

+ (NSString*)BoldFont;

+ (double)iOSVersion;

+(double) GetYStartPos;

#pragma mark - 色卡颜色
+ (UIColor*) WhiteColor;
+ (UIColor*) TitleLightColor;
+ (UIColor*) TitleGrayColor;
+ (UIColor*) BlackColor;
+(UIColor*)OrangeTextColor;
+ (UIColor*) GrayColor;
+ (UIColor *)OrangeColor;
+ (UIColor *)DarkGrayColor;

#pragma mark - screen adaption
+(CGFloat) GetScreenWidth;
+(CGFloat) GetScreenHeight;
+(CGFloat) GetImageRate;
+(CGSize) GetAdaptedImageSize:(UIImage*)argImage;
+(CGFloat) GetLengthAdaptRate;

#pragma mark -- 图片压缩方法
+ (NSData *)imageData:(UIImage *)myimage;

#pragma mark -- 获取子视图所在的控制器
+ (UIViewController *)GetViewControllerForCurrentView:(UIView *)argView;

#pragma mark -- 加载图片
+ (void)LoadImageWithImageView:(UIImageView *)argImageView ImageViewUrl:(NSString *)argUrl PlaceHoldImage:(UIImage *)argPlaceHoldImage;

+ (UIImage *)CacheImageWithUrl:(NSString *)argUrl;

@end
