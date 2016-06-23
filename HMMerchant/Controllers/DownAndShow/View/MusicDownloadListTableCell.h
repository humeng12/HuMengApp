//
//  MusicDownloadListTableCell.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPartnerDownloadManager.h"
#import "TaskEntity.h"
#import "TYMProgressBarView.h"

@interface MusicDownloadListTableCell : UITableViewCell

@property (nonatomic, strong) TYMProgressBarView *progressBarView;

@property (nonatomic,strong)TaskEntity *taskEntity;

@property (nonatomic,strong) NSString                *downloadUrl;
@property (strong, nonatomic )  UILabel        *musicName;

@property (strong, nonatomic )  UILabel        *musicDownloadPercent;
@property (strong, nonatomic )  UIButton       *stopStartBtn;

@property (strong, nonatomic)  UIImageView *img;

@property (strong, nonatomic)  UIImageView *img1;

@property (strong, nonatomic)  UILabel *desc;


@property (strong, nonatomic)  UIView *contentBgView;
- (IBAction)stopStartAction:(UIButton *)sender;

-(void)setTaskEntity:(TaskEntity *)taskEntity;


@end
