//
//  CALayerDemo03.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//UIImageView淡入淡出切换图片效果

#import "CALayerDemo03.h"
#import "FadeImageView.h"

@interface CALayerDemo03 ()

@property (nonatomic, strong) CALayer       *imageLayer;
@property (nonatomic, strong) FadeImageView *fadeView;
@end

@implementation CALayerDemo03

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     UIImage *image1 = [UIImage imageNamed:@"起始图片@2x.png"];
     self.fadeView = [[FadeImageView alloc] initWithFrame:CGRectMake(0,100, 302, 707)];
     self.fadeView.image = image1;
     [self.view addSubview:self.fadeView];



     [self performSelector:@selector(layerAnimation)
                withObject:nil
                afterDelay:3.f];
}

- (void)layerAnimation {
     UIImage *image2 = [UIImage imageNamed:@"结束图片@2x.png"];
     self.fadeView.image = image2;

     //    // 图片动画
     //    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
     //    contentsAnimation.fromValue = self.imageLayer.contents;
     //    contentsAnimation.toValue   = (__bridge id)(image2.CGImage);
     //    contentsAnimation.duration  = 3.f;
     //
     //    // bounds动画
     //    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
     //    boundsAnimation.fromValue = [NSValue valueWithCGRect:self.imageLayer.bounds];
     //    boundsAnimation.toValue   = [NSValue valueWithCGRect:CGRectMake(0, 0, 302/2.f, 707/2.f)];
     //    boundsAnimation.duration  = 3.f;
     //
     //    // 组合动画
     //    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
     //    groupAnimation.animations        = @[contentsAnimation, boundsAnimation];
     //    groupAnimation.duration          = 3.f;
     //
     //    // 设定layer动画结束之后的值（必须设定，否则会恢复到动画之前的状态）
     //    self.imageLayer.contents = (__bridge id)(image2.CGImage);
     //    self.imageLayer.bounds   = CGRectMake(0, 0, 302/2.f, 707/2.f);
     //    
     //    // 提交动画
     //    [self.imageLayer addAnimation:groupAnimation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
