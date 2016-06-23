//
//  HomeMenuCell.m
//  HMMerchant
//
//  Created by HRT on 16/6/8.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "HomeMenuCell.h"
#import "JZHomeCategoryModel.h"


@interface HomeMenuCell()<UIScrollViewDelegate>
{
     UIView *_backView1;
     UIView *_backView2;
     UIPageControl *_pageControl;
}

@end

@implementation HomeMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray{

     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if(self)
     {
          _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 160)];
          _backView2 = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, 160)];

          UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 180)];
          scrollView.contentSize = CGSizeMake(2*screenWidth, 180);
          scrollView.pagingEnabled = YES;
          scrollView.delegate = self;
          scrollView.showsHorizontalScrollIndicator = NO;

          [scrollView addSubview:_backView1];
          [scrollView addSubview:_backView2];
          [self addSubview:scrollView];

          for (int i = 0; i < 20; i++) {


               JZHomeCategoryModel *categoryM = menuArray[i];

               if (i < 5) {

                    CGRect frame = CGRectMake(i*screenWidth/5, 0, screenWidth/5, 80);
                    NSString *title = categoryM.category_name;
                    NSString *imageStr1 = categoryM.category_picurl;
                    NSString *imageStr = @"icon_homepage_entertainmentCategory";

                    UIView *menubackView = [[UIView alloc] initWithFrame:frame];
                    menubackView.tag = 10+i;
                    [_backView1 addSubview:menubackView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [menubackView addGestureRecognizer:tap];

                    CGFloat frameWidth = frame.size.width;

                    //图
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr1] placeholderImage:[UIImage imageNamed:imageStr]];
                    [menubackView addSubview:imageView];


                    //文字
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
                    titleLabel.font = [UIFont systemFontOfSize:12];
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.text = title;
                    [menubackView addSubview:titleLabel];
               }else if (i < 10){

                    CGRect frame = CGRectMake((i-5)*screenWidth/5, 80, screenWidth/5, 80);
                    NSString *title = categoryM.category_name;
                    NSString *imageStr1 = categoryM.category_picurl;
                    NSString *imageStr = @"icon_homepage_entertainmentCategory";

                    //换掉
                    UIView *menubackView = [[UIView alloc] initWithFrame:frame];
                    menubackView.tag = 10+i;
                    [_backView1 addSubview:menubackView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [menubackView addGestureRecognizer:tap];

                    CGFloat frameWidth = frame.size.width;

                    //图
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr1] placeholderImage:[UIImage imageNamed:imageStr]];
                    [menubackView addSubview:imageView];
                    //文字
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
                    titleLabel.font = [UIFont systemFontOfSize:12];
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.text = title;
                    [menubackView addSubview:titleLabel];
               }else if (i < 15){


                    CGRect frame = CGRectMake((i-10)*screenWidth/5, 0, screenWidth/5, 80);
                    NSString *title = categoryM.category_name;
                    NSString *imageStr1 = categoryM.category_picurl;
                    NSString *imageStr = @"icon_homepage_entertainmentCategory";

                    //换掉
                    UIView *menubackView = [[UIView alloc] initWithFrame:frame];
                    menubackView.tag = 10+i;
                    [_backView2 addSubview:menubackView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [menubackView addGestureRecognizer:tap];

                    CGFloat frameWidth = frame.size.width;


                    //图
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr1] placeholderImage:[UIImage imageNamed:imageStr]];
                    [menubackView addSubview:imageView];
                    //文字
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
                    titleLabel.font = [UIFont systemFontOfSize:12];
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.text = title;
                    [menubackView addSubview:titleLabel];
               }else{

                    CGRect frame = CGRectMake((i-15)*screenWidth/5, 80, screenWidth/5, 80);
                    NSString *title = categoryM.category_name;
                    NSString *imageStr1 = categoryM.category_picurl;
                    NSString *imageStr = @"icon_homepage_entertainmentCategory";

                    //换掉
                    UIView *menubackView = [[UIView alloc] initWithFrame:frame];
                    menubackView.tag = 10+i;
                    [_backView2 addSubview:menubackView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [menubackView addGestureRecognizer:tap];

                    CGFloat frameWidth = frame.size.width;
                    //图
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr1] placeholderImage:[UIImage imageNamed:imageStr]];
                    [menubackView addSubview:imageView];
                    //文字
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
                    titleLabel.font = [UIFont systemFontOfSize:12];
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.text = title;
                    [menubackView addSubview:titleLabel];
               }
          }

          _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screenWidth/2-20, 160, 0, 20)];
          _pageControl.currentPage = 0;
          _pageControl.numberOfPages = 2;
          [self addSubview:_pageControl];
          
          [_pageControl setCurrentPageIndicatorTintColor:navigationBarColor];
          [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
     }

     return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{

     [self.delegate homeMenuDidSelectedAtIndex:sender.view.tag];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     CGFloat scrollViewW = scrollView.frame.size.width;
     CGFloat x = scrollView.contentOffset.x;
     int page = (x + scrollViewW/2)/scrollViewW;
     _pageControl.currentPage = page;
}

@end
