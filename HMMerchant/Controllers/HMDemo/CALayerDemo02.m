//
//  CALayerDemo02.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CALayerDemo02.h"
#import "ProgressView.h"

@interface CALayerDemo02 ()
@property (nonatomic, strong) ProgressView *progressView;
@property (nonatomic, strong) NSTimer      *timer;
@end

@implementation CALayerDemo02

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     self.progressView            = [[ProgressView alloc] initWithFrame:CGRectMake(20, 100, 290, 3)];
     self.progressView.layerColor = [UIColor yellowColor];
     [self.view addSubview:self.progressView];

     // 创建定时器，每一秒执行一回
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(layerAnimation)
                                                 userInfo:nil
                                                  repeats:YES];
}


- (void)layerAnimation {
     // 随机获取 0% ~ 100% 给layer赋值
     self.progressView.progress = arc4random() % 100 / 100.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
