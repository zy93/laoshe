//
//  BCLabel.m
//  pbuBici
//
//  Created by Ruixin on 13-12-19.
//  Copyright (c) 2013年 YANGYANG. All rights reserved.
//

#import "BCLabel.h"

@implementation BCLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void) dealloc
{
    m_paragraphStyle = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) setText:(NSString *)argText
 withLineHeight:(double)argLineHeight
       fontSize:(double) argFontSize
       fontName:(NSString*) argFontName
      fontColor:(UIColor*)argColor
    alignment:(NSTextAlignment)argTextAlignment
{
    if (argText==nil)
    {
        return;
    }
    
    if (m_paragraphStyle!=nil)
    {
        m_paragraphStyle=nil;
    }
    m_paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [m_paragraphStyle setLineSpacing:(argLineHeight-argFontSize)/2];
    [m_paragraphStyle setAlignment:argTextAlignment];
    NSMutableAttributedString *attrIntroString = [[NSMutableAttributedString alloc] initWithString: argText];
    [attrIntroString addAttribute:NSParagraphStyleAttributeName value:m_paragraphStyle
                             range:NSMakeRange(0, [argText length])];
    self.textColor = argColor;
    self.font = [UIFont fontWithName:argFontName size:argFontSize/2];
    self.attributedText = attrIntroString;
}

-(void) setText:(NSString *)argText
{
    if(m_paragraphStyle != NULL)
    {
        
        NSMutableAttributedString *attrIntroString = [[NSMutableAttributedString alloc] initWithString: argText];
        [attrIntroString addAttribute:NSParagraphStyleAttributeName value:m_paragraphStyle
                            range:NSMakeRange(0, [argText length])];
        self.attributedText = attrIntroString;
    }
    else
    {
        [super setText:argText];
    }
}

@end
