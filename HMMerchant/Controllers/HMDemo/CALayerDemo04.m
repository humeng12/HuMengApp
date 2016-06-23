//
//  CALayerDemo04.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//


#define NO_EXECUTE  1  // 不执行
#define EXECUTE     0  // 执行

#import "CALayerDemo04.h"

@interface CALayerDemo04 ()
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation CALayerDemo04

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     // 创建出独立的layer
     self.imageLayer          = [CALayer layer];
     self.imageLayer.frame    = CGRectMake(0, 100, 302, 707);
     [self.view.layer addSublayer:self.imageLayer];

     // 给layer的contents属性设置图片
     self.imageLayer.contents = (__bridge id)([UIImage imageNamed:@"起始图片"].CGImage);

     // 3s后执行layer动画
     [self performSelector:@selector(layerAnimation)
                withObject:nil
                afterDelay:3.f];
}


- (void)layerAnimation {

     if (NO_EXECUTE) {
          // 执行隐式动画（你自己无法控制持续时间等等的参数）
          self.imageLayer.contents = (__bridge id)([UIImage imageNamed:@"结束图片"].CGImage);
     }

     if (NO_EXECUTE) {
          // 执行显式动画（你自己无法控制持续时间等等的参数）

          // 设定基本动画参数
          CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
          contentsAnimation.fromValue         =  self.imageLayer.contents;
          contentsAnimation.toValue           =  (__bridge id)([UIImage imageNamed:@"结束图片"].CGImage);
          contentsAnimation.duration          = 3.f;

          // 设定layer动画结束后的contents值
          self.imageLayer.contents         = (__bridge id)([UIImage imageNamed:@"结束图片"].CGImage);

          // 让layer开始执行动画
          [self.imageLayer addAnimation:contentsAnimation forKey:nil];
     }

     if (EXECUTE) {
          // 执行显式动画（你自己无法控制持续时间等等的参数）

          // 基于图片的动画
          CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
          contentsAnimation.fromValue         =  self.imageLayer.contents;
          contentsAnimation.toValue           =  (__bridge id)([UIImage imageNamed:@"结束图片"].CGImage);
          contentsAnimation.duration          = 0.5f;

          // 基于bounds的动画
          CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
          boundsAnimation.fromValue         = [NSValue valueWithCGRect:self.imageLayer.bounds];
          boundsAnimation.toValue           = [NSValue valueWithCGRect:CGRectMake(0, 0, 302/2.f, 707/2.f)];
          boundsAnimation.duration          = 0.5f;

          // 将基于图片的动画与基于bounds的动画组合起来
          CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
          groupAnimation.animations        = @[contentsAnimation, boundsAnimation];
          groupAnimation.duration          = 0.5f;

          // 设定layer动画结束后的contents值
          self.imageLayer.contents = (__bridge id)([UIImage imageNamed:@"结束图片"].CGImage);
          self.imageLayer.bounds   = CGRectMake(0, 0, 302/2.f, 707/2.f);
          
          // 让layer开始执行动画
          [self.imageLayer addAnimation:groupAnimation forKey:nil];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
