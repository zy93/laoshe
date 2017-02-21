//
//  YYYIDonationCell.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/12.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYYiDonationCellDelegate <NSObject>

-(void)CheckMoreContent;

@end

@interface YYYiDonationCell : UITableViewCell

@property (nonatomic,weak)id<YYYiDonationCellDelegate> propDelegate;

-(void)SetDonationData:(NSArray *)argData;

-(void)SetType:(NSInteger)argType;

@end
