//
//  AFActionSheetCell.h
//  AFActionSheet
//
//  Created by 1bu2bu on 16/9/13.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFActionSheetCell : UITableViewCell
{
    UIImageView *sheetImageView;
    UILabel *sheetTitle;
    BOOL hideSeparator;
}

+ (instancetype)CellWithTableView:(UITableView *)tableView;

- (void)ClearCellData;

- (void)SetCellWithImage:(UIImage *)image Title:(NSString *)title;

- (void)SetWetherDestructive:(BOOL)isDestructive;

- (void)HideSeparator:(BOOL)hide;

@end
