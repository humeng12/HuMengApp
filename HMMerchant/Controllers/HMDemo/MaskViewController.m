//
//  MaskViewController.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()
@property (nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) UIImageView *maskImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@end

@implementation MaskViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];
     [self setTitle:@"动画"];


     CGFloat width = 120;

     /*maskView（maskLayer） IOS8*/
     // 底图
     self.baseImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, width, width)];
     self.baseImageView.image = [UIImage imageNamed:@"base"];
     //[self.view addSubview:self.baseImageView];

     // mask
     self.maskImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84 + width + 20, width, width)];
     self.maskImageView.image = [UIImage imageNamed:@"mask"];
     //[self.view addSubview:self.maskImageView];

     // 使用maskView的情况
     self.addImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84 + (width + 20) * 2, width, width)];
     //[self.view addSubview:self.addImageView];
     self.addImageView.image = [UIImage imageNamed:@"base"];
     UIImageView *mask          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
     mask.image                 = [UIImage imageNamed:@"mask"];

     // maskView并不能用addSubview来添加遮罩,这点千万注意
     self.addImageView.maskView = mask;



     /*maskView 配合 CAGradientLayer 的使用*/
     // 加载图片
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,84, 200, 200)];
     imageView.image        = [UIImage imageNamed:@"base"];
     [self.view addSubview:imageView];

     // 创建出CAGradientLayer
     CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     gradientLayer.frame            = imageView.bounds;
     gradientLayer.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
                                        (__bridge id)[UIColor blackColor].CGColor,
                                        (__bridge id)[UIColor clearColor].CGColor];
     gradientLayer.locations        = @[@(0.25), @(0.5), @(0.75)];
     gradientLayer.startPoint       = CGPointMake(0, 0);
     gradientLayer.endPoint         = CGPointMake(1, 0);

     // 容器view --> 用于加载创建出的CAGradientLayer
     UIView *containerView = [[UIView alloc] initWithFrame:imageView.bounds];
     [containerView.layer addSublayer:gradientLayer];

     // 设定maskView
     imageView.maskView  = containerView;

     CGRect frame        = containerView.frame;
     frame.origin.x     -= 200;

     // 重新赋值
     containerView.frame = frame;

     // 给maskView做动画效果
     [UIView animateWithDuration:3.f animations:^{
          // 改变位移
          CGRect frame        = containerView.frame;
          frame.origin.x     += 400;

          // 重新赋值
          containerView.frame = frame;
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
