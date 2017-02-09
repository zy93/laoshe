//
//  SXOptionBaseView.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/10.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFBaseOptionView : UIView<UIScrollViewDelegate>
{
    UIScrollView *m_pTopView;         ///顶部的滑动视图
    UIScrollView *m_pScrollView;      ///用于摆放多个主要显示子页面
    UIView *m_pMark;      ///标示视图
    UIImageView *m_pRow;   ///标线
    UIButton *m_pSelectedBtn;    ///选中的button
}

/**
 *  初始化顶部滑动视图按钮
 *
 *  @param argKind 类型的集合
 */
- (void)CreatTopViewWithTitles:(NSArray *)argKind;

/**
 *  初始化主要页面
 *
 *  @param argViews 主页面视图的集合(这个数组里放的是若干个视图实例，实例需要按照一定的顺序排列放在数组中，并且每个实例需要初始化大小，其大小为CGRectMake(0, 0, m_pScrollView.width, m_pScrollView.height)即可，该方法可以进行自动排序。另外，实例的tag值需要从100开始，依此递增)
 */
- (void)CreatMainSubviewsWithViews:(NSArray *)argViews;

/**
 *  获取当前页面所处的页数
 *
 *  @return 页数
 */
- (NSInteger)GetCurrentPage;

/**
 *  当主视图区域发生滑动时做出相关操作，可继承实现相应方法
 */
- (void)MakeCorrespondingEventAction;

@end
