//
//  CAGradientLayerDemo07.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAGradientLayerDemo07.h"

@interface CAGradientLayerDemo07 ()
@property (nonatomic, strong) NSTimer          *timer;
@property (nonatomic, strong) CAGradientLayer  *gradientLayer;
@end

@implementation CAGradientLayerDemo07

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
     imageView1.image        = [UIImage imageNamed:@"bg2"];
     [self.view addSubview:imageView1];

     UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.bounds];
     imageView2.image        = [UIImage imageNamed:@"bg1"];
     [self.view addSubview:imageView2];

     // 渐变图层
     self.gradientLayer       = [CAGradientLayer layer];
     self.gradientLayer.frame = self.view.bounds;

     // 设置颜色
     self.gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:1.0].CGColor,
                                   (id)[[UIColor redColor] colorWithAlphaComponent:0.f].CGColor];
     self.gradientLayer.locations = @[[NSNumber numberWithFloat:0.7f],
                                      [NSNumber numberWithFloat:1.0f]];

     // 添加渐变图层
     imageView2.layer.mask = self.gradientLayer;

     // 添加定时器
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                   target:self
                                                 selector:@selector(timerEvent)
                                                 userInfo:nil
                                                  repeats:YES];
}


- (void)timerEvent {
     self.gradientLayer.locations = @[[NSNumber numberWithFloat:arc4random()%100/100.f],
                                      [NSNumber numberWithFloat:1.0f]];

     self.gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:1.0].CGColor,
                                   (id)[[UIColor colorWithRed:arc4random()%255/255.f
                                                        green:arc4random()%255/255.f
                                                         blue:arc4random()%255/255.f
                                                        alpha:1.0] colorWithAlphaComponent:0.f].CGColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
