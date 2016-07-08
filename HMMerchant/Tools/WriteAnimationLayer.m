//
//  WriteAnimationLayer.m
//  书写文字
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 cheniue. All rights reserved.
//

#import "WriteAnimationLayer.h"

@interface WriteAnimationLayer()

@property (nonatomic, retain) CAShapeLayer *pathLayer;

@end

@implementation WriteAnimationLayer

+(void)animationPath:(UIBezierPath*)path inView:(UIView*)view strokeColor:(UIColor*)color lineWidth:(CGFloat)lineWidth layerFrame:(CGRect)layerFrame

{
    WriteAnimationLayer * animationLayer = [WriteAnimationLayer layer];
    animationLayer.frame = layerFrame;
    [animationLayer setBackgroundColor:[UIColor yellowColor].CGColor];
    [view.layer addSublayer:animationLayer];
    
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = animationLayer.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = lineWidth;
    pathLayer.lineJoin = kCALineJoinBevel;
    [animationLayer addSublayer:pathLayer];
    animationLayer.pathLayer = pathLayer;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [animationLayer.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}

@end
