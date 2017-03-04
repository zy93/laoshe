//
//  YYOtherTableCell.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/23.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYOtherTableCell.h"

@interface YYOtherTableCell()
{
    UILabel *m_pTitlelab;
    UILabel *m_pSubitlelab;
}

@end

@implementation YYOtherTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)createSubview
{
    m_pTitlelab = [[UILabel alloc] initWithFrame:CGRectZero];
    m_pTitlelab.font = [UIFont systemFontOfSize:18.f];
    [self addSubview:m_pTitlelab];
    
    m_pSubitlelab = [[UILabel alloc] initWithFrame:CGRectZero];
    m_pSubitlelab.numberOfLines = 0;
    m_pSubitlelab.font = [UIFont systemFontOfSize:14.f];
//    m_pSubitlelab.backgroundColor = [UIColor redColor];
    [self addSubview:m_pSubitlelab];
}

-(void)setM_pTitle:(NSString *)m_pTitle
{
    _m_pTitle = m_pTitle;
    [m_pTitlelab setText:m_pTitle];

    [self setNeedsLayout];
}

-(NSAttributedString *)setTextString:(NSString *)text
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

-(void)setM_pSubtitle:(NSString *)m_pSubtitle
{
    _m_pSubtitle = m_pSubtitle;
    if (m_pSubtitle != nil || [m_pSubtitle isEqualToString:@""])
    {
        [m_pSubitlelab setAttributedText:[self setTextString:m_pSubtitle]];
    }

    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [m_pTitlelab setFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 18)];
    [m_pSubitlelab setFrame:CGRectMake(20, 38, SCREEN_WIDTH-40, CGRectGetHeight(self.frame)-48)];
}


@end
