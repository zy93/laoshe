//
//  BUTagButton.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-23.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUTagButton.h"


@implementation BUTagButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    m_pBgImage = [UIImage imageNamed:@"tagbgright.png"];
    m_pBgImage = [m_pBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(8, 10, 8, 10) resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:m_pBgImage forState:UIControlStateNormal];
    
    [self setTitleColor:[AppConfigure WhiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:13];
    
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize size = [self sizeThatFits:CGSizeMake(200, 22)];
    CGSize newSize = CGSizeMake(size.width + 25, 22);
    self.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
}


-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    CGSize size = [self sizeThatFits:CGSizeMake(200, 22)];
    CGSize newSize = CGSizeMake(size.width + 25, 22);
    self.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
}

-(void)SetToLeftState
{
    m_pBgImage = [UIImage imageNamed:@"tagbgright.png"];
    m_pBgImage = [m_pBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(8, 10, 8, 10) resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:m_pBgImage forState:UIControlStateNormal];
}

-(void)SetToRightState
{
    m_pBgImage = [UIImage imageNamed:@"tagbgleft.png"];
    m_pBgImage = [m_pBgImage resizableImageWithCapInsets:UIEdgeInsetsMake(8, 10, 8, 10) resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:m_pBgImage forState:UIControlStateNormal];
}

@end
