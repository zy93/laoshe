//
//  YYNavView.h
//  TableviewTest
//
//  Created by 张雨 on 2017/2/19.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  YYNavViewDelegate <NSObject>

@optional

-(void)NaLeft;
-(void)NaRight;

@end

@interface YYNavView : UIView

@property(nonatomic,assign)id<YYNavViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * headBackView;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)UIColor * color;
@property(nonatomic,strong)NSString * left_bt_Image;
@property(nonatomic,strong)NSString * right_bt_Image;

@end
