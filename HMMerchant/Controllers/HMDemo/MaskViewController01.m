//
//  MaskViewController01.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MaskViewController01.h"

@interface MaskViewController01 ()

@end

@implementation MaskViewController01

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 前景图
     UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
     background.image        = [UIImage imageNamed:@"base"];
     background.center       = self.view.center;
     [self.view addSubview:background];

     // 背景图
     UIImageView *upGround = [[UIImageView alloc] initWithFrame:background.frame];
     upGround.image        = [UIImage imageNamed:@"background"];
     [self.view addSubview:upGround];

     // maskView
     UIView *mask      = [[UIView alloc] initWithFrame:upGround.bounds];
     upGround.maskView = mask;

     // 图片1
     UIImageView *picOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
     picOne.image        = [UIImage imageNamed:@"1.png"];
     [mask addSubview:picOne];


     // 图片2
     UIImageView *picTwo = [[UIImageView alloc] initWithFrame:CGRectMake(100, -200, 100, 400)];
     picTwo.image        = [UIImage imageNamed:@"2.png"];
     [mask addSubview:picTwo];


     // 动画
     [UIView animateWithDuration:4.f delay:5.f options:0 animations:^{
          picOne.y -= 400;
          picTwo.y += 400;
     } completion:^(BOOL finished) {

     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
