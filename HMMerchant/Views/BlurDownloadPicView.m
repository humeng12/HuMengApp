//
//  BlurDownloadPicView.m
//  HMMerchant
//
//  Created by HRT on 16/5/5.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "BlurDownloadPicView.h"
#import "GCD.h"
#import "UIImage+ImageEffects.h"

@interface BlurDownloadPicView()
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation BlurDownloadPicView


-(instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
     if(self)
     {
          self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
          self.imageView.alpha =0.f;
          [self addSubview:self.imageView];

     }
     return self;
}

-(void)startProgress
{
     if(self.pictureUrlString)
     {
          [GCDQueue executeInGlobalQueue:^{

               //创建请求
               NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.pictureUrlString]];
               //同步请求,会阻塞主线程(mainQueue)
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

               UIImage *image = [[UIImage alloc] initWithData:data];

               UIImage *blurImage = [image blurImage];


               [GCDQueue executeInMainQueue:^{

                     self.imageView.image = blurImage;

                    [UIView animateWithDuration:1.f animations:^{
                         self.imageView.alpha = 1.f;
                    }];
               }];

          }];
     }
}


@synthesize contentMode = _contentMode;
-(void)setContentMode:(UIViewContentMode)contentMode
{
     _contentMode = contentMode;
     self.imageView.contentMode = contentMode;
}

-(UIViewContentMode)contentMode
{
     return _contentMode;
}


@end
