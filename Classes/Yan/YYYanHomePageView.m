//
//  YYYanHomePageView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/11.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYanHomePageView.h"
#import "YYYanHomePageCell.h"
#import "YYYanChannelView.h"
#import "YYYanContentView.h"

@interface YYYanHomePageView ()<YYYanChannelViewDelegate>
{
    YYYanChannelView *m_pYanChannelView;
    YYYanContentView *m_pYanContentView;
    UILabel *m_pTitleLab;
    UIImageView *m_pHeadImgView;
    UITableView *m_pTableView;
    NSMutableArray *m_arrChannel;
    NSMutableArray *m_arrImage;
}

@end

@implementation YYYanHomePageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrChannel = [NSMutableArray arrayWithObjects:@"原著",@"工具书",@"图录画册",@"专著",@"论文集",@"译本",@"国外研究" ,nil];
        m_arrImage = [NSMutableArray arrayWithObjects:@"yan_yuan_zhu.png",@"yan_gong_ju_shu.png",@"yan_tu_hua_tu_ce.png",@"yan_zhuan_zhu.png",@"yan_lun_wen_ji.png",@"yan_yi_ben.png",@"yan_guo_wai_yan_jiu.png", nil];
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    UIImage *pImage =[UIImage imageNamed:m_arrImage[0]];
    m_pHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 161*[AppConfigure GetLengthAdaptRate])];
    m_pHeadImgView.image = pImage;
    m_pHeadImgView.contentMode = UIViewContentModeScaleAspectFill;
    m_pHeadImgView.clipsToBounds = YES;
    [self addSubview:m_pHeadImgView];
    
    m_pTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 121, self.width, 20)];
    m_pTitleLab.text = m_arrChannel[0];
    m_pTitleLab.textColor = UIColorFromHex(0xffffff);
    m_pTitleLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:18.0];
    m_pTitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:m_pTitleLab];
    
    m_pYanChannelView = [[YYYanChannelView alloc] initWithFrame:CGRectMake(0, 37, self.width , 20*[AppConfigure GetLengthAdaptRate])];
    [m_pYanChannelView SetDefaultChannel:0];
    [m_pYanChannelView SetChannelLength:(self.width-30*[AppConfigure GetLengthAdaptRate])/4];
    [m_pYanChannelView SetChannelCount:m_arrChannel];
    m_pYanChannelView.propDelegete = self;
    [self addSubview:m_pYanChannelView];
    
    m_pYanContentView = [[YYYanContentView alloc] initWithFrame:CGRectMake(0, m_pHeadImgView.bottom + 40*[AppConfigure GetLengthAdaptRate], self.width, self.height - m_pHeadImgView.bottom - 40*[AppConfigure GetLengthAdaptRate])];
    [self addSubview:m_pYanContentView];
}

#pragma mark - YYYanChannelViewDelegate methods
-(void)SelectIndex:(NSInteger)argIndex
{
    m_pTitleLab.text = m_arrChannel[argIndex];
    m_pHeadImgView.image = [UIImage imageNamed:m_arrImage[argIndex]];
}

@end
