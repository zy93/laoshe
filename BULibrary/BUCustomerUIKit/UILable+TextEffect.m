//
//  UILable+TextEffect.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-24.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "UILable+TextEffect.h"

@implementation UILabel (TextEffect)

-(void)AddTextUnderscore
{
    NSString* strText = self.text;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:strText];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.attributedText = content;
}
@end
