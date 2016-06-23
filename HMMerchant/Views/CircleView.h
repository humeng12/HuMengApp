//
//  CircleView.h
//  CircleView
//
//  Created by YouXianMing on 14/12/14.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic, assign) CGFloat  startValue; // 起始值（0~1）
@property (nonatomic, assign) CGFloat  lineWidth;  // 线宽(>0)
@property (nonatomic, strong) UIColor *lineColor;  // 线条颜色
@property (nonatomic, assign) CGFloat  value;      // 变化的值

@end
