//
//  SXCommentData.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/4.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFCommentData.h"

@implementation AFCommentData

@synthesize headImage = m_strHeadImage;

- (id)init
{
    self = [super init];
    self.commentId = -1;
    self.newsId = -1;
    self.uid = -1;
    self.nickName = @"";
    self.headImage = @"";
    self.text = @"";
    self.time = -1;
    self.toNickName = @"";
    return self;
}

- (void)setHeadImage:(NSString *)headImage
{
    m_strHeadImage = [NSString stringWithFormat:@"%@%@",[AppConfigure GetFileDomain],headImage];
}

@end
