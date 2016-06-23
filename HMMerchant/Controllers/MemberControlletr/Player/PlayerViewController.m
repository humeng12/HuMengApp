//
//  PlayerViewController.m
//  HMMerchant
//
//  Created by HRT on 16/6/7.
//  Copyright © 2016年 HRT. All rights reserved.
//


//先将在线视频链接存放在videoUrl中，然后初始化playerItem，playerItem是管理资源的对象

/*
然后监听playerItem的status和loadedTimeRange属性，status有三种状态：

AVPlayerStatusUnknown,

AVPlayerStatusReadyToPlay,

AVPlayerStatusFailed

当status等于AVPlayerStatusReadyToPlay时代表视频已经可以播放了，我们就可以调用play方法播放了。

loadedTimeRange属性代表已经缓冲的进度，监听此属性可以在UI中更新缓冲进度，也是很有用的一个属性。

最后添加一个通知，用于监听视频是否已经播放完毕，然后实现KVO的方法
 */


#import "PlayerViewController.h"
#import "PlayerView.h"

@interface PlayerViewController ()
{
     BOOL _played;
     NSDateFormatter *_dateFormatter;
}

@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) PlayerView *playerView;
@property (nonatomic ,strong) UIButton *stateButton;

@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) UIProgressView *videoProgress;

@property (nonatomic ,strong) NSString *_totalTime;
@end

@implementation PlayerViewController


-(PlayerView *)playerView
{
     if(_playerView == nil)
     {
          self.playerView = [[PlayerView alloc] initWithFrame:CGRectMake(10,74,screenWidth-20,200)];
     }
     return _playerView;
}


- (void)viewDidLoad {
     [super viewDidLoad];

     self.view.backgroundColor = [UIColor whiteColor];

      NSURL *videoUrl = [NSURL URLWithString:@"http://flv2.bn.netease.com/tvmrepo/2016/6/2/I/EBNVGJV2I/SD/EBNVGJV2I-mobile.mp4"];

     self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];

     [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
     [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性

     self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
     self.playerView.player = _player;
     [self.view addSubview:self.playerView];


     self.stateButton = [[UIButton alloc] initWithFrame:CGRectMake(10,self.playerView.bottom+10,30,20)];
     self.stateButton.titleLabel.font = [UIFont systemFontOfSize:14];
     [self.stateButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     [self.stateButton setTitle:@"play" forState:UIControlStateNormal];
     [self.stateButton addTarget:self action:@selector(stateButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.stateButton];
     self.stateButton.enabled = NO;


     self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-70,self.playerView.bottom+10,60,20)];
     self.timeLabel.font = [UIFont systemFontOfSize:8];
     [self.view addSubview:self.timeLabel];


     self.videoSlider =[[UISlider alloc] initWithFrame:CGRectMake(50,self.playerView.bottom+5,150,20)];
     [self.videoSlider addTarget:self action:@selector(videoSlierChangeValue:) forControlEvents:UIControlEventValueChanged];
     [self.view addSubview:self.videoSlider];

     self.videoProgress =[[UIProgressView alloc] initWithFrame:CGRectMake(50,self.playerView.bottom+10,150,20)];
     [self.view addSubview:self.videoProgress];


     // 添加视频播放结束通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
}



// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
     AVPlayerItem *playerItem = (AVPlayerItem *)object;
     if ([keyPath isEqualToString:@"status"]) {
          if ([playerItem status] == AVPlayerStatusReadyToPlay) {
               NSLog(@"AVPlayerStatusReadyToPlay");
               self.stateButton.enabled = YES;
               CMTime duration = self.playerItem.duration;// 获取视频总长度
               CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
               self._totalTime = [self convertTime:totalSecond];// 转换成播放时间
               [self customVideoSlider:duration];// 自定义UISlider外观
               NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
               [self monitoringPlayback:self.playerItem];// 监听播放状态
          } else if ([playerItem status] == AVPlayerStatusFailed) {
               NSLog(@"AVPlayerStatusFailed");
          }
     } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
          NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
          NSLog(@"Time Interval:%f",timeInterval);
          CMTime duration = _playerItem.duration;
          CGFloat totalDuration = CMTimeGetSeconds(duration);
          [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
     }
}


- (void)monitoringPlayback:(AVPlayerItem *)playerItem {

     __weak typeof(self) weakSelf = self;
     self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
          CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
          [weakSelf.videoSlider setValue:currentSecond animated:YES];
          NSString *timeString = [weakSelf convertTime:currentSecond];
          weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,weakSelf._totalTime];
     }];
}


- (NSTimeInterval)availableDuration {
     NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
     CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
     float startSeconds = CMTimeGetSeconds(timeRange.start);
     float durationSeconds = CMTimeGetSeconds(timeRange.duration);
     NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
     return result;
}

- (void)customVideoSlider:(CMTime)duration {
     self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
     UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
     UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();

     [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
     [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}


- (void)stateButtonTouched:(id)sender {
     if (!_played) {
          [self.playerView.player play];
          self.stateButton.titleLabel.font = [UIFont systemFontOfSize:14];
          [self.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
     } else {
          [self.playerView.player pause];
          [self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
     }
     _played = !_played;
}

- (void)videoSlierChangeValue:(id)sender {
     UISlider *slider = (UISlider *)sender;
     NSLog(@"value change:%f",slider.value);

     if (slider.value == 0.000000) {
          __weak typeof(self) weakSelf = self;
          [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
               [weakSelf.playerView.player play];
          }];
     }
}

- (void)videoSlierChangeValueEnd:(id)sender {
     UISlider *slider = (UISlider *)sender;
     NSLog(@"value end:%f",slider.value);
     CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);

     __weak typeof(self) weakSelf = self;
     [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
          [weakSelf.playerView.player play];
          [weakSelf.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
     }];
}

- (void)updateVideoSlider:(CGFloat)currentSecond {
     [self.videoSlider setValue:currentSecond animated:YES];
}


- (void)moviePlayDidEnd:(NSNotification *)notification {
     NSLog(@"Play end");

     __weak typeof(self) weakSelf = self;
     [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
          [weakSelf.videoSlider setValue:0.0 animated:YES];
          [weakSelf.stateButton setTitle:@"Play" forState:UIControlStateNormal];
     }];
}

- (NSString *)convertTime:(CGFloat)second{
     NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
     if (second/3600 >= 1) {
          [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
     } else {
          [[self dateFormatter] setDateFormat:@"mm:ss"];
     }
     NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
     return showtimeNew;
}

- (NSDateFormatter *)dateFormatter {
     if (!_dateFormatter) {
          _dateFormatter = [[NSDateFormatter alloc] init];
     }
     return _dateFormatter;
}

- (void)dealloc {
     [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
     [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
     [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
