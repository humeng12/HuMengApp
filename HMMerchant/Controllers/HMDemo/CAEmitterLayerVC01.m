//
//  CAEmitterLayerVC01.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//


//CAEmitterLayer 产生粒子效果


#import "CAEmitterLayerVC01.h"

@interface CAEmitterLayerVC01 ()

@end

@implementation CAEmitterLayerVC01

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 创建出Layer
     CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];

     // 显示边框
     emitterLayer.borderWidth = 1.f;

     // 给定尺寸
     emitterLayer.frame = CGRectMake(100, 100, 100, 100);

     // 发射点
     emitterLayer.emitterPosition = CGPointMake(0, 0);

     // 发射模式
     emitterLayer.emitterMode = kCAEmitterLayerSurface;

     // 发射形状
     emitterLayer.emitterShape = kCAEmitterLayerLine;

     // 添加layer
     [self.view.layer addSublayer:emitterLayer];



     // 创建粒子
     CAEmitterCell *cell = [CAEmitterCell emitterCell];

     // 粒子产生率
     cell.birthRate = 10.f;

     // 粒子生命周期
     cell.lifetime = 10.f;

     // 速度值
     cell.velocity = 10;

     // 速度值的微调值
     cell.velocityRange = 3.f;

     // y轴加速度
     cell.yAcceleration = 2.f;

     // 发射角度
     cell.emissionRange = 4.f * M_1_PI;

     // 设置粒子颜色
     cell.color = [UIColor blackColor].CGColor;

     // 设置图片
     cell.contents = (__bridge id)([UIImage imageNamed:@"snow"].CGImage);




     // 让CAEmitterCell与CAEmitterLayer产生关联
     emitterLayer.emitterCells = @[cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
