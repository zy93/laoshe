//
//  IYCActivityIndicator.m
//  icbcyidaicard
//
//  Created by 杨阳 on 11-6-19.
//  Copyright 2011 ShootingChance. All rights reserved.
//

#import "IYCActivityIndicator.h"
#import "BUCoreUtility.h"

@implementation IYCActivityIndicator

static IYCActivityIndicator* m_sInstance;
+(IYCActivityIndicator*) GetInstance{
	@synchronized(self){
		if (m_sInstance==nil) {
			m_sInstance = [[self alloc] init];
		}		
	}
	return m_sInstance;
}

- (id)init
{
    if (self = [super init]) 
	{
        m_pLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 50)];
        m_pLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2 + 60);
        [m_pLabel setTextAlignment:NSTextAlignmentCenter];
        [m_pLabel setBackgroundColor:[UIColor clearColor]];
        [m_pLabel setTextColor:[UIColor colorWithWhite:172/255.0 alpha:1]];
        [m_pLabel setText:@""];
        m_strLabelText = @"";
        
		m_pButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
		m_pButton.backgroundColor = [UIColor clearColor];
        [m_pButton setExclusiveTouch:YES];
		//m_pButton.alpha = 0.5;
		[m_pButton setUserInteractionEnabled:YES];
        [m_pButton addTarget:self action:@selector(ClickButton) forControlEvents:UIControlEventTouchUpInside];
		
//		m_pIndicatorBg = [BUCoreUtility newImageView:@"indicatorbg.png"];
//		m_pIndicatorBg.center = CGPointMake(160, 240);
		
		m_pIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        m_pIndicator.color = [UIColor colorWithWhite:172/255.0 alpha:1];
		m_pIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
		
        m_arrWidgets = [NSMutableArray arrayWithObjects:m_pLabel, m_pButton, m_pIndicator, nil];
		m_bOn = NO;
	}
	return self;
}

- (void)StartIndicator
{
	if(m_bOn)
		return;
    
    m_strLabelText = @"";
	[self performSelectorInBackground:@selector(Show) withObject:nil];
}

- (void)SetText:(NSString*)argText
{
    m_strLabelText = argText;
    
    [m_pLabel performSelectorInBackground:@selector(setText:) withObject:m_strLabelText];
//    if (m_bOn)
//    {
//        UIView * pView = m_pLabel.superview;
//        [m_pLabel removeFromSuperview];
//        [pView addSubview:m_pLabel];
//    }
}


- (void)StartIndicator:(NSString*)argText
{
	if(m_bOn)
		return;
    NSLog(@"StartIndicator");
    m_strLabelText = @"";
    if(argText != nil)
        m_strLabelText = [NSString stringWithString:argText];

	[self performSelectorInBackground:@selector(Show) withObject:nil];
}


- (void)EndIndicator
{
	if(!m_bOn)
		return;
    NSLog(@"EndIndicator");
	[self performSelectorInBackground:@selector(Hide) withObject:nil];
}

- (void)Show
{
    NSLog(@"Show");
	m_bOn = YES;
    
	NSArray* arrWindows = [[UIApplication sharedApplication] windows];
    int iIndex = (int)[arrWindows count]-1;
    UIWindow* pTopWindow = nil;
    while(1)
    {
        pTopWindow = [arrWindows objectAtIndex:iIndex];
        if([self doesAlertViewExist:pTopWindow])
            iIndex--;
        else
            break;
    }
	[pTopWindow addSubview:m_pButton]; 
	//[pTopWindow addSubview:m_pIndicatorBg];
	[pTopWindow addSubview:m_pIndicator]; 
    [pTopWindow addSubview:m_pLabel];
    [m_pLabel setText:m_strLabelText];
	[m_pIndicator startAnimating];
}

- (void)Hide
{
	
    NSLog(@"Hide");
//	[m_pAlert dismissWithClickedButtonIndex:0 animated:YES];
	[m_pIndicator stopAnimating];
	[m_pButton removeFromSuperview];
	//[m_pIndicatorBg removeFromSuperview];
	[m_pIndicator removeFromSuperview];
    [m_pLabel removeFromSuperview];
	m_bOn = NO;
}

- (BOOL)doesAlertViewExist:(UIWindow*)argWindow
{
    for (UIView* view in argWindow.subviews) 
    {
        BOOL alert = [view isKindOfClass:[UIAlertView class]];
        BOOL action = [view isKindOfClass:[UIActionSheet class]];
        if (alert || action)
            return YES;
    }
    
    return NO;
}

- (void)ClickButton
{}

-(void)SetBlock:(BOOL)argFlag
{
    m_pButton.userInteractionEnabled = argFlag;
}
@end
