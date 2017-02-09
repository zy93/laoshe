//
//  ADPickerDialectView.m
//  pbuAudiClient
//
//  Created by   on 16/2/24.
//  Copyright © 2016年  . All rights reserved.
//

#import "AFPickerView.h"

@implementation AFPickerView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self AddSubviews];
    }
    return self;
}

- (void)AddSubviews
{
    UIButton *pCancelV = [UIButton buttonWithType:UIButtonTypeCustom];
    pCancelV.frame = CGRectMake(0, 0, self.width, self.height - 200 * [AppConfigure GetLengthAdaptRate]);
    [pCancelV addTarget:self action:@selector(ClosePickerView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pCancelV];
    
    m_pBg = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 300 * [AppConfigure GetLengthAdaptRate])];
    m_pBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:m_pBg];
    
    m_pPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30.0f, self.width, 300 * [AppConfigure GetLengthAdaptRate])];
    m_pPickerView.showsSelectionIndicator = YES;
    m_pPickerView.backgroundColor = [UIColor clearColor];
    m_pPickerView.delegate = self;
    m_pPickerView.dataSource = self;
    [m_pBg addSubview:m_pPickerView];
    
    UIButton *pCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 0 , 40 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pCloseButton setTitle:@"取消" forState:UIControlStateNormal];
    [pCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pCloseButton.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14];
    [pCloseButton addTarget:self action:@selector(ClosePickerView) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pCloseButton];
    
    UIButton *pSendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50 * [AppConfigure GetLengthAdaptRate], 0 , 40 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pSendButton setTitle:@"确定" forState:UIControlStateNormal];
    [pSendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pSendButton.titleLabel.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14];
    [pSendButton addTarget:self action:@selector(SureSelected) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pSendButton];
}

#pragma mark -- property method
- (void)setPropCurrentData:(NSString *)propCurrentData
{
    for (NSInteger iIndex = 0; iIndex < m_arrPickerData.count; iIndex ++)
    {
        NSString *strPickerData = m_arrPickerData[iIndex];
        if ([strPickerData isEqualToString:propCurrentData])
        {
            m_iSelected = iIndex;
            [m_pPickerView selectRow:iIndex inComponent:0 animated:NO];
            break;
        }
    }
}

#pragma mark -- public method
- (void)SetPickerViewData:(NSArray *)argData
{
    m_arrPickerData = argData;
    m_iSelected = 0;
    [m_pPickerView reloadAllComponents];
}

- (void)ShowPickerView
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(m_pBg) weakBg = m_pBg;
    [UIView animateWithDuration:0.35f animations:^{
        weakBg.transform = CGAffineTransformMakeTranslation(0, -weakBg.height);
        weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)GetSelectRow
{
    return m_iSelected;
}

#pragma mark -- private method
- (void)ClosePickerView
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(m_pBg) weakBg = m_pBg;
    [UIView animateWithDuration:0.35f animations:^{
        weakBg.transform = CGAffineTransformMakeTranslation(0, weakBg.height);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)SureSelected
{
    if (self.SureSelectResult) {
        self.SureSelectResult(m_iSelected);
    }
    [self ClosePickerView];
}

#pragma mark -- UIPickerViewDataSource method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return m_arrPickerData.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.width;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return m_arrPickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m_iSelected = row;
}

//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont fontWithName:[AppConfigure RegularFont] size:20]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    [self changeSpearatorLineColor];
    
    return pickerLabel;
}

#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in m_pPickerView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = UIColorFromHex(0xe1e1e1);//隐藏分割线
        }
    }
}


@end
