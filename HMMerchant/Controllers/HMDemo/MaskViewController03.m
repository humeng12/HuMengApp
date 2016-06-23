//
//  MaskViewController03.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MaskViewController03.h"
#import "FadeString.h"

@interface MaskViewController03 ()

@end

@implementation MaskViewController03

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     // 创建FadeString
     FadeString *fadeString = [[FadeString alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
     fadeString.text        = @"极客学院iOS开发";
     fadeString.center      = self.view.center;
     [self.view addSubview:fadeString];


     // 执行动画效果
     [fadeString fadeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
