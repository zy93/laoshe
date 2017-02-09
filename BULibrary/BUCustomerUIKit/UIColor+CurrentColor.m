//
//  UIColor+CurrentColor.m
//  pbuLiaoBaGuaIosClient
//
//  Created by   on 15/9/10.
//  Copyright (c) 2015年  . All rights reserved.
//

#import "UIColor+CurrentColor.h"

@implementation UIColor (CurrentColor)

+ (instancetype)CurrentColor:(NSString *)argScale
{
    NSInteger pRed = strtoul([[argScale substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    NSInteger pGreen = strtoul([[argScale substringWithRange:NSMakeRange(2, 2)] UTF8String],0,16);
    NSInteger pBlue = strtoul([[argScale substringWithRange:NSMakeRange(4, 2)] UTF8String],0,16);
    
    
    UIColor *pCurrentColor = [UIColor colorWithRed: pRed / 255.0 green:pGreen / 255.0 blue:pBlue / 255.0 alpha:1.0];
    return pCurrentColor;
}

@end
