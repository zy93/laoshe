//
//  NSString+Check.m
//  pbuLiaoBaGuaIosClient
//
//  Created by   on 15/10/10.
//  Copyright © 2015年  . All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL)ContentIsEmpty
{
    BOOL pIsEmpty=YES;   ///是否是空格
    NSString *strSpace =@" ";
    NSString *pString = self;
    for(int i =0;i<[pString  length];i++)    {
        NSString *pStr = [self substringWithRange:NSMakeRange(i, 1)];//抽取子字符
        if(![pStr isEqualToString:strSpace])   ///判断是否为空格
        {
            pIsEmpty=NO;           ///如果是则改变 状态
            break;         ///结束循环
        }
    }
    return pIsEmpty;
}

@end
