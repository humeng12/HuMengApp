//
//  MyGuideViewController.m
//  HMMerchant
//
//  Created by HRT on 15/12/25.
//  Copyright © 2015年 HRT. All rights reserved.
//

#import "MyGuideViewController.h"
#import "CALayer+Transition.h"
#import "UIView+Uitls.h"
#import "CusTomTabBarViewCtr.h"


#define  screenbounds [UIScreen mainScreen].bounds

@interface MyGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pageScroll;

@end

@implementation MyGuideViewController


- (void)viewDidLoad {
     [super viewDidLoad];
     NSArray *imageNameArray = [NSArray arrayWithObjects:@"guide_1", @"guide_2", @"guide_3",@"guide_4", nil];

     self.pageScroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.pageScroll.bounces = NO;
     self.pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
     self.pageScroll.showsHorizontalScrollIndicator = NO;
     self.pageScroll.delegate = self;
     self.pageScroll.pagingEnabled = YES;
     self.pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
     [self.view addSubview:self.pageScroll];


     NSString *imageName = nil;
     for (int i = 0; i < imageNameArray.count; i++)
     {
          imageName = [imageNameArray objectAtIndex:i];
          UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
          imageView.frame = [UIScreen mainScreen].bounds;
          imageView.origin = CGPointMake(i * imageView.width, 0);
          imageView.contentMode = UIViewContentModeScaleToFill;
          imageView.userInteractionEnabled = YES;
          [self.pageScroll addSubview:imageView];

          UIButton *enterBtn = nil;
          if (i == imageNameArray.count - 1)
          {

               enterBtn = [[UIButton alloc] initWithFrame:(CGRect)
               {
                    .origin = {.x = (self.view.width - 70) / 2, .y = self.view.height - 45},
                    .size = {.width = 70 , .height = 20}
               }];

               [enterBtn setBackgroundImage:[UIImage imageNamed:@"entry@2x.png"] forState:UIControlStateNormal];
               [enterBtn setBackgroundImage:[UIImage imageNamed:@"entry@2x.png"] forState:UIControlStateHighlighted];
               [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
               [imageView addSubview:enterBtn];
          }

     }
     [self.pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
}


- (BOOL)prefersStatusBarHidden
{
     return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)enter
{
     [self transition:TransitionAnimTypeRippleEffect];
}


- (void)transition:(TransitionAnimType)type
{
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setBool:YES forKey:@"Guide"];
     [userDefaults synchronize];
     CusTomTabBarViewCtr *cusTom = [[CusTomTabBarViewCtr alloc] init];
     [UIApplication sharedApplication].delegate.window.rootViewController = cusTom;
     [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:type subType:TransitionSubtypesFromRight curve:TransitionCurveLinear duration:0.6f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
