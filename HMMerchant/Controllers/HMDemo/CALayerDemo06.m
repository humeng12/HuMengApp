//
//  CALayerDemo06.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CALayerDemo06.h"

@interface CALayerDemo06 ()
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) UIImage *contentImage;
@property (nonatomic, strong) UIImage *maskImage;
@end

@implementation CALayerDemo06

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];


     // 处理图片
     self.contentImage = [UIImage imageNamed:@"原始图片"];
     self.maskImage    = [UIImage imageNamed:@"maskLayerContents"];


     // 生成maskLayer
     self.maskLayer          = [CALayer layer];
     self.maskLayer.frame    = CGRectMake(0, 0, 427/2.f, 427/2.f);
     self.maskLayer.contents = (__bridge id)(self.maskImage.CGImage);


     // 生成contentsLayer
     self.imageLayer          = [CALayer layer];
     self.imageLayer.frame    = CGRectMake(0, 0, 427/2.f, 427/2.f);
     self.imageLayer.contents = (__bridge id)(self.contentImage.CGImage);


     // 给contentsLayer设定mask值
     self.imageLayer.mask     = self.maskLayer;


     // 将contentsLayer添加到layer中
     [self.view.layer addSublayer:self.imageLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
