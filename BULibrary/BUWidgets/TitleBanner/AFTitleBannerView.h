//
//  JJBirthdayRemindView.h
//  pbuJaaaJa
//
//  Created by  on 16/2/4.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFTitleBannerViewDelegate <NSObject>

/**
 *  查看详细信息
 *
 *  @param argData 详细信息数据
 */
- (void)CheckDetailInfo:(id)argData;

@end

/**
 *  纯文字的上下轮播方式的轮播图
 */
@interface AFTitleBannerView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *m_pBannerView;
    NSTimer *m_pTimer;
    
    NSArray *m_arrData;
    NSArray *m_arrTitle;
}

@property(nonatomic,weak)id<AFTitleBannerViewDelegate>propDel;

-(void)SetData:(NSArray*)arrData andTitle:(NSArray *)argTitle;

@end
