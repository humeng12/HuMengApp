//
//  ShuXieViewController.m
//  HMMerchant
//
//  Created by HRT on 16/7/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "ShuXieViewController.h"
#import "WriteFunction.h"
#import "WriteAnimationLayer.h"


@interface ShuXieViewController ()

@end

@implementation ShuXieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addLeftButton];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     UIBezierPath *path = [WriteFunction pathForText:@"值得\n注意的是，“社保年度”这个\n概念，每个城\n市不一样，比如北京市是每年的7月至下一年\n的6月，上海市是每年的4月至下一年的3月，在一个社保年度里，职工的社保缴费基数\n是不变的。拿北京地区来说，2016年职工的社保缴费基数是指他在2015年7月-2016年6月的所有工\n资性收入的月平均额" lineSpace:4.0f textFont:[UIFont systemFontOfSize:20.0f] drawWidth:self.view.bounds.size.width forLayerDraw:YES];
     CGRect sizeFrame = CGPathGetBoundingBox(path.CGPath);
     [WriteAnimationLayer animationPath:path inView:self.view strokeColor:[UIColor redColor] lineWidth:1.2f layerFrame:CGRectMake(0.0f, 20.0f, sizeFrame.size.width, sizeFrame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
