//
//  AFActionSheet.h
//  AFActionSheet
//
//  Created by 1bu2bu on 16/9/13.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height

//#define IS_EMPTY_STRING(x)          (!x || [x isKindOfClass:[NSNull class]] || [x isEqual:@""] || [x isEqual:@"(null)"])
//#define AFWeak         __weak __typeof(self) weakSelf = self

static const NSInteger cancleIndex = -1;

typedef void(^ClickActionBlock)(NSInteger clickIndex);

@interface AFActionSheet : UIView

/**
*  ACTIONSHEET
*
*  @param title            标题内容(可空)
*  @param cancleTitle      取消按钮标题，默认显示为取消（可空）
*  @param destructiveTitle 具有破坏性的功能的标题
*  @param otherTitlesArray 选项数组(NSString数组)
*  @param imageArray       图片数组(UIImage数组)
*  @param clickActionBlock 点击选项的回调（从上到下，从0开始依次递增，取消按钮的值为cancleIndex）
*/
+ (void)af_showActionSheetWithTitle:(NSString *)title
                                            cancleTitle:(NSString *)cancleTitle
                                     destructiveTitle:(NSString *)destructiveTitle
                                         otherTitlesArray:(NSArray<NSString *> *)otherTitlesArray
                                            imageArray:(NSArray<UIImage *> *)imageArray
                                 ClickActionBlock:(ClickActionBlock)clickActionBlock;

@end
