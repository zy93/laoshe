//
//  UIAlertView+Block.m
//  BUVideoManage
//
//  Created by 1bu2bu on 16/8/16.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static const char alertKey;

@implementation UIAlertView (Block)

- (void)showWithBlock:(successBlock)block
{
    if (block)
    {
        objc_setAssociatedObject(self, &alertKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    successBlock block = objc_getAssociatedObject(self, &alertKey);
    block(buttonIndex);
}

@end
