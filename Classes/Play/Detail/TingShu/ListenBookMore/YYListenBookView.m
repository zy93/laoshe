//
//  YYListenBookView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/21.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYListenBookView.h"

#import "CardLayout.h"
#import "CardSelectedLayout.h"
#import "CardCellCollectionViewCell.h"
#import "YYDonationData.h"
#import "UIImageView+AFNetworking.h"
#import "YYListenBookViewController.h"
#import "STTimeUtility.h"
#import "YYUtil.h"

static CGFloat collectionHeight;


@interface YYListenBookView()<UICollectionViewDelegate,UICollectionViewDataSource,CardLayoutDelegate>
{
    NSArray *m_pData;
}

@property(nonatomic, strong)UIImageView *m_pBGImageView;

@property(nonatomic, strong)UICollectionView* cardCollectionView;
@property(nonatomic, strong)UICollectionViewLayout* cardLayout;
@property(nonatomic, strong)UICollectionViewLayout* cardLayoutStyle1;
@property(nonatomic, strong)UICollectionViewLayout* cardLayoutStyle2;
@property(nonatomic, strong)UITapGestureRecognizer* tapGesCollectionView;

@end

@implementation YYListenBookView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

-(void)createSubview
{
    [self createBGImgView];
    collectionHeight = self.frame.size.height;
    
    self.cardLayoutStyle1 =  [[CardLayout alloc]initWithOffsetY:400];
    self.cardLayout = self.cardLayoutStyle1;
    ((CardLayout*)self.cardLayoutStyle1).delegate = self;
    [self addSubview:self.cardCollectionView];
}

-(void)createBGImgView
{
    _m_pBGImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_m_pBGImageView];
    //模糊效果
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    view.frame = _m_pBGImageView.bounds;
    [self addSubview:view];
}

-(void)setData:(NSArray *)data
{
//    m_pData = data;
    m_pData =[[NSArray alloc] initWithObjects:data.firstObject,data.firstObject,data.firstObject,data.firstObject,data.firstObject,data.firstObject,data.firstObject,data.firstObject, nil];
    YYDonationData *pData = data.firstObject;
    [self.m_pBGImageView setImageWithURL:[NSURL URLWithString:pData.cover]];
    [_cardCollectionView reloadData];
}

-(void)updateBlur
{
    if ([self.cardLayout isKindOfClass:[CardLayout class]]) {
        for (NSInteger row = 0; row < [self.cardCollectionView numberOfItemsInSection:0]; row++) {
            CardCellCollectionViewCell* cell = (CardCellCollectionViewCell*)[self.cardCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            CGFloat blur = ((NSNumber*)[((CardLayout*)self.cardLayout).blurList objectAtIndex:row]).floatValue;
            [cell setBlur:blur];
        }
    }
    else
    {
        for (NSInteger row = 0; row < [self.cardCollectionView numberOfItemsInSection:0]; row++) {
            CardCellCollectionViewCell* cell = (CardCellCollectionViewCell*)[self.cardCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            [cell setBlur:0];
        }
    }
}

-(void)updateBlur:(CGFloat) blur ForRow:(NSInteger)row
{
    if (![self.cardLayout isKindOfClass:[CardLayout class]]) {
        return;
    }
    CardCellCollectionViewCell* cell = (CardCellCollectionViewCell*)[self.cardCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    [cell setBlur:blur];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return m_pData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCellCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
    YYDonationData *data = m_pData[indexPath.row];
    cell.bgColor = [UIColor whiteColor];
    cell.title = data.title;
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    cell.subtitle = [NSString stringWithFormat:@"最后更新时间:%@",[YYUtil timeWithTimeInterval:a]];//[STTimeUtility GetTimeString:1487777961*1000];

    NSLog(@"------------------timeString:%@",timeString);
    [cell.imageView setImageWithURL:[NSURL URLWithString:data.cover]];
    return cell;
}

-(UIColor*)getGameColor:(NSInteger)index
{
    NSArray* colorList = @[UIColorFromHex(0xfb742a),UIColorFromHex(0xfcc42d),UIColorFromHex(0x29c26d),UIColorFromHex(0xfaa20a),UIColorFromHex(0x5e64d9),UIColorFromHex(0x6d7482),UIColorFromHex(0x54b1ff),UIColorFromHex(0xe2c179),UIColorFromHex(0x9973e5),UIColorFromHex(0x61d4ff)];
    UIColor* color = [colorList objectAtIndex:(index%10)];
    return color;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYDonationData *data = m_pData[indexPath.row];
    [(YYListenBookViewController *)[self GetSubordinateControllerForSelf] ClickCheckBookWithId:data.mid];
    
//    CGFloat offsetY = self.cardCollectionView.contentOffset.y;
//    if ([self.cardLayout isKindOfClass:[CardLayout class]]) {
//        if (!self.cardLayoutStyle2) {
//            self.cardLayoutStyle2 =  [[CardSelectedLayout alloc]initWithIndexPath:indexPath offsetY:offsetY ContentSizeHeight:((CardLayout*)self.cardLayout).contentSizeHeight];
//            self.cardLayout = self.cardLayoutStyle2;
//        }
//        else
//        {
//            ((CardSelectedLayout*)self.cardLayoutStyle2).contentOffsetY = offsetY;
//            ((CardSelectedLayout*)self.cardLayoutStyle2).contentSizeHeight = ((CardLayout*)self.cardLayout).contentSizeHeight;
//            ((CardSelectedLayout*)self.cardLayoutStyle2).selectedIndexPath = indexPath;
//            self.cardLayout = self.cardLayoutStyle2;
//        }
//        self.cardCollectionView.scrollEnabled = NO;
//        [self showMaskView]; //显示背景浮层
//        //选中的卡片不显示蒙层
//        [((CardCellCollectionViewCell*)[self.cardCollectionView cellForItemAtIndexPath:indexPath]) setBlur:0];
//    }
//    else
//    {
//        if (!self.cardLayoutStyle1) {
//            self.cardLayoutStyle1 =  [[CardLayout alloc]initWithOffsetY:offsetY];
//            self.cardLayout = self.cardLayoutStyle1;
//            ((CardLayout*)self.cardLayoutStyle1).delegate = self;
//        }
//        else
//        {
//            ((CardLayout*)self.cardLayoutStyle1).offsetY = offsetY;
//            self.cardLayout = self.cardLayoutStyle1;
//            ((CardLayout*)self.cardLayoutStyle1).delegate = self;
//        }
//        self.cardCollectionView.scrollEnabled = YES;
//        [self hideMaskView];
//    }
//    [self.cardCollectionView setCollectionViewLayout:self.cardLayout animated:YES];
}
-(void)showMaskView
{
    //    CATransform3DMakeTranslation(0, 0, -10);
    //    self.maskView.hidden = NO;
    self.cardCollectionView.backgroundColor = UIColorFromHex(0x161821);
    //    self.closeIconView.hidden = NO;
    [self.cardCollectionView addGestureRecognizer:self.tapGesCollectionView];
}
-(void)hideMaskView
{
    //    self.maskView.hidden = YES;
    self.cardCollectionView.backgroundColor = UIColorFromHex(0x2D3142);
    //    self.closeIconView.hidden = YES;
    [self.cardCollectionView removeGestureRecognizer:self.tapGesCollectionView];
}

-(void)tapOnBackGround
{
    CGFloat offsetY = self.cardCollectionView.contentOffset.y;
    if ([self.cardLayout isKindOfClass:[CardLayout class]]) {
        
    }
    else
        
    {
        if (!self.cardLayoutStyle1) {
            self.cardLayoutStyle1 =  [[CardLayout alloc]initWithOffsetY:offsetY];
            self.cardLayout = self.cardLayoutStyle1;
            ((CardLayout*)self.cardLayoutStyle1).delegate = self;
        }
        else
        {
            ((CardLayout*)self.cardLayoutStyle1).offsetY = offsetY;
            self.cardLayout = self.cardLayoutStyle1;
        }
        self.cardCollectionView.scrollEnabled = YES;
        [self.cardCollectionView removeGestureRecognizer:self.tapGesCollectionView];
    }
    [self.cardCollectionView setCollectionViewLayout:self.cardLayout animated:YES];
    [self updateBlur];
}

-(UITapGestureRecognizer*)tapGesCollectionView
{
    if (!_tapGesCollectionView) {
        _tapGesCollectionView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnBackGround)];
    }
    return _tapGesCollectionView;
}

-(UICollectionView*)cardCollectionView
{
    if (!_cardCollectionView) {
        _cardCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, collectionHeight) collectionViewLayout:self.cardLayout];
        [_cardCollectionView registerClass:[CardCellCollectionViewCell class] forCellWithReuseIdentifier:@"cardCell"];
        _cardCollectionView.delegate = self;
        _cardCollectionView.dataSource = self;
        [_cardCollectionView setContentOffset:CGPointMake(0, 400)];
        _cardCollectionView.backgroundColor = [UIColor clearColor];//UIColorFromHex(0x2D3142);
    }
    return _cardCollectionView;
}

@end
