//
//  BUPasswordInputWidget.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-3.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUPasswordInputWidget.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BUPasswordInputWidget

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [m_pInputView setSecureTextEntry:YES];
    [self SetKeyboardType:UIKeyboardTypeASCIICapable];
    return self;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString*)GetPassword
{
    NSString* strText = [self md5:m_pInputView.text];
    return strText;

}

@end
