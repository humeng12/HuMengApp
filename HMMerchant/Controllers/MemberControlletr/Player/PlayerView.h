//
//  PlayerView.h
//  HMMerchant
//
//  Created by HRT on 16/6/7.
//  Copyright © 2016年 HRT. All rights reserved.
//



//在iOS开发中，播放视频通常有两种方式，一种是使用MPMoviePlayerController（需要导入MediaPlayer.Framework），还有一种是使用AVPlayer

//单纯使用AVPlayer类是无法显示视频的，要将视频层添加至AVPlayerLayer中，这样才能将视频显示出来

//由于默认的layer是CALayer，而AVPlayer只能添加至AVPlayerLayer中，所以我们改变一下layerClass，这样PlayerView的默认layer就变了

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView
@property (nonatomic ,strong) AVPlayer *player;
@end
