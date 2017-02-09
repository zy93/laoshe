//
//  AFActionSheet.m
//  AFActionSheet
//
//  Created by 1bu2bu on 16/9/13.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "AFActionSheet.h"
#import "AFActionSheetCell.h"

@interface AFActionSheet ()<UITableViewDelegate,UITableViewDataSource>

/**主视图*/
@property (strong, nonatomic) UIView *mainView;
/**标题label*/
@property (strong, nonatomic) UILabel *titleLabel;
/*! tableView */
@property (strong, nonatomic) UITableView  *tableView;
/**取消按钮*/
@property (strong, nonatomic) UIButton *cancleBtn;
/*! 触摸背景消失 */
@property (strong, nonatomic) UIControl    *overlayControl;
/*! 数据源 */
@property (strong, nonatomic) NSArray      *otherTitlesArray;
/*! 图片数组 */
@property (strong, nonatomic) NSArray      *imageArray;
/*! 标题 */
@property (copy, nonatomic  ) NSString     *title;
/*!取消按钮标题*/
@property (copy, nonatomic) NSString *cancleTitle;
/*!特别提示按钮标题*/
@property (copy, nonatomic) NSString *destructiveTitle;
/*! 点击事件回调 */
@property (copy, nonatomic) ClickActionBlock clickActionBlock;

@end

@implementation AFActionSheet

+ (instancetype)shareActionSheet
{
    AFActionSheet *actionSheet   = [[self alloc] init];
    actionSheet.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    return actionSheet;
}

+ (void)af_showActionSheetWithTitle:(NSString *)title
                        cancleTitle:(NSString *)cancleTitle
                   destructiveTitle:(NSString *)destructiveTitle
                   otherTitlesArray:(NSArray<NSString *> *)otherTitlesArray
                         imageArray:(NSArray<UIImage *> *)imageArray
                   ClickActionBlock:(ClickActionBlock)clickActionBlock
{
    AFActionSheet *actionSheet = [self shareActionSheet];
    actionSheet.title = title;
    actionSheet.cancleTitle = cancleTitle;
    actionSheet.destructiveTitle = destructiveTitle;
    actionSheet.otherTitlesArray = otherTitlesArray;
    actionSheet.imageArray = imageArray;
    actionSheet.clickActionBlock = clickActionBlock;
    [actionSheet.tableView reloadData];
    [actionSheet ShowSelf];
}

#pragma mark - UITableView method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sheetCount = MAX(self.imageArray.count, self.otherTitlesArray.count);
    if (IS_EMPTY_STRING(self.destructiveTitle)) {
        return sheetCount;
    }else{
        return sheetCount + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFActionSheetCell *cell = [AFActionSheetCell CellWithTableView:tableView];
    [cell ClearCellData];
    [cell HideSeparator:indexPath.row == 0 && IS_EMPTY_STRING(self.title)];
    [cell SetWetherDestructive:indexPath.row == 0 && !IS_EMPTY_STRING(self.destructiveTitle)];
    if (IS_EMPTY_STRING(self.destructiveTitle)) {
        [self SetCellDataWithIndex:indexPath.row tableViewCell:cell];
    }else{
        if (indexPath.row == 0) {
            [cell SetCellWithImage:nil Title:self.destructiveTitle];
        } else {
            [self SetCellDataWithIndex:indexPath.row - 1 tableViewCell:cell];
        }
    }
    return cell;
}

- (void)SetCellDataWithIndex:(NSInteger)index tableViewCell:(AFActionSheetCell *)cell
{
    UIImage *sheetImage = nil;
    NSString *sheetTitle = @"";
    if (self.imageArray.count > index)
    {
        sheetImage = self.imageArray[index];
    }
    if (self.otherTitlesArray.count > index)
    {
        sheetTitle = self.otherTitlesArray[index];
    }
    [cell SetCellWithImage:sheetImage Title:sheetTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.clickActionBlock(indexPath.row);
    [self RemoveSelfFromSuperView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UpdateFrame
- (void)ShowSelf
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self.overlayControl];
    [keywindow addSubview:self];
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.tableView];
    self.titleLabel.text = self.title;
    [self AddSelfToWindow];
}

- (void)CancleButtonAction
{
    if (self.clickActionBlock) {
        self.clickActionBlock(cancleIndex);
    }
    [self RemoveSelfFromSuperView];
}

- (void)UpdateViewFrame
{
    CGFloat tableViewHeight = 0.0f;
    if (IS_EMPTY_STRING(self.title))
    {
        tableViewHeight = MIN(SCREENHEIGHT - 80.0f, self.tableView.contentSize.height);
        self.tableView.scrollEnabled   = SCREENHEIGHT - 80.0f < self.tableView.contentSize.height;
    }
    else
    {
        tableViewHeight = MIN(SCREENHEIGHT - 124.0f, self.tableView.contentSize.height);
        self.tableView.scrollEnabled   = SCREENHEIGHT - 124.0f < self.tableView.contentSize.height;
    }
    self.mainView.frame = CGRectMake(10.0f, 0.f, SCREENWIDTH - 20.0f, tableViewHeight + (IS_EMPTY_STRING(self.title) ? 0.0f : 44.0f));
    self.titleLabel.frame = CGRectMake(0, 0, self.mainView.frame.size.width, (IS_EMPTY_STRING(self.title) ? 0.0f : 44.0f));
    self.tableView.frame = CGRectMake(0.0f, CGRectGetMaxY(self.titleLabel.frame), self.mainView.frame.size.width, tableViewHeight);
    self.cancleBtn.frame = CGRectMake(10.0f, CGRectGetMaxY(self.mainView.frame) + 8.0f, SCREENWIDTH - 20.0f, 44.0f);
    
}

- (void)AddSelfToWindow
{
    [self UpdateViewFrame];
    self.frame = CGRectMake(0.f, SCREENHEIGHT, SCREENWIDTH, self.mainView.frame.size.height + 60.0f);
    AFWeak;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.frame = CGRectMake(0.f, SCREENHEIGHT - weakSelf.mainView.frame.size.height - 60.0f, SCREENWIDTH, weakSelf.mainView.frame.size.height + 60.0f);
    }];
}

- (void)RemoveSelfFromSuperView
{
    AFWeak;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.frame = CGRectMake(0.f, SCREENHEIGHT, SCREENWIDTH, CGRectGetHeight(weakSelf.frame));
        weakSelf.overlayControl.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.overlayControl removeFromSuperview];
            weakSelf.overlayControl = nil;
            [weakSelf removeFromSuperview];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self UpdateViewFrame];
    self.frame = CGRectMake(0.f, SCREENHEIGHT - (self.mainView.frame.size.height + 60.0f), SCREENWIDTH, self.mainView.frame.size.height + 60.0f);
}

#pragma mark - lazy method
- (UIView *)mainView
{
    if (!_mainView)
    {
        _mainView = [[UIView alloc]initWithFrame:CGRectZero];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 5.0f;
        _mainView.layer.masksToBounds = YES;
        [self addSubview:_mainView];
    }
    return _mainView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UITableView *)tableView
{
    if ( !_tableView )
    {
        _tableView                 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.scrollEnabled   = NO;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        _cancleBtn.layer.cornerRadius = 5.0f;
        _cancleBtn.layer.masksToBounds = YES;
        [_cancleBtn setTitle:IS_EMPTY_STRING(self.cancleTitle) ? @"取消" : self.cancleTitle forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor colorWithRed:30 / 255.0f green:130 / 255.0f blue:255 / 255.0f alpha:1.0] forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
        [_cancleBtn addTarget:self action:@selector(CancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleBtn];
    }
    return _cancleBtn;
}

- (UIControl *)overlayControl
{
    if ( !_overlayControl )
    {
        _overlayControl                 = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayControl.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_overlayControl addTarget:self action:@selector(RemoveSelfFromSuperView) forControlEvents:UIControlEventTouchUpInside];
        _overlayControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    }
    return _overlayControl;
}

@end

