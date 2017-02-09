//
//  BURegisterInputWidget.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-6-30.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BURegisterInputWidget.h"
#import "BUCoreUtility.h"

@interface BURegisterInputWidget ()

@end

@implementation BURegisterInputWidget

@synthesize propDelegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    m_pDefaultBorderColor = [UIColor blackColor];
    
    // set the bolder of the widget
    self.layer.borderColor = m_pDefaultBorderColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor clearColor];
    
    // create the input widget
    CGFloat fInputStartPosX = 25*[AppConfigure GetLengthAdaptRate];
    m_pInputView = [[UITextField alloc] initWithFrame:CGRectMake(fInputStartPosX, 0, self.frame.size.width-25, self.frame.size.height)];
    [self addSubview:m_pInputView];
    m_pInputView.tag = 10;
    [m_pInputView setFont:[UIFont fontWithName:@"Arial" size:15]];
    m_pInputView.delegate = self;
    m_pInputView.textColor = cInputFontColor;
    
    m_pBundleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pBundleBtn.frame = CGRectMake(self.frame.size.width - (67 + 13)* [AppConfigure GetLengthAdaptRate], 8, 67 * [AppConfigure GetLengthAdaptRate], self.frame.size.height - 16);
    [m_pBundleBtn setTitleColor:[AppConfigure BlackColor] forState:UIControlStateNormal];
    m_pBundleBtn.layer.cornerRadius = m_pBundleBtn.frame.size.height / 2;
    m_pBundleBtn.layer.masksToBounds = YES;
    m_pBundleBtn.hidden = YES;
    m_pBundleBtn.titleLabel.font = [UIFont fontWithName:[AppConfigure BoldFont] size:15];
    [m_pBundleBtn addTarget:self action:@selector(BundleUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_pBundleBtn];
    
    return self;
}

#pragma mark - public methods
-(void)SetIcon:(NSString*)argIconName
{
    // if the icon view is created, first remove it
    if(m_pIconView != nil)
    {
        [m_pIconView removeFromSuperview];
    }
    
    // build the icon view
    m_pIconView = [BUCoreUtility newImageView:argIconName];
    m_pIconView.center = CGPointMake(30, self.bounds.size.height/2);
    [self addSubview:m_pIconView];
    
    // build the "|" after the icon view
    /*UIImageView* pSepView = [[UIView];
    pSepView.center = CGPointMake(60, self.bounds.size.height/2);
    [self addSubview:pSepView];*/
    
    // move the input view some distance right
    m_pInputView.frame = CGRectMake(m_pIconView.frame.origin.x+m_pIconView.frame.size.width+ 25, m_pInputView.frame.origin.y, self.bounds.size.width-m_pIconView.frame.origin.x-25, m_pInputView.frame.size.height);
}

-(void)SetPlaceHolder:(NSString *)argText
{
    m_pInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:argText attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];

    //[m_pInputView setPlaceholder:argText];
}

-(void)SetKeyboardType:(UIKeyboardType)argType
{
    m_pInputView.keyboardType = argType;
}

-(void)SetKeyboardReturnType:(UIReturnKeyType)argType
{
    [m_pInputView setReturnKeyType:argType];
}

-(void)EndTextEditing
{
    [m_pInputView endEditing:YES];
}

-(NSString*)GetText
{
    return [m_pInputView text];
}

-(void)SetText:(NSString *)argText
{
    m_pInputView.text = argText;
}

-(void)SetDefaultBorderColor:(UIColor*)argColor
{
    m_pDefaultBorderColor = argColor;
    self.layer.borderColor = m_pDefaultBorderColor.CGColor;
}

#pragma mark - delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(InputEditingDidBegin:)])
    {
        [self.propDelegate InputEditingDidBegin:self];
    }
    self.layer.borderColor = [UIColor blackColor].CGColor;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(InputEditingDidEnd:)])
    {
        [self.propDelegate InputEditingDidEnd:self];
    }
    self.layer.borderColor = m_pDefaultBorderColor.CGColor;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [m_pInputView endEditing:YES];
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(InputEditingDidReturn:)])
    {
        [self.propDelegate InputEditingDidReturn:self];
    }
    return YES;
}

- (void)SetBundleBtnTitle:(NSString *)argTitle
{
    m_pBundleBtn.hidden = NO;
    [m_pBundleBtn setTitle:argTitle forState:UIControlStateNormal];
    if ([argTitle isEqualToString:@"绑定"])
    {
        m_pBundleBtn.backgroundColor = [UIColor blackColor];
    }
    else
    {
         [m_pBundleBtn setBackgroundColor:[UIColor colorWithWhite:80/255.0 alpha:1]];
    }
}

- (void)BundleUserInfo:(UIButton *)button
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(BundleUserInfo:)])
    {
        [self.propDelegate BundleUserInfo:button];
    }
}
@end
