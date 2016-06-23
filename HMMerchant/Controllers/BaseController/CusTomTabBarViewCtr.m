//
//  CusTomTabBarViewCtr.m
//  HRTMposApp
//
//  Created by HRT on 15/7/29.
//  Copyright (c) 2015年 HRT. All rights reserved.
//

#import "CusTomTabBarViewCtr.h"

static CusTomTabBarViewCtr * instance = nil;

@interface CusTomTabBarViewCtr ()

@end

@implementation CusTomTabBarViewCtr

+(CusTomTabBarViewCtr *)shareTabBarViewCtr
{
     if (instance == nil) {
          instance = [[CusTomTabBarViewCtr alloc] init];
     }
     return instance;
}
- (void)viewDidLoad {
     [super viewDidLoad];
     [self setup];
}

-(void)setup
{
     NSArray *imageName = @[@"tabbar_pos",@"tabbar_member",@"tabbar_discvoer",@"tabbar_download",@"tabbar_mine"];
     NSArray *titles = @[@"推荐",@"直播",@"发现",@"下载",@"其他"];
     NSArray *classNames = @[@"RootViewController",@"MemberRootViewController",@"CouponRootViewController",@"DownViewController",@"CardsRootViewController"];
     NSMutableArray *viewController = [NSMutableArray array];

     for (int i = 0; i < classNames.count; i++)
     {
          UINavigationController *aNavi = [self _navigationControllerWithClass:NSClassFromString(classNames[i])];

          aNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:[[UIImage imageNamed:imageName[i]]imageWithRenderingMode:UIImageRenderingModeAutomatic] selectedImage:[[UIImage imageNamed:[imageName[i] stringByAppendingString:@"%@_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
          [viewController addObject:aNavi];
     }
     self.viewControllers = viewController;
     self.tabBar.tintColor = [UIColor orangeColor];
}

-(UINavigationController *)_navigationControllerWithClass:(Class)class
{
     UIViewController *aViewController = [[class alloc] init];
     UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:aViewController];
     return navigation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

     return YES;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
