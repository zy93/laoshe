//
//  BUOutsideRecView.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-28.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUOutsideRecView : UIView
{
    CGRect m_innerRect;
}

-(id)initWithFrame:(CGRect)frame andInnerRect:(CGRect)argRect;
-(void)SetInnerRect:(CGRect)argRect;

@end
