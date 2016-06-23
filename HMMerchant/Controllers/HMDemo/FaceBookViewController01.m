//
//  FaceBookViewController01.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//


//用 POP 动画实现衰减动画

//POPDecayAnimation.h

#import "FaceBookViewController01.h"
#import "POP.h"

@interface FaceBookViewController01 ()
@property (nonatomic,strong) UIButton *btn;
@end

@implementation FaceBookViewController01

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     self.btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
     self.btn.backgroundColor = [UIColor redColor];
     self.btn.layer.cornerRadius = 50;
     self.btn.layer.masksToBounds = YES;
     self.btn.center = self.view.center;
     [self.view addSubview:self.btn];
     [self.btn addTarget:self action:@selector(tacAction:) forControlEvents:UIControlEventTouchUpInside];

     UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handPanGes:)];
     [self.btn addGestureRecognizer:panGes];
}

-(void)tacAction:(UIButton *)btn
{
     [btn.layer pop_removeAllAnimations];
}

-(void)handPanGes:(UIPanGestureRecognizer *)recognozer
{
     CGPoint tranPosint = [recognozer translationInView:self.view];

     recognozer.view.center = CGPointMake(recognozer.view.center.x+tranPosint.x, recognozer.view.center.y+tranPosint.y);

     [recognozer setTranslation:CGPointMake(0, 0) inView:self.view];

     if(recognozer.state == UIGestureRecognizerStateEnded)
     {
          CGPoint velocity = [recognozer velocityInView:self.view];

          POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
          decay.velocity = [NSValue valueWithCGPoint:velocity];

          [recognozer.view.layer pop_addAnimation:decay forKey:nil];

     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
