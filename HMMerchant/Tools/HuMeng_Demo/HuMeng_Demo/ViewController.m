//
//  ViewController.m
//  HuMeng_Demo
//
//  Created by HRT on 16/6/27.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property(nonatomic,strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
     [super viewDidLoad];


     NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];

     AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];

     _player = [AVPlayer playerWithPlayerItem:item];

     AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
     layer.frame = CGRectMake(50, 50,200, 200);

     [self.view.layer addSublayer:layer];


}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

@end
