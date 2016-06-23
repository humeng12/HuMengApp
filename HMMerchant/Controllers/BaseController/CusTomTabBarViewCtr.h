//
//  CusTomTabBarViewCtr.h
//  HRTMposApp
//
//  Created by HRT on 15/7/29.
//  Copyright (c) 2015年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusTomTabBarViewCtr : UITabBarController
{
     UIView * mpView;
}

+(CusTomTabBarViewCtr *)shareTabBarViewCtr;
@end
