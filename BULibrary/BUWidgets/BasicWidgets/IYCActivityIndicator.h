//
//  IYCActivityIndicator.h
//  icbcyidaicard
//
//  Created by 杨阳 on 11-6-19.
//  Copyright 2011 ShootingChance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IYCActivityIndicator : NSObject {
    UILabel* m_pLabel;
	UIButton* m_pButton;
	UIImageView* m_pIndicatorBg;
	UIActivityIndicatorView* m_pIndicator;
	BOOL m_bOn;
    NSString* m_strLabelText;
    NSMutableArray* m_arrWidgets;
//	UIAlertView* m_pAlert;
}

+(IYCActivityIndicator*) GetInstance;

- (void)StartIndicator;

- (void)StartIndicator:(NSString*)argText;

- (void)EndIndicator;

- (void)Show;

- (void)Hide;

- (BOOL)doesAlertViewExist:(UIWindow*)argWindow;

// Set the label text of the indicator. Note that this method
// should be called after the StartIndicator: method, otherwise
// the text will be overwritten.
- (void)SetText:(NSString*)argText;

-(void)SetBlock:(BOOL)argFlag;

@end
