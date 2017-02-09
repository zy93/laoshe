//
//  ADPickerDialectView.h
//  pbuAudiClient
//
//  Created by   on 16/2/24.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *m_pBg;      ///页面背景
    
    UIPickerView *m_pPickerView;   ///拾取器
    
     NSArray *m_arrPickerData;    ///可供选择的数据
    
    NSInteger m_iSelected;    ///选中的数据的下标
    
    NSString *m_strCurrentSelected;    ///当前选中的数据
}

@property(nonatomic,copy)void (^SureSelectResult) (NSInteger selectedIndex);

/**
 *  当前选中的数据
 */
@property(nonatomic,copy)NSString *propCurrentData;

/**
 *  给pickerview初始化单元格值
 *
 *  @param argData 单元格数据
 */
- (void)SetPickerViewData:(NSArray *)argData;

/**
 *  显示pickerview
 */
- (void)ShowPickerView;

/**
 *  获取选中的数据的下标
 *
 *  @return 选中数据的下标
 */
- (NSInteger)GetSelectRow;

@end
