//
//  MusicDownloadListTableCell.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicDownloadListTableCell.h"


@implementation MusicDownloadListTableCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     {
          [self addSomeView];
     }

     return self;
}


-(void)addSomeView
{
     self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 65, 80)];
     [self.contentView addSubview:self.img];

     self.img1 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 34, 30, 30)];
     self.img1.image = [UIImage imageNamed:@"ic_movie_play"];
     [self.contentView addSubview:self.img1];

     self.musicName = [[UILabel alloc] initWithFrame:CGRectMake(84, 17, 167, 15)];
     self.musicName.font = [UIFont systemFontOfSize:15];
     self.musicName.textColor = [UIColor blackColor];
     [self.contentView addSubview:self.musicName];

     self.desc = [[UILabel alloc] initWithFrame:CGRectMake(86, 39, 163, 30)];
     self.desc.font = [UIFont systemFontOfSize:12];
     self.desc.numberOfLines = 0;
     self.desc.textColor = [UIColor grayColor];
     [self.contentView addSubview:self.desc];

     self.stopStartBtn = [[UIButton alloc] initWithFrame:CGRectMake(254, 17, 58, 45)];
     [self.stopStartBtn addTarget:self action:@selector(stopStartAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:self.stopStartBtn];

     self.musicDownloadPercent = [[UILabel alloc] initWithFrame:CGRectMake(263, 70, 48, 22)];
     self.musicDownloadPercent.font = [UIFont systemFontOfSize:15];
     self.musicDownloadPercent.textColor = [UIColor grayColor];
     [self.contentView addSubview:self.musicDownloadPercent];


     self.progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(86 , 80, screenWidth- 157, 8.0f)];
     self.progressBarView.barBorderColor = [UIColor orangeColor];
     self.progressBarView.barFillColor = [UIColor orangeColor];
     [self.contentView addSubview:self.progressBarView];
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)stopStartAction:(UIButton *)sender {

    if (self.taskEntity.taskDownloadState == TaskStateRunning) {
          [[MusicPartnerDownloadManager sharedInstance] pause:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
    }else if (self.taskEntity.taskDownloadState == TaskStateSuspended){
         [[MusicPartnerDownloadManager sharedInstance] start:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }else{
        [[MusicPartnerDownloadManager sharedInstance] start:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }
    
    
}


-(void)setTaskEntity:(TaskEntity *)taskEntity{
    
    _taskEntity = taskEntity;
    
    _desc.text = taskEntity.desc;
    _img.image = [UIImage imageNamed:taskEntity.imgName];
    _downloadUrl = taskEntity.downLoadUrl;
    _musicName.text = taskEntity.name;
    _progressBarView.progress = taskEntity.progress;
    _musicDownloadPercent.text =  [NSString stringWithFormat:@"%.3f",taskEntity.progress];
    
    if (_taskEntity.taskDownloadState == TaskStateSuspended) {
        [_stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }else if (_taskEntity.taskDownloadState == TaskStateRunning){
        [_stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
    }else{
         [_stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }
    
    __weak typeof(self) weakSelf = self;
    _taskEntity.progressBlock = ^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        weakSelf.progressBarView.progress = progress;
        weakSelf.musicDownloadPercent.text = [NSString stringWithFormat:@"%.3f",progress];
    };
    
    _taskEntity.completeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString) {
        if (mpDownloadState == TaskStateSuspended) {
            
            weakSelf.taskEntity.taskDownloadState = TaskStateSuspended;
           [weakSelf.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
        }else if (mpDownloadState == TaskStateRunning){
            weakSelf.taskEntity.taskDownloadState = TaskStateRunning;
            [weakSelf.stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
        }
    };
    
}

@end
