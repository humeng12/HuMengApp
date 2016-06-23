//
//  MulticolorView.h
//  CAGradientLayerExample_02
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//  you_xian_1030@163.com
//  QQ - 705786299
//
//  Created by YouXianMing on 14/12/27.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MulticolorView : UIView

@property (nonatomic, assign) CGFloat          lineWidth;  // 圆的线宽
@property (nonatomic, assign) CFTimeInterval   sec;        // 秒
@property (nonatomic, assign) CGFloat          percent;    // 百分比

@property (nonatomic, strong) NSArray         *colors;     // 颜色组(CGColor)

- (void)startAnimation;
- (void)endAnimation;

@end
