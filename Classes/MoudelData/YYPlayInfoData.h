//
//  YYPlayInfoData.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/16.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "AFBaseModuleData.h"

@interface YYPlayInfoData : AFBaseModuleData

@property (nonatomic,copy)NSString *mid;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)NSTimeInterval stateDate;
@property (nonatomic,assign)NSTimeInterval endDate;

@end
