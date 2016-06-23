//
//  CAShapeLayer+Circle.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//  you_xian_1030@163.com
//  QQ - 705786299
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

/* -= 生成圆环 =-
 
 // 复制粘贴即可看到效果
 CAShapeLayer *layer = [CAShapeLayer LayerWithCircleCenter:self.view.center
 radius:50.f
 startAngle:DEGREES(180)
 endAngle:DEGREES(180 + 360)
 clockwise:YES
 lineDashPattern:@[@5, @5, @5, @5]];
 
 layer.strokeColor   = [UIColor redColor].CGColor;     // 边缘线的颜色
 layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
 layer.lineWidth     = 1.0f;                           // 线条宽度
 layer.strokeStart   = 0.0f;
 layer.strokeEnd     = 1.0f;
 
 [self.view.layer addSublayer:layer];
 */

/*/* -= 生成圆 =-
 
 // 复制粘贴即可看到效果
 CAShapeLayer *layer = [CAShapeLayer LayerWithCircleCenter:self.view.center
 radius:160
 startAngle:DEGREES(0)
 endAngle:DEGREES(360)
 clockwise:YES];
 
 layer.strokeColor   = [UIColor redColor].CGColor;     // 边缘线的颜色
 layer.strokeStart   = 0.0f;
 layer.strokeEnd     = 1.0f;
 
 [self.view.layer addSublayer:layer];
 */

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

// 将常数转换为度数
#define   DEGREES(degrees)  ((M_PI * (degrees))/ 180.f)

@interface CAShapeLayer (Circle)

// 圆环
+ (instancetype)LayerWithCircleCenter:(CGPoint)point
                               radius:(CGFloat)radius
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            clockwise:(BOOL)clockwise
                      lineDashPattern:(NSArray *)lineDashPattern;

// 圆
+ (instancetype)LayerWithCircleCenter:(CGPoint)point
                               radius:(CGFloat)radius
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            clockwise:(BOOL)clockwise;

@end
