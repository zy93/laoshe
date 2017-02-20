//
//  YYPlayActivityCell.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDonationData;

@protocol YYPlayActivityCellDelegate <NSObject>

-(void)CheckMoreActivity;

@end

@interface YYPlayActivityCell : UITableViewCell

@property (nonatomic,weak)id<YYPlayActivityCellDelegate> propDelegate;

-(void)SetPlayActivityData:(YYDonationData *)argData;


@end
