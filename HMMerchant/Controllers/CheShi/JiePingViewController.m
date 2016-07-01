//
//  JiePingViewController.m
//  HMMerchant
//
//  Created by HRT on 16/7/1.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "JiePingViewController.h"
#import "UIImage+MSTool.h"

@interface JiePingViewController ()

@end

@implementation JiePingViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     //[self captureView];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//     UIImage *newImage = [UIImage imageWithCaptureView:self.view];
//     
//     UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
     NSLog(@"%s",__func__);
}


- (void)captureView
{
     //开启图片上下文
     UIGraphicsBeginImageContext(self.view.bounds.size);

     //获取当前上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     //将self.view渲染到上下文ctx中
     [self.view.layer renderInContext:ctx];

     //获取图片
     UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

     //关闭图片上下文
     UIGraphicsEndImageContext();

     //把图片压缩成数据
     NSData *data = UIImagePNGRepresentation(newImage);
     //保存到电脑桌面
     [data writeToFile:@"/Users/hrt/Desktop/10.jpg" atomically:YES];
}


- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];

}


@end
