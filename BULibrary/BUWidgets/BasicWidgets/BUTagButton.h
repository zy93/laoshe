//
//  BUTagButton.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-23.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUTagButton : UIButton
{
    UIImage* m_pBgImage;
}

-(id)initWithFrame:(CGRect)frame;

-(void)SetToLeftState;
-(void)SetToRightState;
@end
