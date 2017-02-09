//
//  UIImage+JP.m
//  7.8 -- 截屏
//
//  Created by 李鑫浩 on 15/7/8.
//  Copyright (c) 2015年 app17. All rights reserved.
//

#import "UIImage+JP.h"

@implementation UIImage (JP)
+ (instancetype)captureWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
