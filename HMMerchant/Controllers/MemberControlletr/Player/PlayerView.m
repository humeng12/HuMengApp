//
//  PlayerView.m
//  HMMerchant
//
//  Created by HRT on 16/6/7.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

+ (Class)layerClass
{
     return [AVPlayerLayer class];
}

- (AVPlayer *)player
{
     return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player
{
     [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
