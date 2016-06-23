//
//  CAGradientLayerDemo05.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAGradientLayerDemo05.h"
#import "MulticolorView.h"

@interface CAGradientLayerDemo05 ()
@property (nonatomic, strong) NSTimer         *timer;
@property (nonatomic, strong) MulticolorView  *showView;
@end

@implementation CAGradientLayerDemo05

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     self.view.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1];

     _showView           = [[MulticolorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
     _showView.lineWidth = 3.f;
     _showView.sec       = 2.f;
     _showView.colors    = @[(id)[UIColor cyanColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor cyanColor].CGColor];
     _showView.center    = self.view.center;
     _timer              = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(event:)
                                                          userInfo:nil
                                                           repeats:YES];

     [self.view addSubview:_showView];
     [_showView startAnimation];
}

- (void)event:(id)object
{
     _showView.percent = arc4random()%100/100.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
