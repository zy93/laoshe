//
//  ZYSlider.m
//  AudioPlay
//
//  Created by 张雨 on 2017/2/4.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "ZYSlider.h"

#define POINT_OFFSET (2)

@implementation ZYSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)loadSubView {
    if (_loaded) {
        return;
    }
    
    _loaded = YES;
    
    self.backgroundColor = [UIColor clearColor];
    _slider = [[UISlider alloc] initWithFrame:self.bounds];
    _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_slider setThumbImage:[UIImage imageNamed:@"椭圆 1"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];
    
    
    CGRect rect = _slider.bounds;
    
    rect.origin.x += POINT_OFFSET;
    rect.size.width -= POINT_OFFSET *2;
    
    _progressView = [[UIProgressView alloc] initWithFrame:rect];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _progressView.center = _slider.center;
    _progressView.userInteractionEnabled = NO;
    
    
    [_slider addSubview:_progressView];
    [_slider sendSubviewToBack:_progressView];
    _slider.maximumTrackTintColor = [UIColor clearColor];
    
    

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self loadSubView];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubView];
    }
    return self;
}

-(CGFloat)value
{
    return _slider.value;
}

-(void)setValue:(CGFloat)value {
    _slider.value = value;
}

- (CGFloat)middleValue{
    
    return _progressView.progress;
    
}

- (void)setMiddleValue:(CGFloat)middleValue{
    
//    _progressView.progress = middleValue;
//    [_progressView setProgress:middleValue];
    BOOL isSatrt = YES;
    if (middleValue == 0) {
        isSatrt = NO;
    }
    [_progressView setProgress:middleValue animated:isSatrt];
}

- (UIColor* )minimumTrackTintColor {
    
    return _slider.minimumTrackTintColor;
    
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    
    [_slider setMinimumTrackTintColor:minimumTrackTintColor];
    
}

- (UIColor* )middleTrackTintColor {
    
    return _progressView.progressTintColor;
    
}

- (void)setMiddleTrackTintColor:(UIColor *)middleTrackTintColor {
    
    _progressView.progressTintColor = middleTrackTintColor;
    
}

- (UIColor* )maximumTrackTintColor {
    
    return _progressView.trackTintColor;
    
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    
    _progressView.trackTintColor = maximumTrackTintColor;
    
}

-(void)slider:(UISlider *)slider
{
//    NSLog(@"---------__%f", slider.value);
    if ([_delegate respondsToSelector:@selector(slider:)]) {
        [_delegate slider:slider.value];
    }
}

@end
