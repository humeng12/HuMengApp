//
//  MemberRootViewController.m
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MemberRootViewController.h"
#import "GGMovieCell.h"
#import "GGMovieModel.h"
#import "GGPlayViewCtl.h"
#import "XLVideoItem.h"
#import "XLVideoCell.h"
#import "XLVideoPlayer.h"
#import "VideoDetailViewController.h"


@interface MemberRootViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,
                                        UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
     NSIndexPath *_indexPath;
     XLVideoPlayer *_player;
     CGRect _currentPlayCellRect;
}
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic , strong)NSMutableArray *dataArr;


@property (strong, nonatomic) UITableView *exampleTableView;
@property (nonatomic, strong) NSMutableArray *videoArray;
@end

@implementation MemberRootViewController

#pragma mark 懒加载存放数据的数组
-(NSMutableArray *)dataArr{
     if (_dataArr == nil) {
          _dataArr = [[NSMutableArray alloc]init];
     }
     return _dataArr;
}


- (NSMutableArray *)videoArray {
     if (!_videoArray) {
          _videoArray = [NSMutableArray array];
     }
     return _videoArray;
}

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setTitle:@"直播"];

     //[self loadCollectionView];
     //[self registerCell];
     //[self httpRequest];
     [self fetchVideoListData];


     //self.collectionView.header = [JZNuomiHeader headerWithRefreshingTarget:self refreshingAction:@selector(httpRequest)];
     // 马上进入刷新状态
     //[self.collectionView.header beginRefreshing];

     //self.collectionView.backgroundColor = [UIColor whiteColor];


     [self loadTableView];
}


/**********************************************/

-(void)loadCollectionView
{
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
     self.flowLayout = flowLayout;
     self.collectionView = collectionView;
     self.collectionView.delegate = self;
     self.collectionView.dataSource = self;
     [self.view addSubview:self.collectionView];
}

-(void)registerCell
{
     [self.collectionView registerNib:[UINib nibWithNibName:@"GGMovieCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

-(void)httpRequest
{
     [HYBNetworking getWithUrl:@"http://www.quanmin.tv/json/play/list.json?0330152923" refreshCache:NO success:^(id response) {

          if (self.dataArr.count) {
               [self.dataArr removeAllObjects];
          }
          for (NSDictionary *dic in response[@"data"]) {
               [self.collectionView.header endRefreshing];
               GGMovieModel *GameM = [[GGMovieModel alloc]init];
               GameM.avatar = dic[@"avatar"];
               GameM.thumb  = dic[@"thumb"];
               GameM.title  = dic[@"title"];
               GameM.nick   = dic[@"nick"];
               GameM.view   = dic[@"view"];
               GameM.uid    = dic[@"uid"];
               [self.dataArr addObject:GameM];
          }
          [self.collectionView reloadData];

     } fail:^(NSError *error) {

     }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     return self.dataArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake((ScreenWidth-15)/2, (ScreenWidth-15)/2-10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *cellID = @"cell";
     GGMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     [cell setCellModel:self.dataArr[indexPath.row]];
     return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
     return UIEdgeInsetsMake(5, 5,5 , 5);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
     return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
     return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     GGMovieModel *model = self.dataArr[indexPath.row];
     GGPlayViewCtl *playCtl= [[GGPlayViewCtl alloc]initWithVideoId:model.uid];
     playCtl.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:playCtl animated:NO];
}
/**************************************************/


-(void)loadTableView
{
     UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
     self.exampleTableView = tableView;

     self.exampleTableView.delegate = self;
     self.exampleTableView.dataSource = self;
     [self.view addSubview:self.exampleTableView];
}


-(void)fetchVideoListData
{
     [HYBNetworking getWithUrl:@"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html" refreshCache:NO success:^(id response) {

          NSArray *dataArray = response[@"VAP4BFR16"];
          for (NSDictionary *dict in dataArray) {
               [self.videoArray addObject:[XLVideoItem mj_objectWithKeyValues:dict]];
          }
          [self.exampleTableView reloadData];

     } fail:^(NSError *error) {

     }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     XLVideoCell *cell = [XLVideoCell videoCellWithTableView:tableView];
     XLVideoItem *item = self.videoArray[indexPath.row];
     cell.videoItem = item;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
     [cell.videoImageView addGestureRecognizer:tap];
     cell.videoImageView.tag = indexPath.row + 100;
     return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     XLVideoItem *item = self.videoArray[indexPath.row];
     VideoDetailViewController *videoDetailViewController = [[VideoDetailViewController alloc] init];
     videoDetailViewController.videoTitle = item.title;
     videoDetailViewController.mp4_url = item.mp4_url;
     [self.navigationController pushViewController:videoDetailViewController animated:YES];
}



- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
     [_player destroyPlayer];
     _player = nil;

     UIView *view = tapGesture.view;
     XLVideoItem *item = self.videoArray[view.tag - 100];

     _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
     XLVideoCell *cell = [self.exampleTableView cellForRowAtIndexPath:_indexPath];

     _player = [[XLVideoPlayer alloc] init];
     _player.videoUrl = item.mp4_url;
     [_player playerBindTableView:self.exampleTableView currentIndexPath:_indexPath];
     _player.frame = view.bounds;

     [cell.contentView addSubview:_player];

     _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
          [player destroyPlayer];
          _player = nil;
     };
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if ([scrollView isEqual:self.exampleTableView]) {

          [_player playerScrollIsSupportSmallWindowPlay:YES];
     }
}

- (void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];

     [_player destroyPlayer];
     _player = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
