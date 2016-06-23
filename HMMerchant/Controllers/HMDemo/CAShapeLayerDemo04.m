//
//  CAShapeLayerDemo04.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAShapeLayerDemo04.h"
#import "CircleView.h"

@interface CAShapeLayerDemo04 ()
{
     CircleView *circle;
}
@end

@implementation CAShapeLayerDemo04

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     circle             = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
     circle.center      = self.view.center;
     circle.startValue  = 0.5;
     circle.lineWidth   = 3.f;
     circle.lineColor   = [UIColor grayColor];
     [self.view addSubview:circle];

     [self performSelector:@selector(delayAnimation)
                withObject:nil
                afterDelay:3.f];
}

- (void)delayAnimation {
     circle.value = 1.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
