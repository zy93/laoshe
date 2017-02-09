//
//  JJBirthdayRemindView.m
//  pbuJaaaJa
//
//  Created by  on 16/2/4.
//  Copyright © 2016年 . All rights reserved.
//

#import "AFTitleBannerView.h"
#import "AFTitleBannerCell.h"

#define REMIND_CELL @"TitleBanner"
#define MAXSECTION 2

@implementation AFTitleBannerView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [self Addsubviews];
    }
    return self;
}

- (void)Addsubviews
{
    UICollectionViewFlowLayout *pFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    pFlowLayout.itemSize = CGSizeMake(self.width, self.height);
    pFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    pFlowLayout.minimumLineSpacing = 0*[AppConfigure GetLengthAdaptRate];
    pFlowLayout.minimumInteritemSpacing = 0*[AppConfigure GetLengthAdaptRate];
    pFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    m_pBannerView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:pFlowLayout];
    [m_pBannerView registerClass:[AFTitleBannerCell class] forCellWithReuseIdentifier:REMIND_CELL];
    m_pBannerView.backgroundColor = [UIColor clearColor];
    m_pBannerView.pagingEnabled = YES;
    m_pBannerView.delegate = self;
    m_pBannerView.dataSource = self;
    m_pBannerView.scrollEnabled = NO;
    [self addSubview:m_pBannerView];
}

-(void)SetData:(NSArray*)arrData andTitle:(NSArray *)argTitle
{
    if (argTitle.count != arrData.count || arrData == nil || argTitle == nil || argTitle.count == 0 || arrData.count == 0)
    {
        return;
    }
    m_arrData = arrData;
    m_arrTitle = argTitle;
    [m_pBannerView reloadData];
    if (m_arrTitle.count > 1)
    {
        [self AddTimer];
    }
}

- (void)dealloc
{
    [m_pTimer invalidate];
    m_pTimer = nil;
}

//添加一个定时器
- (void)AddTimer
{
    if (m_pTimer == nil)
    {
        m_pTimer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(NextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:m_pTimer forMode:NSRunLoopCommonModes];
    }
}

//定时器事件   跳转到下一项
- (void)NextPage
{
    NSIndexPath *nextIndextPath = [self ResetIndexPath];
    NSInteger nextItem = nextIndextPath.item + 1;
    NSInteger nextSection = nextIndextPath.section;
    if (nextItem == m_arrTitle.count)
    {
        nextItem = 0;
        ++ nextSection;
    }
    [m_pBannerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem    inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

//重新设置项
- (NSIndexPath *)ResetIndexPath
{
    NSInteger iItem = roundf(m_pBannerView.contentOffset.y / self.height);
    NSInteger iCurrentItem = iItem % m_arrTitle.count;
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:iCurrentItem inSection:0];
    [m_pBannerView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    return currentIndexPathReset;
}


#pragma mark -- UICollectionViewDatasource
//段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MAXSECTION;
}
//项数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return m_arrTitle.count;
}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AFTitleBannerCell *pCell = [collectionView dequeueReusableCellWithReuseIdentifier:REMIND_CELL forIndexPath:indexPath];
    [pCell ClearData];
    [pCell SetTitleData:m_arrTitle[indexPath.item]];
    return pCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.propDel && [self.propDel respondsToSelector:@selector(CheckDetailInfo:)])
    {
        [self.propDel CheckDetailInfo:m_arrData[indexPath.item]];
    }
}

@end
