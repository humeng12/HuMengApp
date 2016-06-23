//
//  HuanDongViewController.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//


//用缓动函数模拟物理动画

#import "HuanDongViewController.h"
#import "YXEasing.h"

@interface HuanDongViewController ()
{
     UIView *showView;
}
@end

@implementation HuanDongViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 添加显示用的view
     showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
     showView.layer.cornerRadius  = 50;
     showView.layer.masksToBounds = YES;
     showView.backgroundColor     = [UIColor redColor];
     [self.view addSubview:showView];


     [self performSelector:@selector(showDH) withObject:nil afterDelay:3];

}


-(void)showDH
{
     // 基本动画类型
//     CABasicAnimation *basicAnimation = [CABasicAnimation animation];
//     basicAnimation.keyPath           = @"position";
//     basicAnimation.duration          = 4.f;
//     
//     // fromValue = A | toValue = B
//     basicAnimation.fromValue = [NSValue valueWithCGPoint:showView.center];
//     basicAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//     
//     showView.center = CGPointMake(200, 200);
//     [showView.layer addAnimation:basicAnimation forKey:nil];


     // 关键帧动画类型
     CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
     keyFrameAnimation.keyPath              = @"position";
     keyFrameAnimation.duration             = 4.f;
     keyFrameAnimation.values = [YXEasing calculateFrameFromPoint:showView.center
                                                          toPoint:CGPointMake(200, 200)
                                                             func:BounceEaseInOut
                                                       frameCount:30 * 4];
     showView.center = CGPointMake(200, 200);
     [showView.layer addAnimation:keyFrameAnimation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
