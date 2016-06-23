//
//  RootViewController.m
//  HMMerchant
//
//  Created by HRT on 16/4/18.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "RootViewController.h"
#import "GGMovieCell.h"
#import "GGRecomHeaderView.h"
#import "GGMovieModel.h"
#import "GGBaseCell.h"
#import "GGPlayViewCtl.h"

@interface RootViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic , strong) UICollectionView *collectionView;
@property(nonatomic , strong) UICollectionViewFlowLayout *flowLayout;

@property(nonatomic , strong) NSMutableArray  *tempArrC;
@property(nonatomic , strong) NSMutableArray  *tempArrD;
@property(nonatomic , strong) NSMutableDictionary *dataDic;

@end

@implementation RootViewController


#pragma mark 懒加载存放数据的数组
-(NSMutableArray *)tempArrC{
     if (_tempArrC == nil) {
          _tempArrC = [[NSMutableArray alloc]init];
     }
     return _tempArrC;
}
-(NSMutableArray *)tempArrD{
     if (_tempArrD == nil) {
          _tempArrD = [[NSMutableArray alloc]init];
     }
     return _tempArrD;
}
-(NSMutableDictionary *)dataDic{
     if (_dataDic == nil) {
          _dataDic = [NSMutableDictionary dictionary];
     }
     return _dataDic;
}

- (void)viewDidLoad {

     [super viewDidLoad];
     [self setTitle:@"视频"];

     [self reloadCollectionView];
     [self registerCell];

     [self httpRequest];

     self.collectionView.header = [JZNuomiHeader headerWithRefreshingTarget:self refreshingAction:@selector(httpRequest)];
     [self.collectionView.header beginRefreshing];
}


-(void)reloadCollectionView
{
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
     self.flowLayout = flowLayout;
     self.collectionView = collectionView;
     self.collectionView.delegate = self;
     self.collectionView.dataSource = self;
     [self.view addSubview:self.collectionView];
     self.collectionView.backgroundColor = [UIColor whiteColor];
}

-(void)registerCell
{
     [self.collectionView registerNib:[UINib nibWithNibName:@"GGMovieCell" bundle:nil] forCellWithReuseIdentifier:@"GGMovieCell"];
     [self.collectionView registerNib:[UINib nibWithNibName:@"GGRecomHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GGRecomHeaderView"];
}


-(void)httpRequest
{
     [HYBNetworking getWithUrl:@"http://www.quanmin.tv/json/page/appv2-index/info.json?0330152228" refreshCache:NO success:^(id response) {

          if (self.dataDic)
          {
               [self.dataDic removeAllObjects];
               [self.tempArrC removeAllObjects];
               [self.tempArrD removeAllObjects];
          }

          self.tempArrC = [NSMutableArray array];
          for (NSDictionary *dic in response[@"list"])
          {
               GGRecomHeaderModel *headerModel = [[GGRecomHeaderModel alloc]init];
               headerModel.name = dic[@"name"];
               headerModel.slug = dic[@"slug"];
               [self.tempArrC addObject:headerModel];
          }

          NSArray *classArr = @[@"app-recommendation",@"app-lol",@"app-beauty",@"app-webgame",@"app-dota2",@"app-heartstone",@"app-tvgame",@"app-blizzard",@"app-sport",@"app-dnf",@"app-minecraft"];
          self.tempArrD = [NSMutableArray array];

          for (int i = 0; i<classArr.count; i++)
          {
               NSMutableArray *tempArr = [NSMutableArray array];
               for (NSDictionary *Dic in response[classArr[i]])
               {
                    GGMovieModel *GameM = [[GGMovieModel alloc]init];
                    GameM.avatar = Dic[@"link_object"][@"avatar"];
                    GameM.thumb  = Dic[@"link_object"][@"thumb"];
                    GameM.title  = Dic[@"link_object"][@"title"];
                    GameM.nick   = Dic[@"link_object"][@"nick"];
                    GameM.view   = Dic[@"link_object"][@"view"];
                    GameM.uid    = Dic[@"link_object"][@"uid"];
                    [tempArr addObject:GameM];
               }
               if (tempArr)
               {
                    [self.tempArrD addObject:tempArr];
               }
          }

          [self.dataDic setObject:self.tempArrC forKey:@"C"];
          [self.dataDic setObject:self.tempArrD forKey:@"D"];
          [self.collectionView reloadData];

          [self.collectionView.header endRefreshing];

     } fail:^(NSError *error) {

     }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     return self.tempArrD.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     if (section == 0)
     {
          return 2;
     }
     else if(section > 0)
     {
          NSArray *arr = self.tempArrD[section];
          if (arr.count>=2&&arr.count < 4) {
               return 2;
          }else if (arr.count>=4){
               return 4;
          }

     }
     return 1;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

     return CGSizeMake((screenWidth-20)/2, (screenWidth-20)/2-10);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellID = nil;
     cellID = @"GGMovieCell";
     
     GGBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     NSArray *arr = self.tempArrD[indexPath.section];
     if(arr.count > 0)
     {
          GGMovieModel *model = arr[indexPath.row];
          [cell setCellModel:model];
     }
     return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

     return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

     if ([kind isEqualToString:UICollectionElementKindSectionHeader])
     {
          GGRecomHeaderView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GGRecomHeaderView" forIndexPath:indexPath];
          if (indexPath.section == 0) {
               [reusableView.goUp setTitle:@"换一换" forState:UIControlStateNormal];
          }else{
               [reusableView.goUp setTitle:@"进去看看" forState:UIControlStateNormal];
          }
          reusableView.recomHeaderModel = self.tempArrC[indexPath.section+2];
          return reusableView;
     }

     return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

     return CGSizeMake(screenWidth, 40);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

     NSArray *arr = self.tempArrD[indexPath.section];
     GGMovieModel *model = arr[indexPath.row];
     GGPlayViewCtl *playCtl= [[GGPlayViewCtl alloc]initWithVideoId:model.uid];
     playCtl.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:playCtl animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
