//
//  YYPlayHomePageCell.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYPlayHomePageCellDelgate <NSObject>

-(void)ClickCheckDetailsWithId:(NSInteger)argId;

@end

@interface YYPlayHomePageCell : UITableViewCell

@property (nonatomic,weak)id<YYPlayHomePageCellDelgate> propDelegate;

-(void)SetDirectoryTitle:(NSString *)argTitle;

@end
