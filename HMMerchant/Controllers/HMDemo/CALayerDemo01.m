//
//  CALayerDemo01.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CALayerDemo01.h"

@interface CALayerDemo01 ()
@property (nonatomic, strong) NSTimer *timer; // 定时器
@property (nonatomic, strong) CALayer *layer; // layer
@end

@implementation CALayerDemo01

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     // CALayer
     _layer                 = [CALayer layer];
     _layer.frame           = CGRectMake(50, 100, 200, 2);
     _layer.backgroundColor = [UIColor redColor].CGColor;
     [self.view.layer addSublayer:_layer];

     // 定时器
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                               target:self
                                             selector:@selector(timerEvent)
                                             userInfo:nil
                                              repeats:YES];
}

/**
 *  定时器
 */
- (void)timerEvent {
     // 执行layer的隐式动画（取随机值模拟下载进度）
     _layer.frame = CGRectMake(50, 100, arc4random()%200, 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
