//
//  AppConfigure.m
//  pbuWorldMysteryLite
//
//  Created by Yan Xue on 12-2-13.
//  Copyright (c) 2012年 ShootingChance. All rights reserved.
//

#import "AppConfigure.h"
#import "BCLabel.h"
#import "UIColor+CurrentColor.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSString+MD5.h"

@implementation AppConfigure

+(BOOL)IsProductionServer
{
    return NO;
}

+ (NSString*)GetWebServiceDomain
{
//    if (DEBUG)
        return @"http://123.56.226.177/index.php?s=/Api/";    //测试服务器
//    else
//        return @"http://api.shijianqiyue.com/index.php?s=/API/";     //正式服务器
}


+ (NSString*)GetFileDomain
{
//    if (!DEBUG)
//        return @"http://api.shijianqiyue.com/index.php?s=/API/";     //正式服务器
//    else
        return @"http://sjqy.1bu2bu.com/index.php?s=/Api/";    //测试服务器
}

+(NSString *)GetShareUrl
{
    return @"http://123.56.226.177/index.php?s=/Home/";
}
+ (NSString*)RegularFont
{

    return @"Arial";
    //@"Heiti SC";
    //;//@"Helvetica";////@"FZLTXHK";
    //return @"FZLTHJW_ZJRB--GB1-0";
}

+ (NSString*)LightFont
{
    return @"Arial";//@"FZLTXHK";
}

+ (NSString*)BoldFont
{
    return  @"Arial-BoldMT"; // @"Heiti SC";
    //;//@"Helvetica-Bold";////@"FZLTXHK";
    //return @"FZLTCHK_ZJRB--GBK1-0";
}

#pragma mark -  色卡颜色
+ (UIColor*) WhiteColor
{
    return UIColorFromHex(0x9997a5);
}

+ (UIColor*) BlackColor
{
    return UIColorFromHex(0x000000);
}

+ (UIColor*) TitleLightColor
{
    return [UIColor CurrentColor:@"c3c3ca"];
}

+ (UIColor*) TitleGrayColor
{
    return [UIColor CurrentColor:@"999999"];
}

+(UIColor*)OrangeTextColor
{
    return [UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:3.0/255.0 alpha:1];
}

+ (UIColor*) GrayColor
{
    return [UIColor CurrentColor:@"f4f4f4"];
}

+ (UIColor *)OrangeColor
{
    return [UIColor CurrentColor:@"ff6633"];
}

+ (UIColor *)DarkGrayColor
{
    return [UIColor CurrentColor:@"858585"];
}

#pragma mark -- 返回当前设备版本号
+ (double)iOSVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+(double) GetYStartPos
{
    if ([AppConfigure iOSVersion] >= 7.0) {
        return 20;
    }
    else
        return 0;
}

+(CGSize)GetTextSize:(NSString*)artText WithLabelWidth:(int)argWidth
{
    
    BCLabel *gettingSizeLabel = [[BCLabel alloc] initWithFrame:CGRectMake(0, 0, argWidth, 80)];
    [gettingSizeLabel setText:artText withLineHeight:36 fontSize:26 fontName:[AppConfigure LightFont] fontColor:[UIColor blackColor] alignment:NSTextAlignmentJustified];
    gettingSizeLabel.numberOfLines = 0;

    CGSize maximumLabelSize = CGSizeMake(argWidth, 80);
    NSLog(@"gettingSizeLabel.numberOfLines = %d",(int)gettingSizeLabel.numberOfLines);

    CGSize expectedSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    
    return expectedSize;
}


+(UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

#pragma mark - screen adaption

+(CGFloat) GetScreenHeight
{
    //return 568;
    //return 666;
    //return 736;
    /*if ([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
     return 480;
     else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4)
     {
     return 568;
     }
     else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
     {
     return 667;
     }
     else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
     {
     return 736;
     }
     else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina)
     {
     return 1024;
     }
     else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
     {
     return 1024;
     }
     return 480;*/
    
    return [UIScreen mainScreen].bounds.size.height;
    
}

+(CGFloat) GetScreenWidth
{
    //    if ([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    //        return 320;
    //    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4)
    //    {
    //        return 320;
    //    }
    //    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
    //    {
    //        return 375;
    //    }
    //    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
    //    {
    //        return 414;
    //    }
    //    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina)
    //    {
    //        return 768;
    //    }
    //    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    //    {
    //        return 768;
    //    }
    //
    //    else
    //        return 320;
    //return 375;
    //return 414;
    return [UIScreen mainScreen].bounds.size.width;
}

+(CGFloat) GetImageRate
{
    //CGFloat height = [AppConfigure GetScreenHeight];
    
    //CGFloat rate = ([AppConfigure GetScreenHeight]/320);
    CGFloat rate = 1;
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4 ||
       [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    {
        rate = 641/750.0;
    }
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
    {
        rate = 1;
        
        //rate = 0.91;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
    {
        rate = 1;
        //rate = 1.18;
    }
    /*else if(([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4||[[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35) && [BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.0] && (![BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.1]))
     {
     //rate = 375.0/414.0;
     rate = 320.0/414.0;
     rate = 1;
     }*/
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina )
    {
        return 768.0/320.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    {
        return 768.0/320.0;
    }
    return rate;
}

+(CGSize) GetAdaptedImageSize:(UIImage*)argImage
{
    return CGSizeMake(round(argImage.size.width*[AppConfigure GetImageRate]),
                      round(argImage.size.height*[AppConfigure GetImageRate]));
}

+(CGFloat) GetLengthAdaptRate;
{
    CGFloat rate = 1;
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4 ||
       [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    {
        rate = 320/375.0;
    }
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
    {
        rate = 1;
        
        //rate = 0.91;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
    {
        rate = 414/375.0;
        //rate = 1.18;
    }
    /*else if(([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4||[[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35) && [BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.0] && (![BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.1]))
     {
     //rate = 375.0/414.0;
     rate = 320.0/414.0;
     rate = 1;
     }*/
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina )
    {
        return 768.0/320.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    {
        return 768.0/320.0;
    }
    return rate;
}

#pragma mark -- 压缩图片
+ (NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

#pragma mark -- 获取子视图所在的控制器
+ (UIViewController *)GetViewControllerForCurrentView:(UIView *)argView
{
    UIResponder *next = [argView nextResponder];
    while (next != Nil)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

#pragma mark -- 加载图片
+ (void)LoadImageWithImageView:(UIImageView *)argImageView ImageViewUrl:(NSString *)argUrl PlaceHoldImage:(UIImage *)argPlaceHoldImage
{
    argImageView.image = argPlaceHoldImage;
    NSString *pCacheDataFile = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"CacheData"];
    NSString *pFilePath = [pCacheDataFile stringByAppendingPathComponent:[argUrl md5]];
    NSFileManager *pFM = [NSFileManager defaultManager];
    if (![pFM fileExistsAtPath:pCacheDataFile])
    {
        [pFM createDirectoryAtPath:pCacheDataFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([pFM fileExistsAtPath:pFilePath])
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pFilePath]];
        if (data != nil && data.length > 0)
        {
            argImageView.image = [UIImage imageWithData:data];
        }
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:argUrl]];
            [data writeToFile:pFilePath atomically:YES];
            if (data != nil && data.length > 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    argImageView.image = [UIImage imageWithData:data];
                });
            }
        });
    }
}

+ (UIImage *)CacheImageWithUrl:(NSString *)argUrl
{
    NSString *pCacheDataFile = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"CacheData"];
    NSString *pFilePath = [pCacheDataFile stringByAppendingPathComponent:[argUrl md5]];
    NSFileManager *pFM = [NSFileManager defaultManager];
    if (![pFM fileExistsAtPath:pCacheDataFile])
    {
        [pFM createDirectoryAtPath:pCacheDataFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([pFM fileExistsAtPath:pFilePath])
    {
        NSData *pData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pFilePath]];
        if (pData != nil)
        {
            return [UIImage imageWithData:pData];
        }
    }
    else
    {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:argUrl]];
        [data writeToFile:pFilePath atomically:YES];
        if (data != nil)
        {
             return [UIImage imageWithData:data];
        }
    }
    return nil;
}

@end
