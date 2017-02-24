//
//  CardCellCollectionViewCell.m
//  DDCardAnimation
//
//  Created by tondyzhang on 16/10/11.
//  Copyright © 2016年 tondy. All rights reserved.
//

#import "CardCellCollectionViewCell.h"

@interface CardCellCollectionViewCell()

@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UILabel* subtitleLabel;
@property(nonatomic, strong)UIVisualEffectView* blurView;

@end

static int cellCount;

@implementation CardCellCollectionViewCell

-(instancetype)init
{
    self = [self initWithFrame:CGRectZero];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        cellCount++;
//        NSLog(@"%d",cellCount);
    }
    return self;
}

-(void)layoutSubviews
{
    self.contentView.frame = self.bounds;
    self.imageView.frame = CGRectMake(15, 18, CGRectGetWidth(self.bounds)-30, CGRectGetHeight(self.bounds)-18-104);
    self.titleLabel.frame = CGRectMake(15, CGRectGetMaxY(self.imageView.frame)+18, CGRectGetWidth(self.bounds)-30, 18);
    self.subtitleLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame)+18, CGRectGetWidth(self.bounds)-30, 18);
    
    self.blurView.frame = self.bounds;
}

-(void)initUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];

    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:self.imageView];
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.font = [UIFont systemFontOfSize:14];
        _subtitleLabel.textColor = [UIColor blackColor];
    }
    return _subtitleLabel;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

-(void)setBgColor:(UIColor *)bgColor
{
    self.contentView.backgroundColor = bgColor;
}

//-(void)setImage:(UIImage *)image
//{
//    _image = image;
//    [self.imageView removeFromSuperview];
//    self.imageView = [[UIImageView alloc]initWithImage:image];
//    [self.contentView addSubview:self.imageView];
//}

 //设置毛玻璃效果
-(void)setBlur:(CGFloat)ratio
{
    if (!self.blurView.superview) {
        [self.contentView addSubview:self.blurView];
    }
    [self.contentView bringSubviewToFront:self.blurView];
    self.blurView.alpha = ratio;
}

-(UIVisualEffectView*)blurView
{
    if (!_blurView) {
        _blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.frame = self.bounds;
    }
    return _blurView;
}

@end
