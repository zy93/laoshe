//
//  YYYiHeadView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/1/25.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYYiHeadView.h"

@interface YYYiHeadView ()
{
    UIImageView *m_pBackgroundView;
    UIImageView *m_pPortraitView;
    UILabel *m_pIntroduceLab1;
    UILabel *m_pIntroduceLab2;
    UILabel *m_pIntroduceLab3;
}

@end

@implementation YYYiHeadView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColorFromHex(0xffffff);
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 310*[AppConfigure GetLengthAdaptRate])];
    m_pBackgroundView.image = [UIImage imageNamed:@"yi_head_background.png"];
    [self addSubview:m_pBackgroundView];
    
    UIImage *pPortraitImg = [UIImage imageNamed:@"yi_laoshe_portrait.png"];
    CGFloat fPortraitW = (m_pBackgroundView.width - pPortraitImg.size.width)/2.0;
    CGFloat fPortraitH = (m_pBackgroundView.height - pPortraitImg.size.height)/2.0;
    m_pPortraitView = [[UIImageView alloc] initWithFrame:CGRectMake(fPortraitW, fPortraitH, pPortraitImg.size.width, pPortraitImg.size.height)];
    m_pPortraitView.image = pPortraitImg;
    [m_pBackgroundView addSubview:m_pPortraitView];
    
    
//    NSString *str = @"我的职业虽使我老在知识分子的圈子里转，可是我的朋友并不都是教授与学者。打拳的、卖唱的、洋车夫也是我的朋友。\n与苦人们来往，我并不只和他们坐坐茶馆，偷偷地把他们的动作与谈论用小本儿记下来，我没有做过这样的事，而只是要交朋友。他们帮我的忙，我也帮他们的忙；他们来给我祝寿，我也去给他们贺喜，当他们生娃娃和娶媳妇的时节。这样，我理会了他们的心态，而不是仅仅知道了他们的生活状况。";
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
//    NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
//    //行间距
//    [paragraphStyle setLineSpacing:5.0];
//    //段落间距
//    [paragraphStyle setParagraphSpacing:10.0];

    
    
    NSString* const msg = @"我的职业虽使我老在知识分子的圈子里转，可是我的朋友并不都是教授与学者。打拳的、卖唱的、洋车夫也是我的朋友。\n与苦人们来往，我并不只和他们坐坐茶馆，偷偷地把他们的动作与谈论用小本儿记下来，我没有做过这样的事，而只是要交朋友。他们帮我的忙，我也帮他们的忙；他们来给我祝寿，我也去给他们贺喜，当他们生娃娃和娶媳妇的时节。这样，我理会了他们的心态，而不是仅仅知道了他们的生活状况。";
    m_pIntroduceLab1 = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pBackgroundView.bottom + 17*[AppConfigure GetLengthAdaptRate], self.width - 40*[AppConfigure GetLengthAdaptRate], 247*[AppConfigure GetLengthAdaptRate])];
    m_pIntroduceLab1.numberOfLines = 0;
    m_pIntroduceLab1.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14.0f];
    m_pIntroduceLab1.textColor = UIColorFromHex(0x333333);
    [m_pIntroduceLab1 setAttributedText:[YYYiHeadView setTextString:msg]];
    
    [m_pIntroduceLab1 setLineBreakMode:NSLineBreakByTruncatingHead];
    [self addSubview:m_pIntroduceLab1];
    [m_pIntroduceLab1 sizeToFit];
    
//    
    m_pIntroduceLab3 = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], m_pIntroduceLab1.bottom + 17*[AppConfigure GetLengthAdaptRate], m_pIntroduceLab1.frame.size.width, 16*[AppConfigure GetLengthAdaptRate])];
    m_pIntroduceLab3.text = @"——老舍";
    m_pIntroduceLab3.numberOfLines = 0;
    m_pIntroduceLab3.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14.0f];
    m_pIntroduceLab3.textColor = UIColorFromHex(0x333333);
//    m_pIntroduceLab3.backgroundColor = [UIColor blueColor];
    m_pIntroduceLab3.textAlignment = NSTextAlignmentRight;
    [self addSubview:m_pIntroduceLab3];
}

+(NSAttributedString *)setTextString:(NSString *)text
{
    NSMutableAttributedString *mAbStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *npgStyle = [[NSMutableParagraphStyle alloc] init];
    npgStyle.alignment = NSTextAlignmentJustified;
    npgStyle.paragraphSpacing = 11.0;
    npgStyle.paragraphSpacingBefore = 10.0;
    npgStyle.firstLineHeadIndent = 28.0;
    npgStyle.headIndent = 0.0;
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName:[UIColor blackColor],
                          NSFontAttributeName      :[UIFont systemFontOfSize:14.0],
                          NSParagraphStyleAttributeName :npgStyle,
                          NSUnderlineStyleAttributeName :[NSNumber numberWithInteger:NSUnderlineStyleNone]
                          };
    [mAbStr setAttributes:dic range:NSMakeRange(0, mAbStr.length)];
    NSAttributedString *attrString = [mAbStr copy];
    return attrString;
}


+(CGFloat)GetTextHeight:(NSString *)argContent
{
    UILabel *pLab = [[UILabel alloc] initWithFrame:CGRectMake(20*[AppConfigure GetLengthAdaptRate], 0, SCREEN_WIDTH - 40*[AppConfigure GetLengthAdaptRate], 247*[AppConfigure GetLengthAdaptRate])];
    [pLab setAttributedText:[self setTextString:argContent]];

    pLab.numberOfLines = 0;
    pLab.font = [UIFont fontWithName:[AppConfigure RegularFont] size:14.0f];
    pLab.textColor = UIColorFromHex(0x333333);
    pLab.backgroundColor = [UIColor redColor];
    [pLab sizeToFit];
    return  pLab.height;
}
+(CGFloat)GetHeight
{
    CGFloat fContentH1 = [YYYiHeadView GetTextHeight:@"我的职业虽使我老在知识分子的圈子里转，可是我的朋友并不都是教授与学者。打拳的、卖唱的、洋车夫、也是我的朋友。\n与苦人们来往，我并不只和他们坐坐茶馆，偷偷地把他们的动作与谈论用小本儿记下来，我没有做过这样的事，而只是要交朋友。他们帮我的忙，我也帮他们的忙；他们来给我祝寿，我也去给他们贺喜，当他们生娃娃和娶媳妇的时节。这样，我理会了他们的心态，而不是仅仅知道了他们的生活状况。"];
    CGFloat fContentH2 = [YYYiHeadView GetTextHeight:@"——老舍"];
    CGFloat fContentH3 = 16*[AppConfigure GetLengthAdaptRate];
    return 310*[AppConfigure GetLengthAdaptRate]+fContentH1+fContentH2+fContentH3+((17*[AppConfigure GetLengthAdaptRate])*3);
}

@end
