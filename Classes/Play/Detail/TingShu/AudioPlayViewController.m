//
//  AudioPlayViewController.m
//  AudioPlay
//
//  Created by 张雨 on 2017/2/3.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "AudioPlayViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "AppConfigure.h"

#import "ZYSlider.h"
#import "ZYBookListView.h"

#define black_33 0x333333
#define black_66 0x666666

#define blue_45 0x455cc7  //左侧
#define white_f2 0xff44ff //背景
#define white_ff 0xffffff //缓冲


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface AudioPlayViewController () <ZYSliderDelegate, ZYBookListViewDelegate>
{
    UIImageView *m_pBackgroundImage; //图片毛玻璃背景层
    UIImageView *m_pBookIconImage; //图片
    
    UIButton *m_pPlayBtn; //播放/暂停按钮
    UIButton *m_pPreviousBtn; //上一曲按钮
    UIButton *m_pNextBtn; //下一曲按钮
    UIButton *m_pMenuBtn; //菜单栏
    UIButton *m_pShareBtn; //分享菜单
    
    
    UILabel *m_pBookTitleLabel; //书标题
    UILabel *m_pBookInfoLabel; //书信息
    
    AVPlayer *m_pAVPlayer; //播放器
    BOOL m_bIsPlaying; //播放状态
    NSArray *m_pPlayList;
    
    ZYBookListView *m_pBookMenuView;
    
    BUAFHttpRequest *m_pRequest;
}

//@property (nonatomic, strong) UIProgressView *m_progress;//缓冲进度条.
@property (nonatomic, strong) ZYSlider *m_pProgresSlider; //滑动条

@property (nonatomic, strong) UILabel *m_pCurrentTimeLabel; //当前时间
@property (nonatomic, strong) UILabel *m_pDurationLabel; //总时间


@end

@implementation AudioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    m_bIsPlaying = NO;
    
    NSURL *url1 = [NSURL URLWithString:@"http://www.itinge.com/music/1/201412/2014121010281616093683.mp3"];
    m_pPlayList = @[url1];
    m_pAVPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:url1]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playedidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    [self addBackgroundImage];
//    [self addBackBtn];
    [self addSlider];
    [self addAudioInfoView];
    [self addControlButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tap];
    
    
    __weak AudioPlayViewController *weakVC = self;
    __weak AVPlayer *weakPlayer = m_pAVPlayer;
    
    
    
    
    [m_pAVPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CMTime duration = weakPlayer.currentItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //当前进度时间
        double currentTime = weakPlayer.currentItem.currentTime.value/weakPlayer.currentItem.currentTime.timescale;
        [weakVC.m_pCurrentTimeLabel setText:[weakVC stringWithTime:currentTime]];
        weakVC.m_pProgresSlider.value = currentTime/totalDuration;
//        NSLog(@"----currt time : %f, %f", currentTime, currentTime/totalDuration);

        //更新缓冲
        NSTimeInterval timeInterval = [weakVC availableDuration];
//        NSLog(@"Time Interval:%f", timeInterval);
        [weakVC.m_pDurationLabel setText:[weakVC stringWithTime:timeInterval]];
//        [weakVC.m_progress setProgress:timeInterval/totalDuration animated:YES];
        weakVC.m_pProgresSlider.middleValue = timeInterval/totalDuration;
//        NSLog(@"----progress : %f , %f", timeInterval, totalDuration);
    }];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //进入页面后自动播放
//    [self play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapView:(UITapGestureRecognizer *)tap
{
    [self hiddenBookMenu];
}

-(void)addBackgroundImage
{
    m_pBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
    [self.view addSubview:m_pBackgroundImage];
    [m_pBackgroundImage setBackgroundColor:[UIColor redColor]];
    [m_pBackgroundImage setImage:[UIImage imageNamed:@"我这一辈子"]];
    //模糊效果
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    view.frame = m_pBackgroundImage.bounds;
    [self.view addSubview:view];
    
    //cd
    UIImageView *cdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 112)];
    cdImgView.center = CGPointMake(m_pBackgroundImage.frame.size.width/2+30, m_pBackgroundImage.frame.size.height/2);
    [cdImgView setImage:[UIImage imageNamed:@"cd"]];
    [self.view addSubview:cdImgView];
    //上面的小图片
    UIView *bookIconBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 124, 124)];
    bookIconBackgroundView.backgroundColor =[UIColor whiteColor];
    bookIconBackgroundView.center = CGPointMake(m_pBackgroundImage.frame.size.width/2-30, m_pBackgroundImage.frame.size.height/2);
    [self.view addSubview:bookIconBackgroundView];

    
    m_pBookIconImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114, 114)];
    m_pBookIconImage.center = CGPointMake(bookIconBackgroundView.frame.size.width/2, bookIconBackgroundView.frame.size.height/2);
    [m_pBookIconImage setImage:[UIImage imageNamed:@"我这一辈子"]];
    [m_pBookIconImage setBackgroundColor:[UIColor grayColor]];
    [bookIconBackgroundView addSubview:m_pBookIconImage];
//
    
}

//-(void)addBackBtn
//{
//    m_pBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [m_pBackBtn setFrame:CGRectMake(10, 20, 40, 40)];
//    [m_pBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [m_pBackBtn setBackgroundColor:[UIColor yellowColor]];
//    [self.view addSubview:m_pBackBtn];
//}

-(void)addSlider
{
    self.m_pCurrentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(m_pBackgroundImage.frame)-50, 50, 20)];
    [self.m_pCurrentTimeLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.m_pCurrentTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.m_pCurrentTimeLabel setTextColor:[UIColor whiteColor]];
//    [m_pCurrentTimeLabel setBackgroundColor:[UIColor blackColor]];
    [self.m_pCurrentTimeLabel setText:@"00:00"];
    [self.view addSubview:self.m_pCurrentTimeLabel];
    
    
    self.m_pProgresSlider = [[ZYSlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.m_pCurrentTimeLabel.frame)+5, CGRectGetMinY(self.m_pCurrentTimeLabel.frame), CGRectGetWidth(m_pBackgroundImage.frame)-130, 20)];
//    [m_pProgresSlider setBackgroundColor:[UIColor yellowColor]];
//    [self.m_pProgresSlider setThumbImage:[UIImage imageNamed:@"椭圆 1"] forState:UIControlStateNormal];
//    [self.m_pProgresSlider setMinimumTrackImage:[UIImage imageNamed:@"圆角矩形 2"] forState:UIControlStateNormal];
//    [self.m_pProgresSlider setMaximumTrackImage:[UIImage imageNamed:@"圆角矩形 3"] forState:UIControlStateNormal];
//    [self.m_pProgresSlider setMinimumValue:0];
//    [self.m_pProgresSlider setMaximumValue:200];
    self.m_pProgresSlider.minimumTrackTintColor = UIColorFromRGB(blue_45);
    self.m_pProgresSlider.middleTrackTintColor = UIColorFromRGB(white_ff);
    self.m_pProgresSlider.maximumTrackTintColor = UIColorFromRGB(white_f2);
    self.m_pProgresSlider.value = 0;
    self.m_pProgresSlider.delegate = self;
//    [self.m_pProgresSlider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_pProgresSlider];
    
    
    self.m_pDurationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(m_pBackgroundImage.frame)-60, CGRectGetMinY(self.m_pCurrentTimeLabel.frame), 50, 20)];
    [self.m_pDurationLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.m_pDurationLabel setTextColor:[UIColor whiteColor]];
    [self.m_pDurationLabel setTextAlignment:NSTextAlignmentCenter];
    [self.m_pDurationLabel setText:@"20:32"];
//    [m_pDurationLabel setBackgroundColor:[UIColor blackColor]];

    [self.view addSubview:self.m_pDurationLabel];
    
//    //进度条
//    self.m_progress = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.m_pProgresSlider.frame)+1, CGRectGetMidY(self.m_pProgresSlider.frame)-10, CGRectGetWidth(self.m_pProgresSlider.frame)-2, 10)];
//    [self.m_progress setProgressImage:[UIImage imageNamed:@"形状 1"]];
//    [self.view insertSubview:self.m_progress belowSubview:self.m_pProgresSlider];
}

-(void)addAudioInfoView
{
    m_pBookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pBackgroundImage.frame)+63, CGRectGetWidth(self.view.frame), 18)];
    [m_pBookTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [m_pBookTitleLabel setText:@"我这一辈子 第二章"];
    [m_pBookTitleLabel setFont:[UIFont systemFontOfSize:18.f]];
    [m_pBookTitleLabel setTextColor:UIColorFromRGB(black_33)];
    [m_pBookTitleLabel setTextColor:[UIColor blackColor]];
//    [m_pBookTitleLabel setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:m_pBookTitleLabel];
    
    m_pBookInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pBookTitleLabel.frame)+13, CGRectGetWidth(self.view.frame), 12)];
    [m_pBookInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [m_pBookInfoLabel setText:@"最后更新：2016-09-22"];
    [m_pBookInfoLabel setFont:[UIFont systemFontOfSize:12.f]];
    [m_pBookInfoLabel setTextColor:UIColorFromRGB(black_66)];
    [m_pBookInfoLabel setTextColor:[UIColor blackColor]];
//    [m_pBookInfoLabel setBackgroundColor:[UIColor yellowColor]];

    [self.view addSubview:m_pBookInfoLabel];
    
    
}

-(void)addControlButton
{
    //播放
    m_pPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pPlayBtn setFrame:CGRectMake(0, 0, 50, 50)];
    m_pPlayBtn.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)-66);
    [m_pPlayBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [m_pPlayBtn setImage:[UIImage imageNamed:@"资源 39"] forState:UIControlStateNormal];
//    [m_pPlayBtn setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:m_pPlayBtn];
    
    //上一曲
    
    m_pPreviousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pPreviousBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pPreviousBtn.center = CGPointMake(CGRectGetMidX(m_pPlayBtn.frame)-50-(54/2), CGRectGetMidY(m_pPlayBtn.frame));
    [m_pPreviousBtn addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    [m_pPreviousBtn setImage:[UIImage imageNamed:@"资源 18"] forState:UIControlStateNormal];
    [self.view addSubview:m_pPreviousBtn];
    
    //下一曲
    m_pNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pNextBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pNextBtn.center = CGPointMake(CGRectGetMidX(m_pPlayBtn.frame)+50+(54/2), CGRectGetMidY(m_pPlayBtn.frame));
    [m_pNextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [m_pNextBtn setImage:[UIImage imageNamed:@"默认"] forState:UIControlStateNormal];
    [self.view addSubview:m_pNextBtn];
    
    //菜单栏
    m_pMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pMenuBtn setFrame:CGRectMake(0, 0, 21, 27)];
    m_pMenuBtn.center = CGPointMake(CGRectGetWidth(self.view.frame)- 32, CGRectGetMidY(m_pPlayBtn.frame));
    [m_pMenuBtn addTarget:self action:@selector(showBookMenu:) forControlEvents:UIControlEventTouchUpInside];
    [m_pMenuBtn setImage:[UIImage imageNamed:@"资源 28"] forState:UIControlStateNormal];
    [self.view addSubview:m_pMenuBtn];
}

#pragma mark - action
-(void)previous:(UIButton *)sender
{
    
}

-(void)play:(UIButton *)sender
{
    if (m_bIsPlaying) {
        [m_pAVPlayer pause];
        m_bIsPlaying = NO;
        [m_pPlayBtn setImage:[UIImage imageNamed:@"资源 39"] forState:UIControlStateNormal];

    }
    else {
        m_bIsPlaying = YES;
        [m_pAVPlayer play];
        [m_pPlayBtn setImage:[UIImage imageNamed:@"资源 38"] forState:UIControlStateNormal];
    }
}

-(void)next:(UIButton *)sender
{
    
}

-(void)showBookMenu:(UIButton *)sender
{
    CGFloat h =394*[AppConfigure GetLengthAdaptRate];
    if (!m_pBookMenuView) {
        m_pBookMenuView = [[ZYBookListView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), h)];
        [self.view addSubview:m_pBookMenuView];
    }
    
    m_pBookMenuView.m_bookList = @[@"asdf"];
    
    if (!sender.isSelected) {
        [UIView animateWithDuration:0.5 animations:^{
            [m_pBookMenuView setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-h, CGRectGetWidth(self.view.frame), h)];
        }];
    }
    else {
        [self hiddenBookMenu];
    }
    sender.selected = !sender.isSelected;
}


-(void)hiddenBookMenu
{
    CGFloat h =394*[AppConfigure GetLengthAdaptRate];
    [UIView animateWithDuration:0.5 animations:^{
        [m_pBookMenuView setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), h)];
    }];
    
    m_pMenuBtn.selected = NO;
}

-(NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanages = [[m_pAVPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanages.firstObject CMTimeRangeValue];
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
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
    [self hiddenBookMenu];
}

#pragma mark - notification
-(void)playedidEnd
{
    NSLog(@"----播放完毕");
}

#pragma mark - tool
//时间转换
-(NSString *)stringWithTime:(NSTimeInterval)time {
    
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}


#pragma mark - BUAFHttpRequestDelegate methods
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if ([argRequestTag isEqualToString:@"xunHomePage"])
    {
//        [m_pHomePageView SetXunHomePageData:argData];
        [self HideProgressHUD];
    }
}
- (void)RequestErrorHappened:(BUAFHttpRequest *)argRequest withErrorMsg:(NSString *)argMsg
{
    [self RequestFailed:argRequest];
}

- (void)RequestFailed:(BUAFHttpRequest *)argRequest
{
    [self HideProgressHUD];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
