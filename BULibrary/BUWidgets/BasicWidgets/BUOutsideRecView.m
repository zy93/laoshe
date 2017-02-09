//
//  BUOutsideRecView.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-28.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUOutsideRecView.h"

@implementation BUOutsideRecView

-(id)initWithFrame:(CGRect)frame andInnerRect:(CGRect)argRect
{
    self = [super initWithFrame:frame];
    m_innerRect = argRect;
    self.userInteractionEnabled = NO;
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)SetInnerRect:(CGRect)argRect
{
    m_innerRect = argRect;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [[UIColor colorWithWhite:0 alpha:0.4] setFill];
    UIRectFill(self.bounds);
    
    CGRect gapRectIntersection = CGRectIntersection(self.bounds, m_innerRect);
    [[UIColor clearColor] setFill];
    UIRectFill(gapRectIntersection);
}

@end
