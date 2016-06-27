//
//  MediaPlayer.m
//  HMMerchant
//
//  Created by HRT on 16/6/27.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MediaPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MediaPlayerMaskView.h"

@interface MediaPlayer()

@property(nonatomic,assign)CGRect smallFrame;
@property(nonatomic,assign)CGRect bigFrame;

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItme;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@property(nonatomic,strong)MediaPlayerMaskView *maskView1;
@end

@implementation MediaPlayer

-(instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
     if (self) {

          self.smallFrame = frame;
          self.bigFrame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
          [self addSomeUI];
     }

     return self;
}


-(void)addSomeUI{

     self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@""]];
     self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];


     //控制内容的填充方式 //代优化
     if([self.playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]){
          self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
     }else{
          self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
     }


     [self.layer insertSublayer:self.playerLayer atIndex:0];

     self.maskView1 = [[MediaPlayerMaskView alloc]initWithFrame:CGRectMake(0, 0, self.smallFrame.size.width, self.smallFrame.size.height)];
     [self addSubview:self.maskView1];
}


@end
