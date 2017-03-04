//
//  YYYanContentView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/12.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanContentView.h"
#import "UIImageView+AFNetworking.h"
#import "YYYanData.h"
#import "JT3DScrollView.h"

#define VIEWBTNTAG 1000

@interface YYYanContentView ()
{
    JT3DScrollView *m_pScrollView;
    NSMutableArray *m_arrData;
}

@end

@implementation YYYanContentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrData = [NSMutableArray array];
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews  ///40
{
    m_pScrollView = [[JT3DScrollView alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width-100, self.frame.size.height)];
    m_pScrollView.scrollEnabled = YES;
    m_pScrollView.contentOffset = CGPointMake(0, 0);
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.showsVerticalScrollIndicator = NO;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    m_pScrollView.effect = JT3DScrollViewEffectDepth;

    [self addSubview:m_pScrollView];
}

-(void)ClickCheckDetails:(UIButton *)argBtn
{
    NSLog(@"113333111");
}

#pragma mark - public methods
-(void)SetYanData:(NSArray *)argData
{
    [m_arrData removeAllObjects];
    [m_arrData addObjectsFromArray:argData];
    for (UIView *pView in m_pScrollView.subviews)
    {
        [pView removeFromSuperview];
    }
    
    for (NSInteger i = 0; i<argData.count ; i++)
    {
        YYYanData *pData = argData[i];
        [self addData:pData];
        
    }
}

-(void)addData:(YYYanData *)pData
{
    CGFloat width = CGRectGetWidth(m_pScrollView.frame);
    CGFloat height = CGRectGetHeight(m_pScrollView.frame);
    CGFloat x = m_pScrollView.subviews.count * width;
    CGFloat fLabelSizeH = 16;

    
    UIView *pBackgroupView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    pBackgroupView.backgroundColor = [UIColor whiteColor];
    pBackgroupView.layer.cornerRadius = 8.;

    [m_pScrollView addSubview:pBackgroupView];
    
//    UIButton *pPhotoBtn = [[UIButton alloc] initWithFrame:pBackgroupView.frame];
//    pPhotoBtn.backgroundColor = [UIColor clearColor];
//    [pPhotoBtn addTarget:self action:@selector(ClickCheckDetails:) forControlEvents:UIControlEventTouchUpInside];
//    pPhotoBtn.tag = VIEWBTNTAG + x;
//    [m_pScrollView addSubview:pPhotoBtn];
    
    
    UILabel *pBookNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], CGRectGetWidth(m_pScrollView.frame), fLabelSizeH)];
    pBookNameLab.text = pData.bookName;
    pBookNameLab.textAlignment = NSTextAlignmentCenter;
    pBookNameLab.textColor = UIColorFromHex(0x666666);
    pBookNameLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
    [pBackgroupView addSubview:pBookNameLab];
    
    UILabel *pAuthorLab = [[UILabel alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], pBookNameLab.bottom + 10*[AppConfigure GetLengthAdaptRate], CGRectGetWidth(m_pScrollView.frame), 13)];
    pAuthorLab.text = pData.author;
    pAuthorLab.textAlignment = NSTextAlignmentCenter;
    pAuthorLab.textColor = UIColorFromHex(0xcccccc);
    pAuthorLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:12.0];
    [pBackgroupView addSubview:pAuthorLab];
    
    UIImageView *pCoverImg = [[UIImageView alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], pAuthorLab.bottom + 20*[AppConfigure GetLengthAdaptRate], 195*[AppConfigure GetLengthAdaptRate], 283*[AppConfigure GetLengthAdaptRate])];
    [pCoverImg setImageWithURL:[NSURL URLWithString:pData.cover] placeholderImage:nil];
    pCoverImg.center = CGPointMake(CGRectGetWidth(m_pScrollView.frame)/2, CGRectGetMidY(pCoverImg.frame));
    [pBackgroupView addSubview:pCoverImg];
    
    [m_pScrollView setContentSize: CGSizeMake(x + width, height)];

}

@end
