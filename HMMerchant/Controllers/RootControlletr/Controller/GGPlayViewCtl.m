//
//  GGPlayViewCtl.m
//  HMMerchant
//
//  Created by HRT on 16/6/7.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "GGPlayViewCtl.h"
#import "GGPlayView.h"
#import "GGVerticalNav.h"
#import "GGTransverseNaV.h"

@interface GGPlayViewCtl ()<GGVerticalNavDelegate,GGTransverseNaVDelegate>
{
     NSString *_vid;
     CATransform3D myTransform;
     GGVerticalNav *_verticalNav;
     GGTransverseNaV *_transverseNaV;
}
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) GGPlayView *playerView;
@property (nonatomic ,strong)AVPlayer *player;
@end

@implementation GGPlayViewCtl

- (instancetype)initWithVideoId:(NSString *)vid
{
     self = [super init];
     if (!self)  return nil;
     _vid=vid;
     return self;
}

- (void)viewDidLoad {
     [super viewDidLoad];
     self.navigationController.navigationBarHidden = YES;

     [self createBasicConfig];
     [self createVerticalNav];
     [self createTransverseNaV];
     [self playVideo];
}


-(void)createBasicConfig
{
     _playerView=[[GGPlayView alloc]initWithFrame:CGRectMake(0, 20, screenWidth, screenWidth*9/16)];
     myTransform = _playerView.layer.transform;
     [self.view addSubview:_playerView];
}

#pragma mark -竖屏nav
-(void)createVerticalNav
{
     _verticalNav = [[GGVerticalNav alloc]initWithFrame:CGRectMake(0, 20, screenWidth, screenWidth*9/16)];
     _verticalNav.delegate = self;
     [self.view addSubview:_verticalNav];
}

#pragma mark -GGVerticalNavDelegate
-(void)didWillVerticalNavOnclick:(NSInteger)tag
{
     if (tag == 101) {//返回
          [self.navigationController popToRootViewControllerAnimated:YES];
          self.navigationController.navigationBarHidden = NO;
     }else if (tag == 102){//进入全屏
          [[UIApplication sharedApplication] setStatusBarHidden:YES];
          _playerView.frame = CGRectMake(0, 0, screenHeight,screenWidth);
          _verticalNav.hidden = YES;
          [UIView animateWithDuration:0.3 animations:^{
               CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
               _playerView.layer.transform  =  transform;
               _playerView.center = self.view.center;
               _transverseNaV.alpha=0;

          } completion:^(BOOL finished) {
               _playerView.center = self.view.center;

               _transverseNaV.alpha=1;
               _transverseNaV.hidden=NO;
          }];
          
     }
}

#pragma mark -横屏nav
-(void)createTransverseNaV
{
     _transverseNaV  = [[GGTransverseNaV alloc]initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
     _transverseNaV.delegate = self;
     [self.view addSubview:_transverseNaV];
     CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
     _transverseNaV.layer.transform = transform;
     _transverseNaV.center  = self.view.center;
     _transverseNaV.hidden=YES;
}


#pragma mark -GGTransverseNaVDelegate
-(void)TransverseNaVWillDidOnclick:(NSInteger)tag
{
     if (tag== 201) {//退出全屏
          _playerView.frame = CGRectMake(0, 20, screenWidth*9/16, screenWidth);
          _transverseNaV.hidden=YES;
          [UIView animateWithDuration:0.3 animations:^{
               _playerView.layer.transform  =myTransform  ;
               _verticalNav.alpha = 0;
               _playerView.center  = CGPointMake(screenWidth/2, 20+screenWidth*9/32);
          } completion:^(BOOL finished) {
               _playerView.center = self.view.center;
               _verticalNav.alpha =1;
               _verticalNav.hidden=NO;
               _playerView.center  = CGPointMake(screenWidth/2, 20+screenWidth*9/32);
               [[UIApplication sharedApplication] setStatusBarHidden:NO];

          }];
     }
}


-(void)playVideo
{
     NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"http://hls.quanmin.tv/live/%@/playlist.m3u8",_vid] ];
     CLogI(@"%@",_vid);
     NSString *str = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSURL *videoUrl = [NSURL URLWithString: str ];

     self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
     self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
     self.playerView.player = _player;
     [self.playerView.player play];
}

- (void)dealloc
{
     CLogI(@"释放");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
