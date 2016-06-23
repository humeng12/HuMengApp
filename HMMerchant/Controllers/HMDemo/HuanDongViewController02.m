//
//  HuanDongViewController02.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

//碰撞

#import "HuanDongViewController02.h"
#import "YXEasing.h"

@interface HuanDongViewController02 ()

@end

@implementation HuanDongViewController02

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     // 创建图片view
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
     imageView.image        = [UIImage imageNamed:@"pic"];
     imageView.contentMode  = UIViewContentModeScaleAspectFill;
     [self.view addSubview:imageView];

     // 创建关键帧动画(移动距离的动画)
     CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
     keyFrameAnimation.keyPath              = @"position";
     keyFrameAnimation.duration             = 2.f;
     keyFrameAnimation.values               = \
     [YXEasing calculateFrameFromPoint:imageView.center
                               toPoint:CGPointMake(320 / 2.f, 320 / 2.f + 240)
                                  func:BounceEaseOut
                            frameCount:2 * 30];

     // 添加动画
     imageView.center = CGPointMake(320 / 2.f, 320 / 2.f + 240);
     [imageView.layer addAnimation:keyFrameAnimation forKey:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
