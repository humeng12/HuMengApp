//
//  CAGradientLayerDemo04.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CAGradientLayerDemo04.h"
#import "ColorUIImageView.h"

@interface CAGradientLayerDemo04 ()
@property (nonatomic, strong) ColorUIImageView *colorView;
@end

@implementation CAGradientLayerDemo04

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];

     self.colorView        = [[ColorUIImageView alloc] initWithFrame:CGRectMake(0, 0, 198, 253)];
     self.colorView.center = self.view.center;
     self.colorView.image  = [UIImage imageNamed:@"bg"];
     [self.view addSubview:self.colorView];

     [self performSelector:@selector(event)
                withObject:nil
                afterDelay:1.f];
}

- (void)event {
     self.colorView.direction = DOWN;
     self.colorView.color     = [UIColor cyanColor];
     self.colorView.percent   = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
