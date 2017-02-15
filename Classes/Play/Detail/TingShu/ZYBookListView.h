//
//  ZYBookListView.h
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/15.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYBookListView;
@protocol ZYBookListViewDelegate <NSObject>


/**
 选择播放内容后响应该方法

 @param index 所选择的下标
 */
-(void)selectBookIndex:(NSInteger)index;

@end


@interface ZYBookListView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *m_table;
}

@property (nonatomic, strong) NSArray *m_bookList;
@property (nonatomic, assign) NSInteger playBookIndex; //当前播放的下标
@property (nonatomic, weak) id <ZYBookListViewDelegate>delegate;

@end
