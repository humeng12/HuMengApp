//
//  HMNetworking.h
//  HMMerchant
//
//  Created by HRT on 16/7/4.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNetworking : NSObject

+(HMNetworking *)sharedManager;



+(void)post:(NSString *)url withParam:(NSDictionary *)dic;


-(void)post1:(NSString *)url withParam:(NSDictionary *)dic;

@end
