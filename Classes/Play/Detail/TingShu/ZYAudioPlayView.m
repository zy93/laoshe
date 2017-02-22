//
//  ZYAudioPlayView.m
//  YongYuanDeLaoShe
//
//  Created by 张雨 on 2017/2/18.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "ZYAudioPlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "AppConfigure.h"
#import "ZYSlider.h"
#import "ZYBookListView.h"
#import "YYUtil.h"




@interface ZYAudioPlayView () <ZYSliderDelegate, ZYBookListViewDelegate, UIGestureRecognizerDelegate>
{
    UIImageView *m_pBackgroundImage; //图片毛玻璃背景层
    UIImageView *m_pBookIconImage; //图片

    UIButton *m_pBackBtn;

    UIButton *m_pPlayBtn; //播放/暂停按钮
    UIButton *m_pPreviousBtn; //上一曲按钮
    UIButton *m_pNextBtn; //下一曲按钮
    UIButton *m_pMenuBtn; //菜单栏
    


    UILabel *m_pBookTitleLabel; //书标题
    UILabel *m_pBookInfoLabel; //书信息
    
    ZYBookListView *m_pBookMenuView;
    AVPlayer *m_pAVPlayer; //播放器
    id m_pPlayObserver;
    BOOL m_bIsPlaying; //播放状态
    NSInteger m_iPlayIndex; //当前播放内容记录
    NSArray *m_pChapterList;
}

@property (nonatomic, strong) ZYSlider *m_pProgresSlider; //滑动条
@property (nonatomic, strong) UILabel *m_pCurrentTimeLabel; //当前时间
@property (nonatomic, strong) UILabel *m_pDurationLabel; //总时间

@end


@implementation ZYAudioPlayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self) {
        [self createSubView];
    }
    
    return self;
}

-(void)createSubView
{
    
    m_bIsPlaying = NO;
    [self createBackgroundImage];
    [self createSlider];
    [self createAudioInfoView];
    [self createControlButton];
}



-(void)createBackgroundImage
{
    m_pBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
    m_pBackgroundImage.userInteractionEnabled = YES;
    m_pBackgroundImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:m_pBackgroundImage];
    [m_pBackgroundImage setBackgroundColor:[UIColor redColor]];
    [m_pBackgroundImage setImage:[UIImage imageNamed:@"我这一辈子"]];
    //模糊效果
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    view.frame = m_pBackgroundImage.bounds;
    [self addSubview:view];
    
    //cd
    UIImageView *cdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 112)];
    cdImgView.center = CGPointMake(m_pBackgroundImage.frame.size.width/2+30, m_pBackgroundImage.frame.size.height/2);
    [cdImgView setImage:[UIImage imageNamed:@"cd"]];
    [self addSubview:cdImgView];
    //上面的小图片
    UIView *bookIconBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 124, 124)];
    bookIconBackgroundView.backgroundColor =[UIColor whiteColor];
    bookIconBackgroundView.center = CGPointMake(m_pBackgroundImage.frame.size.width/2-30, m_pBackgroundImage.frame.size.height/2);
    [self addSubview:bookIconBackgroundView];
    
    
    m_pBookIconImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114, 114)];
    m_pBookIconImage.center = CGPointMake(bookIconBackgroundView.frame.size.width/2, bookIconBackgroundView.frame.size.height/2);
    [m_pBookIconImage setImage:[UIImage imageNamed:@"我这一辈子"]];
    [m_pBookIconImage setBackgroundColor:[UIColor grayColor]];
    [bookIconBackgroundView addSubview:m_pBookIconImage];
    //
    
}

-(void)createSlider
{
    self.m_pCurrentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(m_pBackgroundImage.frame)-50, 50, 20)];
    [self.m_pCurrentTimeLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.m_pCurrentTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.m_pCurrentTimeLabel setTextColor:[UIColor whiteColor]];
    //    [m_pCurrentTimeLabel setBackgroundColor:[UIColor blackColor]];
    [self.m_pCurrentTimeLabel setText:@"00:00"];
    [self addSubview:self.m_pCurrentTimeLabel];
    
    
    self.m_pProgresSlider = [[ZYSlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.m_pCurrentTimeLabel.frame)+5, CGRectGetMinY(self.m_pCurrentTimeLabel.frame), CGRectGetWidth(m_pBackgroundImage.frame)-130, 20)];
    self.m_pProgresSlider.minimumTrackTintColor = UIColorFromHex(blue_45);
    self.m_pProgresSlider.middleTrackTintColor = UIColorFromHex(white_ff);
    self.m_pProgresSlider.maximumTrackTintColor = UIColorFromHex(white_f2);
    self.m_pProgresSlider.value = 0;
    self.m_pProgresSlider.delegate = self;
    [self addSubview:self.m_pProgresSlider];
    
    
    self.m_pDurationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(m_pBackgroundImage.frame)-60, CGRectGetMinY(self.m_pCurrentTimeLabel.frame), 50, 20)];
    [self.m_pDurationLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.m_pDurationLabel setTextColor:[UIColor whiteColor]];
    [self.m_pDurationLabel setTextAlignment:NSTextAlignmentCenter];
    [self.m_pDurationLabel setText:@"20:32"];
    //    [m_pDurationLabel setBackgroundColor:[UIColor blackColor]];
    
    [self addSubview:self.m_pDurationLabel];
    
    //    //进度条
    //    self.m_progress = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.m_pProgresSlider.frame)+1, CGRectGetMidY(self.m_pProgresSlider.frame)-10, CGRectGetWidth(self.m_pProgresSlider.frame)-2, 10)];
    //    [self.m_progress setProgressImage:[UIImage imageNamed:@"形状 1"]];
    //    [self insertSubview:self.m_progress belowSubview:self.m_pProgresSlider];
}

-(void)createAudioInfoView
{
    m_pBookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pBackgroundImage.frame)+63, CGRectGetWidth(self.frame), 18)];
    [m_pBookTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [m_pBookTitleLabel setText:@"我这一辈子 第二章"];
    [m_pBookTitleLabel setFont:[UIFont systemFontOfSize:18.f]];
    [m_pBookTitleLabel setTextColor:UIColorFromHex(black_33)];
    [m_pBookTitleLabel setTextColor:[UIColor blackColor]];
    //    [m_pBookTitleLabel setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:m_pBookTitleLabel];
    
    m_pBookInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pBookTitleLabel.frame)+13, CGRectGetWidth(self.frame), 12)];
    [m_pBookInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [m_pBookInfoLabel setText:@"最后更新：2016-09-22"];
    [m_pBookInfoLabel setFont:[UIFont systemFontOfSize:12.f]];
    [m_pBookInfoLabel setTextColor:UIColorFromHex(black_66)];
    [m_pBookInfoLabel setTextColor:[UIColor blackColor]];
    //    [m_pBookInfoLabel setBackgroundColor:[UIColor yellowColor]];
    
    [self addSubview:m_pBookInfoLabel];
    
    
}

-(void)createControlButton
{
    //播放
    m_pPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pPlayBtn setFrame:CGRectMake(0, 0, 50, 50)];
    m_pPlayBtn.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-66);
    [m_pPlayBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [m_pPlayBtn setImage:[UIImage imageNamed:@"play_def"] forState:UIControlStateNormal];
    [m_pPlayBtn setImage:[UIImage imageNamed:@"play_hig"] forState:UIControlStateHighlighted];
    [m_pPlayBtn setImage:[UIImage imageNamed:@"play_dis"] forState:UIControlStateDisabled];
    [m_pPlayBtn setImage:[UIImage imageNamed:@"pause_def"] forState:UIControlStateSelected];
    [self addSubview:m_pPlayBtn];
    
    //上一曲
    
    m_pPreviousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pPreviousBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pPreviousBtn.center = CGPointMake(CGRectGetMidX(m_pPlayBtn.frame)-50-(54/2), CGRectGetMidY(m_pPlayBtn.frame));
    [m_pPreviousBtn addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    [m_pPreviousBtn setImage:[UIImage imageNamed:@"up_def"] forState:UIControlStateNormal];
    [m_pPreviousBtn setImage:[UIImage imageNamed:@"up_hig"] forState:UIControlStateHighlighted];
    [m_pPreviousBtn setImage:[UIImage imageNamed:@"up_dis"] forState:UIControlStateDisabled];

    [self addSubview:m_pPreviousBtn];
    
    //下一曲
    m_pNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pNextBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pNextBtn.center = CGPointMake(CGRectGetMidX(m_pPlayBtn.frame)+50+(54/2), CGRectGetMidY(m_pPlayBtn.frame));
    [m_pNextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [m_pNextBtn setImage:[UIImage imageNamed:@"next_def"] forState:UIControlStateNormal];
    [m_pNextBtn setImage:[UIImage imageNamed:@"next_hig"] forState:UIControlStateHighlighted];
    [m_pNextBtn setImage:[UIImage imageNamed:@"next_dis"] forState:UIControlStateDisabled];

    [self addSubview:m_pNextBtn];
    
    //菜单栏
    m_pMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pMenuBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pMenuBtn.center = CGPointMake(CGRectGetWidth(self.frame)- 32, CGRectGetMidY(m_pPlayBtn.frame));
    [m_pMenuBtn addTarget:self action:@selector(showBookMenu:) forControlEvents:UIControlEventTouchUpInside];
    [m_pMenuBtn setImage:[UIImage imageNamed:@"menu_def"] forState:UIControlStateNormal];
    [m_pMenuBtn setImage:[UIImage imageNamed:@"menu_hig"] forState:UIControlStateHighlighted];
    [self addSubview:m_pMenuBtn];
}

-(void)createAvdioPlayWithChapter:(NSArray *)allChapter
{
    
    if (allChapter.count <=0 || ! allChapter) {
        
        return;
    }
    
    ZYChapter *chapter = allChapter.firstObject;
    [self updateViewWithChapter:chapter];
    
    NSURL *url1 = [NSURL URLWithString:chapter.audioUrl];
    m_iPlayIndex = 0;
    m_pAVPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:url1]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playedidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    
    __weak ZYAudioPlayView *weakView = self;
    __weak AVPlayer *weakPlayer = m_pAVPlayer;
    
    
    m_pPlayObserver = [m_pAVPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CMTime duration = weakPlayer.currentItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //当前进度时间
        double currentTime = weakPlayer.currentItem.currentTime.value/weakPlayer.currentItem.currentTime.timescale;
        [weakView.m_pCurrentTimeLabel setText:[weakView stringWithTime:currentTime]];
        weakView.m_pProgresSlider.value = currentTime/totalDuration;
        //        NSLog(@"----currt time : %f, %f", currentTime, currentTime/totalDuration);
        
        //更新缓冲
        NSTimeInterval timeInterval = [weakView availableDuration];
        //        NSLog(@"Time Interval:%f", timeInterval);
        [weakView.m_pDurationLabel setText:[weakView stringWithTime:timeInterval]];
        //        [weakVC.m_progress setProgress:timeInterval/totalDuration animated:YES];
        weakView.m_pProgresSlider.middleValue = timeInterval/totalDuration;
        //        NSLog(@"----progress : %f , %f", timeInterval, totalDuration);
    }];
    
    [self play:m_pPlayBtn];

}


#pragma mark - action
-(void)clearPlay
{
    [m_pAVPlayer removeTimeObserver:m_pPlayObserver];
}

-(void)previous:(UIButton *)sender
{
    m_iPlayIndex -=1;
    [self playWithIndex];
}

-(void)play:(UIButton *)sender
{
    if (m_bIsPlaying) {
        [m_pAVPlayer pause];
        m_bIsPlaying = NO;
        
    }
    else {
        m_bIsPlaying = YES;
        [m_pAVPlayer play];
    }
    
    sender.selected = !sender.isSelected;
    
}

-(void)next:(UIButton *)sender
{
    m_iPlayIndex +=1;
    [self playWithIndex];
}

-(void)showBookMenu:(UIButton *)sender
{
    CGRect viewFrame = CGRectMake(0, 64, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-64);
    if (!m_pBookMenuView) {
        m_pBookMenuView = [[ZYBookListView alloc] initWithFrame:viewFrame];
        m_pBookMenuView.delegate = self;
        [self addSubview:m_pBookMenuView];
        [m_pBookMenuView showView];
    }
    else {
        [m_pBookMenuView showView];
    }
    m_pBookMenuView.m_bookList = m_pChapterList;
    m_pBookMenuView.playBookIndex = m_iPlayIndex;
}



-(void)playWithIndex
{
    
    ZYChapter *chapter = m_pChapterList[m_iPlayIndex];
    [self updateViewWithChapter:chapter];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:chapter.audioUrl]];
    [m_pAVPlayer replaceCurrentItemWithPlayerItem:item];
    [m_pAVPlayer play];
    [self configNowPlayingCenter];
}



-(void)updateViewWithChapter:(ZYChapter *)chapter
{
    
    //加载图片
    __weak UIImageView *pBookImag = m_pBookIconImage;
    __weak UIImageView *pBGImag = m_pBackgroundImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:chapter.cover];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [pBookImag setImage:image];
            [pBGImag setImage:image];
        });
    });
    
    //缓冲条，从0开始
    _m_pProgresSlider.middleValue = 0;
    
    [m_pBookTitleLabel setText:[NSString stringWithFormat:@"%@ %@",chapter.title,chapter.chapter]];
    [m_pBookInfoLabel setText:[NSString stringWithFormat:@"最后更新时间:%@",[YYUtil timeWithTimeIntervalString:chapter.updateTime]]];
    [_m_pCurrentTimeLabel setText:@"00:00"];
    [_m_pDurationLabel setText:chapter.time];
    
    [self updateControlerStatus];
    
}

-(void)updateControlerStatus
{
    if (m_iPlayIndex == 0) {
        m_pPreviousBtn.enabled = NO;
    }
    else {
        m_pPreviousBtn.enabled = YES;
    }
    
    if (m_iPlayIndex == m_pChapterList.count-1) {
        m_pNextBtn.enabled = NO;
    }
    else {
        m_pNextBtn.enabled = YES;
    }
}

-(NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanages = [[m_pAVPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanages.firstObject CMTimeRangeValue];
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
}

- (void)configNowPlayingCenter {
//    BASE_INFO_FUN(@"配置NowPlayingCenter");
    NSMutableDictionary * info = [NSMutableDictionary dictionary];
    //音乐的标题
    [info setObject:m_pBookTitleLabel.text forKey:MPMediaItemPropertyTitle];
    //音乐的艺术家
    [info setObject:@"永远的老舍" forKey:MPMediaItemPropertyArtist];
    //音乐的播放时间
    double currentTime = m_pAVPlayer.currentItem.currentTime.value/m_pAVPlayer.currentItem.currentTime.timescale;

    [info setObject:@(currentTime) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    //音乐的播放速度
    [info setObject:@(1) forKey:MPNowPlayingInfoPropertyPlaybackRate];
    //音乐的总时间
    NSTimeInterval tim = [self availableDuration];
    [info setObject:@(tim) forKey:MPMediaItemPropertyPlaybackDuration];
    //音乐的封面
    MPMediaItemArtwork * artwork = [[MPMediaItemArtwork alloc] initWithImage:m_pBookIconImage.image];
    [info setObject:artwork forKey:MPMediaItemPropertyArtwork];
    //完成设置
    [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:info];
}

#pragma mark - Gesture delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch class]) isEqualToString:@"ZYBookListViewCell"]) {
        return NO;
    }
    return YES;
}

#pragma mark - ZYSlider delegate
-(void)slider:(CGFloat)value
{
    NSLog(@"---------__%f", value);
    CMTime duration = m_pAVPlayer.currentItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    float time = value * totalDuration;
    //快进
    [m_pAVPlayer seekToTime:CMTimeMake(time, 1) completionHandler:^(BOOL finished) {
        NSLog(@"++++++++");
    }];
}

#pragma mark - ZYBookListView delegate
-(void)selectBookIndex:(NSInteger)index
{
    //切换播放
    if (m_iPlayIndex == index) {
        return;
    }
    m_iPlayIndex = index;
    [self playWithIndex];
}

#pragma mark - notification
-(void)playedidEnd
{
    NSLog(@"----播放完毕");
    m_bIsPlaying = NO;
}

#pragma mark - tool
//时间转换
-(NSString *)stringWithTime:(NSTimeInterval)time {
    
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}



#pragma mark - Set data
-(void)SetBookData:(NSArray *)argData
{
    ZYListenBookData *pData = argData.firstObject;
    NSLog(@"***************%@",pData);

    //自动播放第一章，
//    NSString *allChapter = argData.allChapter;
    m_pChapterList = [NSArray arrayWithArray:pData.allChapter];
    [self createAvdioPlayWithChapter:pData.allChapter];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
