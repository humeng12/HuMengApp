//
//  FaceBookViewController.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "FaceBookViewController.h"
#import "POP.h"

@interface FaceBookViewController ()
@property (nonatomic,strong) CADisplayLink *displayLink;//1s 60帧

@property (nonatomic,strong) CALayer       *nomalLayer;
@property (nonatomic,strong) CALayer       *popLayer;
@end

@implementation FaceBookViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     /*POP 动画库中 Layer 与 CALayer 的联系与区别*/

//     self.displayLink = [CADisplayLink displayLinkWithTarget:self
//                                                    selector:@selector(display:)];


     self.nomalLayer                 = [CALayer layer];
     self.nomalLayer.frame           = CGRectMake(100,100,100, 100);
     self.nomalLayer.backgroundColor = [UIColor redColor].CGColor;
     [self.view.layer addSublayer:self.nomalLayer];

     //初始化动画
     CABasicAnimation *baseAni       = [CABasicAnimation animationWithKeyPath:@"position"];
     baseAni.fromValue               = [NSValue valueWithCGPoint:self.nomalLayer.position];
     baseAni.toValue                 = [NSValue valueWithCGPoint:CGPointMake(100+50, 400)];
     baseAni.duration                = 4;
     baseAni.timingFunction          = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
     //设置结束位置的值
     self.nomalLayer.position        = CGPointMake(100+50, 400);

     //开始动画
     [self.nomalLayer addAnimation:baseAni forKey:nil];




//     self.popLayer = [CALayer layer];
//     self.popLayer.frame = CGRectMake(100,100,100, 100);
//     self.popLayer.backgroundColor = [UIColor redColor].CGColor;
//     [self.view.layer addSublayer:self.popLayer];
//
//     POPBasicAnimation *popBase = [POPBasicAnimation animationWithPropertyNamed:@"position"];
//     popBase.fromValue = [NSValue valueWithCGPoint:self.nomalLayer.position];
//     popBase.toValue = [NSValue valueWithCGPoint:CGPointMake(100+50, 400)];
//     popBase.duration = 4;
//     popBase.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//     [self.popLayer pop_addAnimation:popBase forKey:nil];
}

//-(void)display:(id)object
//{
//
//}
//
//-(void)eventOne{
//
//     [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//}
//
//
//-(void)eventTwo{
//
//     [self.displayLink invalidate];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
