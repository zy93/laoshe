//
//  YYActivityCell.h
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYActivityData.h"

@interface YYActivityCell : UITableViewCell

-(void)setData:(YYActivityData *)data;
-(void)setColor:(UIColor *)color;

@end
