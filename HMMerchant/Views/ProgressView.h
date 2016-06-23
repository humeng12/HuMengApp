//
//  ProgressView.h
//  下载进度条控件
//
//  Created by YouXianMing on 14/11/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic, assign) CGFloat  progress;   // 进度参数（取值范围为 %0 ~ %100）
@property (nonatomic, strong) UIColor *layerColor; // 修改layer的颜色

@end
