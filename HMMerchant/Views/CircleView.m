//
//  CircleView.m
//  CircleView
//
//  Created by YouXianMing on 14/12/14.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 创建出CAShapeLayer
        _shapeLayer       = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        
        // 创建出贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        
        // 贝塞尔曲线与CAShapeLayer产生关联
        _shapeLayer.path = path.CGPath;
        
        // 基本配置
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth   = 1.f;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeEnd   = 0.f;
        
        // 添加到当前view
        [self.layer addSublayer:_shapeLayer];
    }
    return self;
}

@synthesize startValue = _startValue;
- (void)setStartValue:(CGFloat)startValue {
    _startValue           = startValue;
    _shapeLayer.strokeEnd = startValue;
}
- (CGFloat)startValue {
    return _startValue;
}

@synthesize lineWidth = _lineWidth;
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth            = lineWidth;
    _shapeLayer.lineWidth = lineWidth;
}
- (CGFloat)lineWidth {
    return _lineWidth;
}

@synthesize lineColor = _lineColor;
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor              = lineColor;
    _shapeLayer.strokeColor = lineColor.CGColor;
}
- (UIColor *)lineColor {
    return _lineColor;
}

@synthesize value = _value;
- (void)setValue:(CGFloat)value {
    _value                = value;
    _shapeLayer.strokeEnd = value;
}
- (CGFloat)value {
    return _value;
}

@end
