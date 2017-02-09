//
//  UIAlertView+Block.h
//  BUVideoManage
//
//  Created by 1bu2bu on 16/8/16.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^successBlock)(NSInteger buttonIndex);

@interface UIAlertView (Block)

- (void)showWithBlock:(successBlock)block;

@end
