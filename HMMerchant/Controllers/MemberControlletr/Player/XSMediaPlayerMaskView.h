//
//  XSMediaPlayerMaskView.h
//  HMMerchant
//
//  Created by HRT on 16/6/7.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSMediaPlayerMaskView : UIView

/** 开始播放按钮 */
@property (strong, nonatomic)  UIButton       *startBtn;
/** 当前播放时长label */
@property (strong, nonatomic)  UILabel        *currentTimeLabel;
/** 视频总时长label */
@property (strong, nonatomic)  UILabel        *totalTimeLabel;
/** 缓冲进度条 */
@property (strong, nonatomic)  UIProgressView *progressView;
/** 滑杆 */
@property (strong, nonatomic)  UISlider       *videoSlider;
/** 全屏按钮 */
@property (strong, nonatomic)  UIButton       *fullScreenBtn;
@property (strong, nonatomic)  UIButton       *lockBtn;
/** 音量进度 */
@property (nonatomic,strong) UIProgressView   *volumeProgress;

/** 系统菊花 */
@property (nonatomic,strong)UIActivityIndicatorView *activity;

@end
