//
//  CouponRootViewController.m
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "CouponRootViewController.h"
#import "MusicListTableCell.h"
#import "MusicPartnerDownloadManager.h"


@interface CouponRootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView;

@property (nonatomic , strong) NSArray *discoverList;

@end

@implementation CouponRootViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setTitle:@"下载"];


     NSString *path = [[NSBundle mainBundle] pathForResource:@"Discover" ofType:@".plist"];
     self.discoverList = [NSArray arrayWithContentsOfFile:path];


     self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
     self.mainTableView.delegate = self;
     self.mainTableView.dataSource = self;
     [self.view addSubview:self.mainTableView];

     [self.mainTableView setTableFooterView:[[UIView alloc ] init]];

     [self.mainTableView  reloadData];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.discoverList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     static NSString *CellIdentifier = @"cell";

     MusicListTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

     if(musicListCell == nil)
     {
          musicListCell = [[MusicListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }

     [musicListCell setDownData:[self.discoverList objectAtIndex:indexPath.row]];
     
     return musicListCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     return GTFixHeightFloat(140)+90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *entity = [self.discoverList objectAtIndex:indexPath.row];
     NSString *downLoadUrl = [entity objectForKey:@"downLoadUrl"];

     MPTaskState taskState = [[MusicPartnerDownloadManager sharedInstance ] getTaskState:downLoadUrl];

     switch (taskState) {
          case MPTaskCompleted:
               CLogI(@"已经下载完成");
               break;
          case MPTaskExistTask:
               CLogI(@"已经在下载列表");
               break;
          case MPTaskNoExistTask:
          {
               MusicPartnerDownloadEntity *downLoadEntity = [[MusicPartnerDownloadEntity alloc] init];
               downLoadEntity.downLoadUrlString = downLoadUrl;
               downLoadEntity.extra = entity;
               [[MusicPartnerDownloadManager sharedInstance] addTaskWithDownLoadMusic:downLoadEntity];
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
