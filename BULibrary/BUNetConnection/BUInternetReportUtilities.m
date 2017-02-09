//
//  BUInternetReportUtilities.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "MBProgressHUD.h"
#import "BUInternetReportUtilities.h"

@implementation BUInternetReportUtilities

+ (void)ShowInternetError
{
    MBProgressHUD* pHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    pHUD.mode = MBProgressHUDModeCustomView;
    pHUD.labelText = @"网络连接失败";
    
    [pHUD hide:YES afterDelay:2.0];
}

+ (void)ShowTip:(NSString*)argTip
{
    MBProgressHUD* pHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    pHUD.mode = MBProgressHUDModeCustomView;
    pHUD.labelText = argTip;
    [pHUD hide:YES afterDelay:2.0];
}

+ (void)ShowErrorMessage:(NSString*)argError
{
    UIAlertView* pAlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                             message:argError delegate:nil
                                                                             cancelButtonTitle:@"知道了"
                                                                             otherButtonTitles:nil, nil];
    [pAlertView show];
}


@end
