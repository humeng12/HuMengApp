//
//  HuanDongViewController03.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

//衰减的动画效果

#import "HuanDongViewController03.h"
#import "YXEasing.h"

@interface HuanDongViewController03 ()

@end

@implementation HuanDongViewController03

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     // 背景变暗的view
     UIView *backView         = [[UIView alloc] initWithFrame:self.view.bounds];
     backView.backgroundColor = [UIColor blackColor];
     backView.alpha           = 0;
     [UIView animateWithDuration:1.f animations:^{
          backView.alpha       = 0.3;
     }];
     [self.view addSubview:backView];


     // 创建模拟的菜单
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64, 0, 320, screenHeight)];
     imageView.image        = [UIImage imageNamed:@"pic 2.PNG"];
     [self.view addSubview:imageView];


     // 创建关键帧动画
     CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
     keyFrameAnimation.keyPath              = @"position";
     keyFrameAnimation.duration             = 1.f;
     keyFrameAnimation.values               = \
     [YXEasing calculateFrameFromPoint:imageView.center
                               toPoint:CGPointMake(self.view.center.x + 100, self.view.center.y)
                                  func:CubicEaseOut
                            frameCount:1 * 30];

     // 加载关键帧动画
     imageView.center = CGPointMake(self.view.center.x + 100, self.view.center.y);
     [imageView.layer addAnimation:keyFrameAnimation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
