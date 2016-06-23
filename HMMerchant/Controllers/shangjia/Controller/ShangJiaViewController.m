//
//  ShangJiaViewController.m
//  HMMerchant
//
//  Created by HRT on 16/6/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "ShangJiaViewController.h"
#import "HotModel.h"
#import "JZHomeCategoryModel.h"
#import "JZHomespecialModel.h"
#import "JZHomeLikeModel.h"
#import "HomeMenuCell.h"

@interface ShangJiaViewController ()<UITableViewDelegate,UITableViewDataSource,HomeMenuDelegate>

@property (strong, nonatomic) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *likeArray;

@property (nonatomic, strong) NSMutableArray *bannersArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *specialArray;

@end

@implementation ShangJiaViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setTitle:@"商家"];
     [self addLeftButton];


     self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
     self.tableView.delegate = self;
     self.tableView.dataSource = self;
     [self.view addSubview:self.tableView];

     [self initData];


     self.tableView.header = [JZNuomiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
     [self.tableView.header beginRefreshing];

}


-(void)initData {
     self.likeArray = [[NSMutableArray alloc] init];

     self.bannersArray = [[NSMutableArray alloc] init];
     self.categoryArray = [[NSMutableArray alloc] init];
     self.specialArray = [[NSMutableArray alloc] init];
}


-(void)loadNewData
{
     [self getHotData];
     [self getRecommendData];
}


-(void)getHotData
{
     NSString *url = @"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=40c974d176568886ad0e72516645e23f&swidth=750&terminal_type=ios&timestamp=1442906717563&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";


     [HYBNetworking getWithUrl:url refreshCache:NO success:^(id response) {

          CLogI(@"%@",response);


          
          _bannersArray = [[NSMutableArray alloc] initWithArray:[HotModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"banners"]]];
          _categoryArray = [[NSMutableArray alloc] initWithArray:[JZHomeCategoryModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"category"]]];
          _specialArray = [[NSMutableArray alloc] initWithArray:[JZHomeCategoryModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"special"]]];

          [self.tableView.header endRefreshing];

          [self.tableView reloadData];
          
     } fail:^(NSError *error) {

          [self.tableView.header endRefreshing];
          [XHToast showCenterWithText:@"网络不佳" duration:2];
     }];
}


-(void)getRecommendData
{
     NSString *url = @"http://app.nuomi.com/naserver/search/likeitem?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=faf73b65333f52c39dbe7f9e1a3ec04c&sort_type=0&swidth=750&terminal_type=ios&timestamp=1442906717567&tn=ios&tuan_size=25&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";

     [HYBNetworking getWithUrl:url refreshCache:NO success:^(id response) {

          [self.tableView.header endRefreshing];

          CLogV(@"%@",response);


          for (NSDictionary *dic in response[@"data"][@"tuan_list"])
          {
               JZHomeLikeModel *likeModel = [[JZHomeLikeModel alloc] init];

               likeModel.appoint = [NSString stringWithFormat:@"%@",dic[@"appoint"]];
               likeModel.bought_weekly = [NSString stringWithFormat:@"%@",dic[@"bought_weekly"]];
               likeModel.brand_name = [NSString stringWithFormat:@"%@",dic[@"brand_name"]];
               likeModel.comment_num = [NSString stringWithFormat:@"%@",dic[@"comment_num"]];
               likeModel.deal_id = [NSString stringWithFormat:@"%@",dic[@"deal_id"]];
               likeModel.distance = [NSString stringWithFormat:@"%@",dic[@"distance"]];
               likeModel.favour_list = [NSString stringWithFormat:@"%@",dic[@"favour_list"]];
               likeModel.groupon_price = [NSString stringWithFormat:@"%@",dic[@"groupon_price"]];
               likeModel.groupon_type = [NSString stringWithFormat:@"%@",dic[@"groupon_type"]];
               likeModel.ifvirtual = [NSString stringWithFormat:@"%@",dic[@"ifvirtual"]];
               likeModel.image = [NSString stringWithFormat:@"%@",dic[@"image"]];
               likeModel.is_card = [NSString stringWithFormat:@"%@",dic[@"is_card"]];
               likeModel.is_flash = [NSString stringWithFormat:@"%@",dic[@"is_flash"]];
               likeModel.is_latest = [NSString stringWithFormat:@"%@",dic[@"is_latest"]];
               likeModel.is_t10 = [NSString stringWithFormat:@"%@",dic[@"is_t10"]];
               likeModel.market_price = [NSString stringWithFormat:@"%@",dic[@"market_price"]];
               likeModel.groupon_new = [NSString stringWithFormat:@"%@",dic[@"new_groupon"]];
               likeModel.other_desc = [NSString stringWithFormat:@"%@",dic[@"other_desc"]];
               likeModel.pay_end_time = [NSString stringWithFormat:@"%@",dic[@"pay_end_time"]];
               likeModel.pay_start_time = [NSString stringWithFormat:@"%@",dic[@"pay_start_time"]];
               likeModel.reason = [NSString stringWithFormat:@"%@",dic[@"reason"]];
               likeModel.s = [NSString stringWithFormat:@"%@",dic[@"s"]];
               likeModel.sale_count = [NSString stringWithFormat:@"%@",dic[@"sale_count"]];
               likeModel.sale_out = [NSString stringWithFormat:@"%@",dic[@"sale_out"]];
               likeModel.score = [NSString stringWithFormat:@"%@",dic[@"score"]];
               likeModel.score_desc = [NSString stringWithFormat:@"%@",dic[@"score_desc"]];
               likeModel.short_title = [NSString stringWithFormat:@"%@",dic[@"short_title"]];
               likeModel.source = [NSString stringWithFormat:@"%@",dic[@"source"]];
               likeModel.user_distance = [NSString stringWithFormat:@"%@",dic[@"user_distance"]];
               likeModel.user_distance_poi = [NSString stringWithFormat:@"%@",dic[@"user_distance_poi"]];
               likeModel.user_distance_status = [NSString stringWithFormat:@"%@",dic[@"user_distance_status"]];
               likeModel.virtual_redirect_url = [NSString stringWithFormat:@"%@",dic[@"virtual_redirect_url"]];

               [_likeArray addObject:likeModel];
          }


          [self.tableView reloadData];

     } fail:^(NSError *error) {

          [self.tableView.header endRefreshing];
          [XHToast showCenterWithText:@"网络不佳" duration:2];
     }];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     if(_likeArray.count > 0 && _categoryArray.count >0)
     {
          NSInteger num = 5;

          if (_likeArray.count>0)
          {
               num = 1+_likeArray.count;
          }
          return num;
     }
     else
     {
          return 0;
     }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     if (indexPath.row == 0) {

          return 184;
     }else if(indexPath.row == 1){

          return 172;
     }else if (indexPath.row == 2){

          return 80;
     }else if (indexPath.row == 3){

          return 5;
     }else if (indexPath.row == 4){

          return 132;
     }else if (indexPath.row == 5){

          return 36;
     }else{

          return 96;
     }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


     if(indexPath.row == 0)
     {
          static NSString *cellIndentifier = @"menucell";
          HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
          if (cell == nil) {
               cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier menuArray:_categoryArray];
          }
          cell.delegate = self;
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          return cell;
     }
     else{

          static NSString *cellIndentifier = @"menucell";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
          if (cell == nil) {
               cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
          }
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          return cell;
     }

     return nil;
}




#pragma mark - **************** UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
