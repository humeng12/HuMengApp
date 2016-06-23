//
//  MoHuViewController.m
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "MoHuViewController.h"
#import "UIImage+ImageEffects.h"
#import "BlurDownloadPicView.h"

@interface MoHuViewController ()
{
     UIImageView *imageView1;
}
@end

@implementation MoHuViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self addLeftButton];



     //CoreImage 实现模糊效果
     /*
      1.创建CIImage对象和CIContext对象
      2.创建CIFilter对象。CIFilter对象采用键－值形式设置参数的，这里的beginImage对象就是要处理的图片对象，它的key值是kCIInputImageKey（这个值是系统提供的），参数“inputIntensity"的值设置为[NSNumber numberWithFloat:0.8]。
      3.获取并展示图片。在CIImage中没有frame,与之类似的是extent。即在CIImage中[image extent]可以看作 UIImage中的[image frame];
      */
     UIImage *image1       = [UIImage imageNamed:@"apic20161.jpg"];
     CIImage *ciImage      = [[CIImage alloc] initWithImage:image1];
     CIContext *content    = [CIContext contextWithOptions:nil];

     CIFilter *ciFil       = [CIFilter filterWithName:@"CIGaussianBlur"];//CIGaussianBlur  CISepiaTone
     CLogI(@"%@",[ciFil attributes]);
     [ciFil setValue:ciImage forKey:kCIInputImageKey];
     [ciFil setValue:[NSNumber numberWithFloat:0.8] forKey:@"inputRadius"];//设置模糊程度

     CIImage *outImage     = [ciFil valueForKey:kCIOutputImageKey];
     CGImageRef outCgimage = [content createCGImage:outImage fromRect:[outImage extent]];
     UIImage *outUImage    = [UIImage imageWithCGImage:outCgimage];

     CGImageRelease(outCgimage);


     //UIImage+ImageEffects 的 category 模糊效果 比 CoreImage模糊效果好
     UIImage *beginInage = [image1 blurImage];
     //     UIImage *beginInage = [image1 blurImageWithRadius:100];


     imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20,10,screenWidth-40,150)];
     imageView1.image        = image1;
     [self.view addSubview:imageView1];


     //iOS8 中 UIVisualEffectView 模糊效果的使用 即时渲染
     UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
     effectView.frame = CGRectMake(20,120,200,50);
     [self.view addSubview:effectView];

     UILabel *label = [[UILabel alloc] initWithFrame:effectView.bounds];
     label.text = @"deded";
     //     [effectView.contentView addSubview:label];

     /*添加模糊子View的UIVisualEffectView*/
     UIVisualEffectView *subEffView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
     subEffView.frame = CGRectMake(20,90,200,50);
     [effectView.contentView addSubview:subEffView];
     [effectView.contentView addSubview:label];


     NSString *pictureUrlStr = @"http://f.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4ce4ea4cd4d52a6059242da6d7.jpg";
     BlurDownloadPicView *downView = [[BlurDownloadPicView alloc] initWithFrame:CGRectMake(0,imageView1.bottom+10,320,400)];
     downView.pictureUrlString = pictureUrlStr;
     downView.contentMode = UIViewContentModeScaleToFill;
     [downView startProgress];
     [self.view addSubview:downView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
