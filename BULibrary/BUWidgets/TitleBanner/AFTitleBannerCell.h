//
//  JJBirthdayRemindCell.h
//  pbuJaaaJa
//
//  Created by  on 16/2/4.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFTitleBannerCell : UICollectionViewCell
{
    UIButton *m_pShowTitle;
}

- (void)ClearData;

- (void)SetTitleData:(NSString *)argTitle;

@end
