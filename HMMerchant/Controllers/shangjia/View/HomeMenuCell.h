//
//  HomeMenuCell.h
//  HMMerchant
//
//  Created by HRT on 16/6/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuDelegate <NSObject>

-(void)homeMenuDidSelectedAtIndex:(NSInteger)index;

@end

@interface HomeMenuCell : UITableViewCell

@property (nonatomic, assign) id<HomeMenuDelegate> delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@end
