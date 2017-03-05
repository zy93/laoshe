//
//  BURegisterInputWidget.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-6-30.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Adjust these values according to your project
#define cInputFontColor [UIColor whiteColor];

@class BURegisterInputWidget;

/// The register input widget protocol
/// which is used to tell the delegate object that the
/// user started to do editing, or finished the editing
@protocol BURegisterInputWidgetDelegate <NSObject>

@optional

/// called when the user starts to edit
-(void)InputEditingDidBegin:(BURegisterInputWidget*)argInputWidget;

/// called when the user finishs editing
-(void)InputEditingDidEnd:(BURegisterInputWidget*)argInput;

/// called when the user press the return button
-(void)InputEditingDidReturn:(BURegisterInputWidget*)argInput;

- (void)BundleUserInfo:(UIButton *)button;
@end



/// The class is the input widget used in login page
/// and registration page. It has border, and an icon inside,
/// and an UITextField.
@interface BURegisterInputWidget : UIView <UITextFieldDelegate>
{
    UIImageView* m_pIconView;  /// the view to show the icon like the cell phone and etc
    UITextField* m_pInputView; /// the view to do the real input job
    UIColor* m_pDefaultBorderColor; /// record the defualt border color
    UIButton *m_pBundleBtn;  ///this button is used for binding some user information
}



@property (assign) id<BURegisterInputWidgetDelegate> propDelegate;

/// Set the icon for the input. It will be displayed
/// in the left side of the whole input widget
/// This function will add "|" automaticlly after the icon,
/// and meanwhile it will move m_pInputView to right.
/// @param argIconName The image name
-(void)SetIcon:(NSString*)argIconName;

/// Set the place holder
/// @param argText The content of the place holder
-(void)SetPlaceHolder:(NSString*)argText;

/// Set the input keyboard type
/// like numbers, letters etc
-(void)SetKeyboardType:(UIKeyboardType)argType;

/// Set the return key type
/// like Finish, Search
-(void)SetKeyboardReturnType:(UIReturnKeyType)argType;

/// End the text editing
-(void)EndTextEditing;

/// Set the text content
/// @param argText the text content
-(void)SetText:(NSString*)argText;

/// Get the text content
/// @return The text input by user in m_pInputView
-(NSString*)GetText;

/// Set default border color
/// @param argColor the given color
-(void)SetDefaultBorderColor:(UIColor*)argColor;


- (void)SetBundleBtnTitle:(NSString *)argTitle;
@end
