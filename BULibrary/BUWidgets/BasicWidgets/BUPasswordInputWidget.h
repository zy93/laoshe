//
//  BUPasswordInputWidget.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-3.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURegisterInputWidget.h"

/// The class is used as the password input widget
/// it is inheritate from BURegisterInputWidget
/// The special points for Password are 1)input style is different
/// and 2) the return text should be md5 encrypted.
@interface BUPasswordInputWidget : BURegisterInputWidget

/// Get the password which is md5 encryoted
/// @return the password
-(NSString*)GetPassword;
@end
