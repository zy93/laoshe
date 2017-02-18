//
//  YYYiFriendsCell.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/8.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYFriendData;

@protocol YYYiFriendsCellDelegate <NSObject>

-(void)ClickCheckDetailsWithData:(YYFriendData *)argData;

@end

@interface YYYiFriendsCell : UITableViewCell

@property (nonatomic,weak)id<YYYiFriendsCellDelegate> propDelegate;

-(void)SetFriendData:(NSArray *)argData;

@end
