//
//  CheShiViewController.m
//  HMMerchant
//
//  Created by HRT on 16/6/28.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CheShiViewController.h"
#import "MediaPlayer.h"

@interface CheShiViewController ()
@property(nonatomic,retain)MediaPlayer *player;
@end

@implementation CheShiViewController

- (void)viewDidLoad {
     [super viewDidLoad];

     [self addLeftButton];

     _player = [[MediaPlayer alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
     _player.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1455782903700jy.mp4"];
     [self.view addSubview:_player];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
     if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
          self.view.backgroundColor = [UIColor whiteColor];
     }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
          self.view.backgroundColor = [UIColor blackColor];
     }
}


// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate{

     return YES;
}

// viewcontroller支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{

     // MoviePlayerViewController这个页面支持转屏方向
     return UIInterfaceOrientationMaskAllButUpsideDown;

}


-(void)dealloc
{
     NSLog(@"%s",__func__);
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
