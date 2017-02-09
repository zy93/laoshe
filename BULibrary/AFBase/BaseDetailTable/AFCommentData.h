//
//  SXCommentData.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/4.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFCommentData : NSObject
{
    NSString *m_strHeadImage;
}

@property(nonatomic,assign)NSInteger commentId;   ///评论id
@property(nonatomic,assign)NSInteger newsId;   ///新闻id
@property(nonatomic,assign)NSInteger uid;   ///新闻内容
@property(nonatomic,copy)NSString *nickName;    ///评论人昵称
@property(nonatomic,copy)NSString *headImage;   ///评论人头像
@property(nonatomic,copy)NSString *text;    ///评论的内容
@property(nonatomic,assign)NSTimeInterval time;   ///评论时间
@property(nonatomic,copy)NSString *toNickName;   ///被回复的用户的昵称

@end
