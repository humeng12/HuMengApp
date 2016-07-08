//
//  BarChartView.h
//  barChat
//
//  Created by paykee on 16/7/1.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarChartView : UIView

@property(nonatomic,strong) NSArray *dataResource;

-(UIColor *)colorWithIndex:(int)index;

@end
