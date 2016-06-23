//
//  CAShapeLayer+Circle.m
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//  you_xian_1030@163.com
//  QQ - 705786299
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "CAShapeLayer+Circle.h"

@implementation CAShapeLayer (Circle)

+ (instancetype)LayerWithCircleCenter:(CGPoint)point
                               radius:(CGFloat)radius
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            clockwise:(BOOL)clockwise
                      lineDashPattern:(NSArray *)lineDashPattern
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:clockwise];
    
    // 获取path
    layer.path = path.CGPath;
    layer.position = point;
    
    // 设置填充颜色为透明
    layer.fillColor = [UIColor clearColor].CGColor;
    
    // 获取曲线分段的方式
    if (lineDashPattern)
    {
        layer.lineDashPattern = lineDashPattern;
    }
    
    return layer;
}

+ (instancetype)LayerWithCircleCenter:(CGPoint)point
                               radius:(CGFloat)radius
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            clockwise:(BOOL)clockwise
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                        radius:radius/2.f
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:clockwise];
    
    // 获取path
    layer.path      = path.CGPath;
    layer.position  = point;
    layer.lineCap   = kCALineCapButt;
    layer.lineWidth = radius;
    
    // 设置填充颜色为透明
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}

@end
