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

@interface CardsRootViewController ()
{
     UIImageView *headView;
}

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
}


-(void)addButtonAndLabel
{

     self.LabelTitles=[[NSArray alloc]initWithObjects:@"商家",@"制卡",@"充值",@"发卡",@"锁卡",@"报表",@"惠买单",@"设置", nil];
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

          }
               break;
          case 102:
          {

          }
               break;
          case 103:
          {

          }
               break;
          case 104:
          {

          }
               break;
          case 105:
          {

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
