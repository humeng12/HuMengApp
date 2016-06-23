//
//  CAEmitterLayerVC02.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAEmitterLayerVC02.h"
#import "CAEmitterLayerView.h"
#import "SnowView.h"
#import "RainView.h"

@interface CAEmitterLayerVC02 ()

@end

@implementation CAEmitterLayerVC02

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     UIImageView *alphaView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
     alphaView1.image        = [UIImage imageNamed:@"alpha"];

     UIImageView *alphaView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
     alphaView2.image        = [UIImage imageNamed:@"alpha"];


     // 添加下雪效果
     CAEmitterLayerView *snowView = [[SnowView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
     snowView.maskView            = alphaView1;
     [self.view addSubview:snowView];
     [snowView show];



     // 添加下雨效果
     CAEmitterLayerView *rainView = [[RainView alloc] initWithFrame:CGRectMake(100, 210, 100, 100)];
     rainView.maskView            = alphaView2;
     [self.view addSubview:rainView];
     [rainView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
