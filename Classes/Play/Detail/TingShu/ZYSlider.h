//
//  ZYSlider.h
//  AudioPlay
//
//  Created by 张雨 on 2017/2/4.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYSliderDelegate <NSObject>

-(void)slider:(CGFloat)value;

@end

/**
 * 自定义控制条，添加一个进度条。
 */
@interface ZYSlider : UIControl
{
    UISlider *_slider;
    
    UIProgressView *_progressView;
    BOOL _loaded;
    id _target;
    SEL _action;
}

@property (nonatomic, weak) id <ZYSliderDelegate>delegate;
@property (nonatomic, assign) CGFloat value; //进度条进度slider
@property (nonatomic, assign) CGFloat middleValue; //中间进度值progress
//@property (nonatomic, strong) UIColor *thumbTintColor; //滑块颜色
@property (nonatomic, strong) UIColor *minimumTrackTintColor; //左边颜色
@property (nonatomic, strong) UIColor *middleTrackTintColor; //中间颜色
@property (nonatomic, strong) UIColor *maximumTrackTintColor; //右边颜色



@end
