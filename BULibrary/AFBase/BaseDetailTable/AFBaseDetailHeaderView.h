//
//  SXBaseDetailHeaderView.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/15.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFBaseDetailHeaderViewDelegate <NSObject>

- (void)ChangeDetailNewsHeaderHeight:(CGFloat)argHeight;

@end

@interface AFBaseDetailHeaderView : UIView<UIWebViewDelegate>
{
    UILabel *m_pNewsTitle;   ///新闻标题
    UILabel *m_pNewsFrom;   ///来源+时间
    UIWebView *m_pNewsWeb;    ///新闻内容
    
    @public
    /**
     *  以下三个属性必须在子类中赋值，否则不能完成分享功能
     */
    NSString *m_strShareTitle;       ///分享的标题
    UIImage *m_pImage;
    NSString *m_strShareContent;     ///分享的内容
}

@property(nonatomic,weak)id<AFBaseDetailHeaderViewDelegate> propDel;

/**
 *  设置数据
 *
 *  @param argData 各个控件的数据
 */
- (void)SetData:(id)argData;

/**
 *  返回自身高度
 *
 *  @return 高度
 */
- (CGFloat)GetViewHeight;

@end
