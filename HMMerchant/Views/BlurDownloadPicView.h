//
//  BlurDownloadPicView.h
//  HMMerchant
//
//  Created by HRT on 16/5/5.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurDownloadPicView : UIView
@property(nonatomic,strong) NSString *pictureUrlString;
@property(nonatomic)        UIViewContentMode contentMode;//图片显示方式

-(void)startProgress;
@end
