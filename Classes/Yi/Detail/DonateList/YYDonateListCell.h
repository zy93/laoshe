//
//  YYDonateListCell.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDonateData;

@interface YYDonateListCell : UITableViewCell

-(void)SetLineViewShow:(BOOL)argShow;

-(void)SetDonateData:(YYDonateData *)argData;

@end
