//
//  BaseViewController.h
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
      NSOperationQueue * mpOperationQueue;
}

@property(assign,nonatomic)BOOL isNavIcon;

@property CGFloat ios7height;
@property BOOL geren;

@property(nonatomic,strong)NSUserDefaults *userData;


-(void)setTitle:(NSString*)title;
-(void)addLeftButton;
-(void)leftBtnClick;
-(void)hiddencellline:(UITableView*)tableview;

#pragma mark 判断网络
-(BOOL)connectedToNetWork;

@end
