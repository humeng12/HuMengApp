//
//  ZheXianViewController.m
//  HMMerchant
//
//  Created by HRT on 16/7/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "ZheXianViewController.h"
#import "WHBKBarChartView.h"

@interface ZheXianViewController ()<UIWebViewDelegate>

@end

@implementation ZheXianViewController

- (void)viewDidLoad {
     [super viewDidLoad];

     [self addLeftButton];



     self.view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
     //交易柱状图
     WHBKBarChartView *barChatView = [[WHBKBarChartView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.5)];
     NSDictionary *valueDic1 = @{@"month":@"7月",@"money":@"8900"};
     NSDictionary *valueDic2 = @{@"month":@"8月",@"money":@"7000"};
     NSDictionary *valueDic3 = @{@"month":@"9月",@"money":@"6000"};
     NSDictionary *valueDic4 = @{@"month":@"10月",@"money":@"3000"};
     NSDictionary *valueDic5 = @{@"month":@"11月",@"money":@"4000"};
     NSDictionary *valueDic6 = @{@"month":@"12月",@"money":@"5000"};

     barChatView.dataResource = @[valueDic1,valueDic2,valueDic3,valueDic4,valueDic5,valueDic6];
     [self.view addSubview:barChatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
