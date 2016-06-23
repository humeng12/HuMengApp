//
//  BaseViewController.m
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "BaseViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

@interface BaseViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
     CGFloat offsetOf_Y;
}

@end

@implementation BaseViewController
@synthesize ios7height;


- (instancetype)init
{
     self = [super init];
     if (self) {
          offsetOf_Y = 0;
     }
     return self;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
     return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
     return NO;
}


#pragma mark-网络判断
-(BOOL)connectedToNetWork
{
     // 创建零地址，0.0.0.0地址表示查询本机的网络连接状态
     struct sockaddr_in zeroAddress;
     bzero(&zeroAddress, sizeof(zeroAddress));
     zeroAddress.sin_len = sizeof(zeroAddress);
     zeroAddress.sin_family = AF_INET;
     SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
     SCNetworkReachabilityFlags flags;

     BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
     CFRelease(defaultRouteReachability);

     // 如果不能获取连接标志，则不能连接网络，直接返回
     if (!didRetrieveFlags) {
          printf("Error. Count not recover network reachability flags\n");
          return NO;
     }

     // 根据获得的连接标志进行判断
     BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
     BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
     return (isReachable && !needsConnection) ? YES : NO;
}


-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}



#pragma mark -键盘升起和放下相关
- (void)keyboardWillShow:(NSNotification *)noti
{
     CGFloat keyboardHeight1 = [noti.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
     [self.view.layer removeAllAnimations];
     UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
     UIView *firstResponderView = [keyWindow performSelector:@selector(findFirstResponder)];

     CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:firstResponderView.frame fromView:firstResponderView.superview];

     CGFloat bottom = rect.origin.y +rect.size.height;
     CGFloat keyboardY = self.view.window.size.height - keyboardHeight1;
     if (bottom > keyboardY) {
          offsetOf_Y +=bottom -(self.view.window.size.height - keyboardHeight1);
          [UIView animateKeyframesWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
               self.view.y -= offsetOf_Y;
          } completion:^(BOOL finished) {

          }];
     }
}

- (void)keyboardWillHide:(NSNotification *)noti
{
     [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
          self.view.y +=offsetOf_Y;
     } completion:^(BOOL finished) {

     }];
     offsetOf_Y = 0;
}

- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];

     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
          mpOperationQueue = [[NSOperationQueue alloc] init];
          // Custom
          ios7height = iOS7 ? 20:0;
          self.geren = NO;

          self.userData = [NSUserDefaults standardUserDefaults];
     }
     return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

     self.view.backgroundColor = BackColorGrayGlk;
     self.navigationController.navigationBarHidden = NO;
}


-(void)addLeftButton
{
     UIButton * lpLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,50,30)];
     [lpLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
     [lpLeftBtn setBackgroundColor:[UIColor clearColor]];
     [lpLeftBtn setImage:[UIImage imageNamed:@"leftPosDuiZhang"] forState:UIControlStateNormal];
     UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
     [leftBtn setCustomView:lpLeftBtn];
     self.navigationItem.leftBarButtonItem = leftBtn;
}


-(void)leftBtnClick
{
     [self.navigationController popViewControllerAnimated:YES];
}


-(void)setTitle:(NSString*)title{

     NSArray*titleArray=[title componentsSeparatedByString:@""];
     if (titleArray.count) {
          UIView*vc=[[UIView alloc]initWithFrame:CGRectMake(54, 0, screenWidth-54*2, 44)];
          vc.backgroundColor=[UIColor clearColor];

          if (self.isNavIcon) {
               UIImageView*image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
               [image setFrame:CGRectMake(0, 0, screenWidth-54*2, 44)];
               [vc addSubview:image];

               self.navigationItem.titleView=vc;

          }else{
               CGSize size = [title sizeWithAttributes:@{
                                                         NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                         }];

               UILabel *upLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
               upLabel.textColor=[UIColor blackColor];
               upLabel.font=[UIFont boldSystemFontOfSize:18];
               upLabel.backgroundColor=[UIColor clearColor];
               upLabel.textAlignment=NSTextAlignmentCenter;
               upLabel.text=[titleArray objectAtIndex:0];

               self.navigationItem.titleView = upLabel;
          }
     }
}


//隐藏TableView的空cell的线
-(void)hiddencellline:(UITableView*)tableview
{
     UIView *bgview = [[UIView alloc] init];
     bgview.backgroundColor = [UIColor whiteColor];
     [tableview setTableFooterView:bgview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
