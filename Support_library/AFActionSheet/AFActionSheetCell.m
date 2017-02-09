//
//  AFActionSheetCell.m
//  AFActionSheet
//
//  Created by 1bu2bu on 16/9/13.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "AFActionSheetCell.h"

static NSString *AFActionSheetCellIdentifier = @"AFActionSheetCell";

@implementation AFActionSheetCell

+ (instancetype)CellWithTableView:(UITableView *)tableView
{
    AFActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:AFActionSheetCellIdentifier];
    if (!cell) {
        cell = [[AFActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AFActionSheetCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        sheetImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:sheetImageView];
        
        sheetTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        sheetTitle.textColor = [UIColor colorWithRed:30 / 255.0f green:130 / 255.0f blue:255 / 255.0f alpha:1.0];
        sheetTitle.font = [UIFont systemFontOfSize:18.0f];
        sheetTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:sheetTitle];
    }
    return self;
}

- (void)ClearCellData
{
    sheetTitle.textColor = [UIColor colorWithRed:30 / 255.0f green:130 / 255.0f blue:255 / 255.0f alpha:1.0];
    sheetImageView.image = nil;
    sheetTitle.text = @"";
}

- (void)SetCellWithImage:(UIImage *)image Title:(NSString *)title
{
    sheetImageView.image = image;
    sheetTitle.text = title;
    [self setNeedsLayout];
}

- (void)SetWetherDestructive:(BOOL)isDestructive
{
    if (isDestructive) {
        sheetTitle.textColor = [UIColor redColor];
    }
}

- (void)HideSeparator:(BOOL)hide
{
    hideSeparator = hide;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!hideSeparator) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        CGContextSetStrokeColorWithColor(context,[UIColor colorWithWhite:0.8 alpha:0.5].CGColor);
        CGContextStrokeRect(context,CGRectMake(0, 0, rect.size.width, 0.5f));
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    if (sheetImageView.image == nil)
    {
        sheetTitle.frame = CGRectMake(4, 4, self.frame.size.width - 8, self.frame.size.height - 8);
    }
    else
    {
        sheetImageView.frame = CGRectMake(0, 0, self.frame.size.height - 4, self.frame.size.height - 4);
        if ([sheetTitle.text isEqualToString:@""])
        {
            sheetImageView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
        }
        else
        {
            CGSize titleSize = [sheetTitle sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            if (titleSize.width < self.frame.size.width - (sheetImageView.frame.size.width + 10)) {
                sheetImageView.center = CGPointMake(sheetImageView.frame.size.width / 2.0f + 4 + (self.frame.size.width - 10 - sheetImageView.frame.size.width - titleSize.width) / 2.0f, self.frame.size.height / 2.0f);
                sheetTitle.frame = CGRectMake(CGRectGetMaxX(sheetImageView.frame) + 2 , 0, titleSize.width, self.frame.size.height);
            }
            else
            {
                sheetImageView.center = CGPointMake(4 + sheetImageView.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
                sheetTitle.frame = CGRectMake(CGRectGetMaxX(sheetImageView.frame) + 2 , 0, self.frame.size.width - (sheetImageView.frame.size.width + 10), self.frame.size.height);
            }
        }
    }
}

@end
