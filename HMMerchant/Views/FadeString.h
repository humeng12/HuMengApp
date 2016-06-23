//
//  FadeString.h
//  HMMerchant
//
//  Created by HRT on 16/5/6.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadeString : UIView
/**
 *  输入文本
 */
@property (nonatomic, strong) NSString *text;


/**
 *  向右渐变消失
 */
- (void)fadeRight;
@end
