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

#define VIEWBTNTAG 1000

@interface YYYanContentView ()
{
    UIScrollView *m_pScrollView;
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
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    m_pScrollView.scrollEnabled = YES;
    m_pScrollView.contentOffset = CGPointMake(0, 0);
    m_pScrollView.backgroundColor = [UIColor clearColor];
    m_pScrollView.showsVerticalScrollIndicator = NO;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
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
    CGFloat fBackViewSizeW = 216*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewSizeH = 381*[AppConfigure GetLengthAdaptRate];
    CGFloat fLabelSizeW = fBackViewSizeW-20*[AppConfigure GetLengthAdaptRate];
    CGFloat fLabelSizeH = 16;
    CGFloat fBackViewX = 20*[AppConfigure GetLengthAdaptRate];
    CGFloat fBackViewInterval = 4*[AppConfigure GetLengthAdaptRate];
    for (NSInteger i = 0; i<argData.count ; i++)
    {
        YYYanData *pData = argData[i];
        UIView *pBackgroupView = [[UIImageView alloc] initWithFrame:CGRectMake(fBackViewX+(i * (fBackViewSizeW + fBackViewInterval)), 0, fBackViewSizeW, fBackViewSizeH)];
        pBackgroupView.backgroundColor = [UIColor whiteColor];
        [m_pScrollView addSubview:pBackgroupView];
        
        UIButton *pPhotoBtn = [[UIButton alloc] initWithFrame:pBackgroupView.frame];
        pPhotoBtn.backgroundColor = [UIColor clearColor];
        [pPhotoBtn addTarget:self action:@selector(ClickCheckDetails:) forControlEvents:UIControlEventTouchUpInside];
        pPhotoBtn.tag = VIEWBTNTAG + i;
        [m_pScrollView addSubview:pPhotoBtn];
        
        
        UILabel *pBookNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], 25*[AppConfigure GetLengthAdaptRate], fLabelSizeW, fLabelSizeH)];
        pBookNameLab.text = pData.bookName;
        pBookNameLab.textColor = UIColorFromHex(0x666666);
        pBookNameLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:15];
        [pBackgroupView addSubview:pBookNameLab];
        
        UILabel *pAuthorLab = [[UILabel alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], pBookNameLab.bottom + 10*[AppConfigure GetLengthAdaptRate], fLabelSizeW, 13)];
        pAuthorLab.text = pData.author;
        pAuthorLab.textColor = UIColorFromHex(0xcccccc);
        pAuthorLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:12.0];
        [pBackgroupView addSubview:pAuthorLab];
        
        UIImageView *pCoverImg = [[UIImageView alloc] initWithFrame:CGRectMake(10*[AppConfigure GetLengthAdaptRate], pAuthorLab.bottom + 10*[AppConfigure GetLengthAdaptRate], 195*[AppConfigure GetLengthAdaptRate], 283*[AppConfigure GetLengthAdaptRate])];
        [pCoverImg setImageWithURL:[NSURL URLWithString:pData.cover] placeholderImage:nil];
        [pBackgroupView addSubview:pCoverImg];
        
    }
    m_pScrollView.contentSize = CGSizeMake(fBackViewX+(argData.count * (fBackViewSizeW+fBackViewInterval)), 0);
}

@end
