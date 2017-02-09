//
//  SXCommentCell.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/11/25.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//
#import "AFBaseCell.h"
#import "AFCommentData.h"

@protocol AFCommentCellDelegate <NSObject>

///举报评论
- (void)InformComment:(NSInteger)argCommentId Reason:(NSString *)argReason;

@end

@interface AFCommentCell : AFBaseCell<UIActionSheetDelegate>
{
    UILongPressGestureRecognizer *m_pLongGest;
}

@property(nonatomic,weak)id<AFCommentCellDelegate>propDel;

@property(nonatomic,retain)AFCommentData *propCommentData;    ///评论数据

@end
