//
//  FaceBookViewController02.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//POPSpringAnimation

//用 POP 动画实现弹簧动画

#import "FaceBookViewController02.h"
#import "POP.h"

@interface FaceBookViewController02 ()
@property (nonatomic,strong) UIView *showView;
@end

@implementation FaceBookViewController02

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     self.showView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
     self.showView.backgroundColor = [UIColor cyanColor];
     self.showView.center          = self.view.center;
     [self.view addSubview:self.showView];


     POPSpringAnimation *setPopPro = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
     setPopPro.springSpeed         = 0;
     setPopPro.toValue             = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
     [self.showView pop_addAnimation:setPopPro forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
