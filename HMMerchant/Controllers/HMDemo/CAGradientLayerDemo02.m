//
//  CAGradientLayerDemo02.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAGradientLayerDemo02.h"

@interface CAGradientLayerDemo02 ()
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation CAGradientLayerDemo02

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 创建并初始化
     self.gradientLayer             = [CAGradientLayer layer];
     self.gradientLayer.frame       = CGRectMake(0, 0, 200, 200);
     self.gradientLayer.position    = self.view.center;
     self.gradientLayer.borderWidth = 1.f;
     [self.view.layer addSublayer:self.gradientLayer];

     // 设置颜色
     self.gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                   (__bridge id)[UIColor greenColor].CGColor,
                                   (__bridge id)[UIColor blueColor].CGColor];


     // 设置颜色渐变方向
     self.gradientLayer.startPoint = CGPointMake(0, 0);
     self.gradientLayer.endPoint   = CGPointMake(1, 0);


     // 设置颜色分割点
     self.gradientLayer.locations  = @[@(0.25), @(0.5), @(0.75)];


     // 延时3秒钟执行
     [self performSelector:@selector(gradientLayerLocationAnimation)
                withObject:nil
                afterDelay:3.f];
}


- (void)gradientLayerLocationAnimation {
     // 颜色分割点效果
     self.gradientLayer.locations = @[@(0.01), @(0.5), @(0.99)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
