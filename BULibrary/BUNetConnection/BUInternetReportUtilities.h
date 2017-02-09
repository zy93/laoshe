//
//  BUInternetReportUtilities.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUInternetReportUtilities : NSObject

+ (void)ShowInternetError;
+ (void)ShowTip:(NSString*)argTip;
+ (void)ShowErrorMessage:(NSString*)argError;
@end
