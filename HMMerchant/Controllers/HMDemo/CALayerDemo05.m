//
//  CALayerDemo05.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//用CALayer实现复杂遮罩效果

#import "CALayerDemo05.h"

@interface CALayerDemo05 ()
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) UIImage *imageContents;
@property (nonatomic, strong) UIImage *maskContents;
@end

@implementation CALayerDemo05

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 获取图片
     self.imageContents = [UIImage imageNamed:@"原始图片"];
     self.maskContents  = [UIImage imageNamed:@"maskLayerContents"];

     // 创建出图片layer
     self.imageLayer          = [CALayer layer];
     self.imageLayer.frame    = CGRectMake(50, 50, 200, 200);
     self.imageLayer.contents = (__bridge id)(self.imageContents.CGImage);
     [self.view.layer addSublayer:self.imageLayer];

     // 创建出遮罩layer
     self.maskLayer          = [CALayer layer];
     self.maskLayer.frame    = self.imageLayer.bounds;
     self.maskLayer.contents = (__bridge id)(self.maskContents.CGImage);
     self.maskLayer.backgroundColor = [UIColor whiteColor].CGColor;

     // 给图片layer提供遮罩的layer
     self.imageLayer.mask = self.maskLayer;

     // 3秒钟之后做maskLayer动画
     [self performSelector:@selector(maskLayerAnimation)
                withObject:nil
                afterDelay:3.f];
}

- (void)maskLayerAnimation {
     self.maskLayer.frame = CGRectMake(50, 50, 200, 200);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
