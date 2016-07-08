//
//  CardsRootViewController.m
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CardsRootViewController.h"

#import "MaskViewController.h"
#import "MaskViewController01.h"
#import "MaskViewController02.h"
#import "MaskViewController03.h"

#import "FaceBookViewController.h"
#import "FaceBookViewController01.h"
#import "FaceBookViewController02.h"


#import "HuanDongViewController.h"
#import "HuanDongViewController01.h"
#import "HuanDongViewController02.h"
#import "HuanDongViewController03.h"


#import "CAEmitterLayerVC01.h"
#import "CAEmitterLayerVC02.h"

#import "CAGradientLayerDemo01.h"
#import "CAGradientLayerDemo02.h"
#import "CAGradientLayerDemo03.h"
#import "CAGradientLayerDemo04.h"
#import "CAGradientLayerDemo05.h"
#import "CAGradientLayerDemo06.h"
#import "CAGradientLayerDemo07.h"


#import "CAShapeLayerDemo01.h"
#import "CAShapeLayerDemo02.h"
#import "CAShapeLayerDemo03.h"
#import "CAShapeLayerDemo04.h"

#import "CALayerDemo01.h"
#import "CALayerDemo02.h"
#import "CALayerDemo03.h"
#import "CALayerDemo04.h"
#import "CALayerDemo05.h"
#import "CALayerDemo06.h"


#import "HuiTuViewController.h"

#import "DemoViewController.h"

#import "PlayerViewController.h"


#import "ShangJiaViewController.h"

#import "CheShiViewController.h"

#import "TLMenuButtonView.h"


#import "JiePingViewController.h"
#import "ShuXieViewController.h"
#import "ZheXianViewController.h"
#import "PaiXuViewController.h"

@interface CardsRootViewController ()
{
     UIImageView *headView;
     BOOL _ISShowMenuButton;
}

@property (nonatomic, strong) TLMenuButtonView *tlMenuView ;

@property (strong,nonatomic) NSArray *buttonBacImages;
@property (strong,nonatomic) NSArray *LabelTitles;
@end

@implementation CardsRootViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setTitle:@"其他"];

     headView = [[UIImageView alloc] init];
     [headView margin_top:64];
     [headView margin_left:0];
     [headView layout_width:screenWidth];
     [headView layout_heigth:180*KUANDUBI];
     headView.image = [UIImage imageNamed:@"chuzhikaMain"];
     [self.view addSubview:headView];


     [self addButtonAndLabel];


     UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-67, self.view.bounds.size.height-107, 55, 55)];
     button.layer.cornerRadius = 27.5;
     button.backgroundColor = [UIColor greenColor];
     [button addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
     [button setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
     [self.view addSubview:button];

     TLMenuButtonView *tlMenuView =[TLMenuButtonView standardMenuView];
     tlMenuView.centerPoint = button.center;
     __weak typeof(self) weakSelf = self;
     tlMenuView.clickAddButton = ^(NSInteger tag, UIColor *color){
          weakSelf.view.backgroundColor = color;
          _ISShowMenuButton = YES;
          [weakSelf clickAddButton:button];
     };
     _tlMenuView = tlMenuView;
}


- (void)clickAddButton:(UIButton *)sender{

     if (!_ISShowMenuButton) {
          [UIView animateWithDuration:0.2 animations:^{
               CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI / 4 );
               [sender setTransform:rotate];
          }];
          [_tlMenuView showItems];
     }else{
          [UIView animateWithDuration:0.2 animations:^{
               CGAffineTransform rotate = CGAffineTransformMakeRotation( 0 );
               [sender setTransform:rotate];
          }];
          [_tlMenuView dismiss];
     }
     _ISShowMenuButton = !_ISShowMenuButton;
}



-(void)addButtonAndLabel
{

     self.LabelTitles=[[NSArray alloc]initWithObjects:@"商家",@"视频",@"截屏",@"书写",@"折线图",@"排序",@"惠买单",@"设置", nil];
 self.buttonBacImages=@[@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected",@"tabbar_card_selected"];

     int x = screenWidth/8, y = 180*BiLiHaW+20+50, Hpad =0,chaH = 0;

     if (isPad)
     {
          Hpad =100;
     }

     if (screenHeight>480) {
          chaH = 15;
          y+=chaH;
     }
     for (int i = 0; i<self.buttonBacImages.count; i++) {
          UIButton * btnHome = [UIButton buttonWithType:UIButtonTypeSystem];
          btnHome.frame = CGRectMake(0, 0, 60, 60);
          btnHome.center = CGPointMake(x, y+30);
          btnHome.tag = 100+i;
          [btnHome setBackgroundImage:[UIImage imageNamed:@"ic_category_t37"] forState:UIControlStateNormal];

          [btnHome addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.view addSubview:btnHome];

          UILabel * labTem = [[UILabel alloc]init];
          labTem.frame = CGRectMake(0, 0, screenWidth/4, 20);
          labTem.center = CGPointMake(x, y+67);
          labTem.font = [UIFont systemFontOfSize:13];
          labTem.textAlignment = NSTextAlignmentCenter;
          labTem.backgroundColor = [UIColor clearColor];
          labTem.text = self.LabelTitles[i];
          labTem.textColor = [UIColor blackColor];
          [self.view addSubview:labTem];

          x +=screenWidth/4;
          if (x >screenWidth)
          {
               x = screenWidth/8;
               y += 82+Hpad/2+ chaH;
          }
     }
}


-(void)buttonAction:(UIButton *)bt
{
     switch (bt.tag) {
          case 100:
          {
               ShangJiaViewController *merchant = [[ShangJiaViewController alloc] init];
               merchant.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:merchant animated:YES];
          }
               break;
          case 101:
          {
               CheShiViewController *merchant = [[CheShiViewController alloc] init];
               merchant.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:merchant animated:YES];
          }
               break;
          case 102:
          {
               JiePingViewController *ff = [[JiePingViewController alloc] init];
               [self.navigationController pushViewController:ff animated:YES];
          }
               break;
          case 103:
          {
               ShuXieViewController *dd = [[ShuXieViewController alloc] init];
               [self.navigationController pushViewController:dd animated:YES];
          }
               break;
          case 104:
          {
               ZheXianViewController *dd = [[ZheXianViewController alloc] init];
               [self.navigationController pushViewController:dd animated:YES];
          }
               break;
          case 105:
          {
               PaiXuViewController *dd = [[PaiXuViewController alloc] init];
               [self.navigationController pushViewController:dd animated:YES];
          }
               break;
          case 106:
          {

          }
               break;
          case 107:
          {

          }
               break;
               
          default:
               break;
     }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
