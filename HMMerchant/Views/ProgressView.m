//
//  ProgressView.m
//  下载进度条控件
//
//  Created by YouXianMing on 14/11/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (nonatomic, strong) CALayer *progressLayer;
@property (nonatomic, assign) CGFloat  currentViewWidth;

@end

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressLayer       = [CALayer layer];
        self.progressLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        self.progressLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:self.progressLayer];
        
        // 存储当前view的宽度值
        self.currentViewWidth = frame.size.width;
    }
    return self;
}

#pragma mark - 重写setter，getter方法
@synthesize progress = _progress;
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    if (progress <= 0) {
        self.progressLayer.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    } else if (progress <= 1) {
        self.progressLayer.frame = CGRectMake(0, 0,
                                              progress * self.currentViewWidth,
                                              self.frame.size.height);
    } else {
        self.progressLayer.frame = CGRectMake(0, 0, self.currentViewWidth,
                                              self.frame.size.height);
    }
}
- (CGFloat)progress {
    return _progress;
}

@synthesize layerColor = _layerColor;
- (void)setLayerColor:(UIColor *)layerColor {
    _layerColor = layerColor;
    self.progressLayer.backgroundColor = layerColor.CGColor;
}
- (UIColor *)layerColor {
    return _layerColor;
}

@end
