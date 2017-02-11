
//
//  YYYanHeadView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanHeadView.h"

@interface YYYanHeadView ()
{
    UIImageView *m_pBackView;
}

@end

@implementation YYYanHeadView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 222*[AppConfigure GetLengthAdaptRate])];
    m_pBackView.backgroundColor = [UIColor redColor];
    [self addSubview:m_pBackView];
}



@end
