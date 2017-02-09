//
//  BCLabel.h
//  pbuBici
//
//  Created by Ruixin on 13-12-19.
//  Copyright (c) 2013年 YANGYANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUVerticalAlignLabel.h"

@interface BCLabel : BUVerticalAlignLabel
{
    NSMutableParagraphStyle * m_paragraphStyle;
}

/*@property (assign) double lineHeight;
@property (assign) double fontSize;
@property (retain) NSString* fontName;*/


-(void) setText:(NSString *)argText
 withLineHeight:(double)argLineHeight
       fontSize:(double) argFontSize
       fontName:(NSString*) argFontName
      fontColor:(UIColor*)argColor
      alignment:(NSTextAlignment) argTextAlignment;



@end
