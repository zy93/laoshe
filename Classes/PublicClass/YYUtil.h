//
//  YYUtil.h
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <Foundation/Foundation.h>





#define black_33 0x333333
#define black_66 0x666666

#define blue_45 0x455cc7  //左侧
#define white_f2 0xff44ff //背景
#define white_ff 0xffffff //缓冲

//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]





@interface YYUtil : NSObject

/**
 时间戳转时间

 @param timeString 时间戳
 @return 时间
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
@end
