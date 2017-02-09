//
//  AFNetStatus.h
//  pbuYaLianWuYeClient
//
//  Created by 1bu2bu on 16/9/9.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

//typedef enum : NSInteger {
//    NotReachable = 0,//没有网络
//    ReachableViaWiFi,//当前使用Wifi网络
//    ReachableViaWWAN//使用的蜂窝网络
//} NetworkStatus;

@interface AFNetStatus : NSObject

+(NetworkStatus)internetStatus;

+ (NSString *)networkingStatesFromStatebar;

@end
