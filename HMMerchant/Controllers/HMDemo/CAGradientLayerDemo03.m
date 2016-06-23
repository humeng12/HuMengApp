//
//  CAGradientLayerDemo03.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//


//CAGradientLayer 结合透明色与其他颜色实现色差动画



#import "CAGradientLayerDemo03.h"

@interface CAGradientLayerDemo03 ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变层
@property (nonatomic, strong) NSTimer         *timer;         // 定时器
@end

@implementation CAGradientLayerDemo03

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 创建背景图片
     UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
     imageView.center       = self.view.center;
     [self.view addSubview:imageView];


     // 初始化渐变层
     self.gradientLayer       = [CAGradientLayer layer];
     self.gradientLayer.frame = imageView.bounds;
     [imageView.layer addSublayer:self.gradientLayer];


     // 设定颜色渐变方向
     self.gradientLayer.startPoint = CGPointMake(0, 0);
     self.gradientLayer.endPoint   = CGPointMake(0, 1);


     // 设定颜色分割点
     self.gradientLayer.locations = @[@(0.5f), @(1.f)];


     // 初始化定时器
     self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f
                                                   target:self
                                                 selector:@selector(timerEvent)
                                                 userInfo:nil
                                                  repeats:YES];
}


- (void)timerEvent {
     // 设定颜色组动画
     self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                   (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.f
                                                                green:arc4random() % 255 / 255.f
                                                                 blue:arc4random() % 255 / 255.f
                                                                alpha:1].CGColor];

     // 设定颜色分割点动画
     self.gradientLayer.locations = @[@(arc4random() % 10 / 10.f), @(1.f)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
