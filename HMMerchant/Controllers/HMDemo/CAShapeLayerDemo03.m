//
//  CAShapeLayerDemo03.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAShapeLayerDemo03.h"

@interface CAShapeLayerDemo03 ()
@property (nonatomic, strong) NSTimer      *timer;      // 定时器
@property (nonatomic, strong) CAShapeLayer *shapeLayer; // 形状layer
@end

@implementation CAShapeLayerDemo03

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];



     // 设置背景色
     self.view.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1];

     // 创建椭圆形贝塞尔曲线
     UIBezierPath *oval        = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];

     // 创建CAShapeLayer
     _shapeLayer               = [CAShapeLayer layer];
     _shapeLayer.frame         = CGRectMake(0, 0, 100, 100);
     _shapeLayer.position      = self.view.center;

     // 修改CAShapeLayer的线条相关值
     _shapeLayer.fillColor     = [UIColor clearColor].CGColor;
     _shapeLayer.strokeColor   = [UIColor redColor].CGColor;
     _shapeLayer.lineWidth     = 2.f;
     _shapeLayer.strokeStart   = 0.f;
     _shapeLayer.strokeEnd     = 0.f;

     // 建立贝塞尔曲线与CAShapeLayer之间的关联
     _shapeLayer.path          = oval.CGPath;

     // 添加并显示
     [self.view.layer addSublayer:_shapeLayer];

     // 创建定时器
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                               target:self
                                             selector:@selector(animationEventTypeTwo)
                                             userInfo:nil
                                              repeats:YES];
}


/**
 *  动画效果1
 */
- (void)animationEventTypeOne {
     // 执行隐式动画
     _shapeLayer.strokeEnd = arc4random() % 100 / 100.f;
}

/**
 *  动画效果2
 */
- (void)animationEventTypeTwo {
     CGFloat valueOne = arc4random() % 100 / 100.f;
     CGFloat valueTwo = arc4random() % 100 / 100.f;

     // 执行隐式动画
     _shapeLayer.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
     _shapeLayer.strokeEnd   = valueOne > valueTwo ? valueOne : valueTwo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
