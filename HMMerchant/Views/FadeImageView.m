//
//  FadeImageView.m
//  UIImageView淡入淡出切换图片效果
//
//  Created by YouXianMing on 14/11/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "FadeImageView.h"

@implementation FadeImageView

@synthesize image = _image;
- (void)setImage:(UIImage *)image {
    _image = image;
    
    NSLog(@"测试");
//    if (self.layer.contents != nil) {
        CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
        contentsAnimation.fromValue = self.layer.contents;
        contentsAnimation.toValue   = (__bridge id)(image.CGImage);
        contentsAnimation.duration  = 1.f;
        
        self.layer.contents = (__bridge id)(image.CGImage);
//    }
}
- (UIImage *)image {
    return _image;
}


@end
