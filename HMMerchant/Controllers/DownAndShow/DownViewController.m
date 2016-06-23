//
//  DownViewController.m
//  HMMerchant
//
//  Created by HRT on 16/6/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "DownViewController.h"
#import "MusicDownloadDataSource.h"
#import "MusicDownloadListTableCell.h"
#import "DownLoadCompleteDataSource.h"
#import "MineTableCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DTKDropdownMenuView.h"
#import "AppColorConfig.h"


@interface DownViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;

@property (nonatomic , strong) MusicDownloadDataSource *dataSource;

@property (nonatomic , strong) DownLoadCompleteDataSource *downLoadCompleteDataSource;

@end

@implementation DownViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setTitle:@"下载和播放"];

      [self addRightItem];

     self.dataSource = [[MusicDownloadDataSource alloc ] init];


     self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
     self.mainTableView.delegate = self;
     self.mainTableView.dataSource = self;
     [self.view addSubview:self.mainTableView];


     __weak typeof(self) weakSelf = self;
     self.dataSource.downloadStatusChangeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString){
          [weakSelf.mainTableView reloadData];
     };


     [self loadNewTask];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewTask) name:MpDownLoadingTask object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewTask) name:MpDownLoadCompleteDeleteTask object:nil];


     self.downLoadCompleteDataSource = [[DownLoadCompleteDataSource alloc ] init];
     [self mpDownLoadCompleteTask];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mpDownLoadCompleteTask) name:MpDownLoadCompleteTask object:nil];
}


-(void)mpDownLoadCompleteTask{
     [self.downLoadCompleteDataSource loadFinishedTasks];
     [self.mainTableView reloadData];
}

-(void)loadNewTask{

     [self.dataSource  loadUnFinishedTasks];
     [self.mainTableView reloadData];
     [self.dataSource startDownLoadUnFinishedTasks];
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if([cell respondsToSelector:@selector(setSeparatorInset:)])
     {
          [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
     }

     if([cell respondsToSelector:@selector(setLayoutMargins:)])
     {
          [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
     }
}

-(void)viewDidLayoutSubviews
{
     if([self.mainTableView respondsToSelector:@selector(setSeparatorInset:)])
     {
          [self.mainTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
     }

     if([self.mainTableView respondsToSelector:@selector(setLayoutMargins:)])
     {
          [self.mainTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
     }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section == 0)
          return 100;
     else
          return GTFixHeightFloat(140)+45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

     if(section == 0)
          return self.dataSource.unFinishedTasks.count;
     else
          return self.downLoadCompleteDataSource.finishedTasks.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if(section == 1)
          return 0.01;
     else
          return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

     if(section == 1)
     {
          UIView *headerView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
          [headerView setBackgroundColor:[UIColor clearColor]];
          return headerView;
     }
     else
          return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

     if(section == 1)
     {
          UIView *headerView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.01)];
          [headerView setBackgroundColor:[UIColor clearColor]];
          return headerView;
     }
     else
          return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     if(indexPath.section == 0)
     {
          static NSString *cellIdentifier = @"MusicDownloadListTableCell";

          MusicDownloadListTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

          if(musicListCell == nil)
          {
               musicListCell = [[MusicDownloadListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          }

          TaskEntity *taskEntity    = [self.dataSource.unFinishedTasks objectAtIndex:indexPath.row];

          [musicListCell setTaskEntity:taskEntity];
          
          return musicListCell;
     }
     else
     {
          static NSString *cellIdentifier = @"MineTableCell";

          MineTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

          if(musicListCell == nil)
          {
               musicListCell = [[MineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          }

          TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:0];

          musicListCell.name.text = taskEntity.name;
          musicListCell.img.image = [UIImage imageNamed:taskEntity.imgName];
          musicListCell.img1.image = [UIImage imageNamed:@"ic_movie_play"];

          __weak typeof(self) weakSelf = self;
          [musicListCell configurePanDelete:^(UITableView *tableView, NSIndexPath *indexPath) {

               [[MusicPartnerDownloadManager sharedInstance] deleteFile:taskEntity.downLoadUrl];
               [weakSelf.downLoadCompleteDataSource.finishedTasks removeObjectAtIndex:indexPath.section];
               [weakSelf.mainTableView reloadData];
               
          }];
          return musicListCell;
     }

     return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     
     if(indexPath.section == 1)
     {
          TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:0];
          MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:taskEntity.mpDownLoadPath]];
          [self presentViewController:moviePlayer animated:YES completion:nil];
     }
}



- (void)addRightItem
{
     __weak typeof(self) weakSelf = self;
     DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"全部删除" iconName:@"menu_delete" callBack:^(NSUInteger index, id info) {
          [weakSelf.dataSource deleAllTask];

     }];
     DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"全部开始" iconName:@"menu_download" callBack:^(NSUInteger index, id info) {
          [weakSelf.dataSource startAllTask];
     }];
     DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"全部暂停" iconName:@"menu_pause" callBack:^(NSUInteger index, id info) {
          [weakSelf.dataSource pauseAllTask];
     }];

     DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"more"];

     menuView.dropWidth = 130.f;
     menuView.titleFont = [UIFont systemFontOfSize:15.f];
     menuView.textColor = GLOBLE_GRAY_COLOR_3;
     menuView.textFont = [UIFont systemFontOfSize:13.f];
     menuView.cellSeparatorColor = UI_RGBA(229.f, 229.f, 229.f,1);
     menuView.textFont = [UIFont systemFontOfSize:15.f];
     menuView.animationDuration = 0.2f;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
