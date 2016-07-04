//
//  HMNetworking.m
//  HMMerchant
//
//  Created by HRT on 16/7/4.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "HMNetworking.h"
#import <Foundation/NSData.h>

@interface HMNetworking()<NSURLSessionDelegate>

@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation HMNetworking


+(HMNetworking *)sharedManager{


     static HMNetworking *mamager = nil;

     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{

          mamager = [[HMNetworking alloc] init];
     });

     return mamager;
}


+(void)post:(NSString *)url withParam:(NSDictionary *)dic
{

     //1.创建会话对象
     NSURLSession *session = [NSURLSession sharedSession];

     //2.根据会话对象创建task
     NSURL *urlStr = [NSURL URLWithString:url];

     //3.创建可变的请求对象
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr];

     //4.修改请求方法为POST
     request.HTTPMethod = @"POST";

     request.timeoutInterval = 60;

     [request setValue:@"application/jason" forHTTPHeaderField:@"Content-Type"];

     NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];

     //5.设置请求体
     request.HTTPBody = data;

     NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          //8.解析数据
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
           NSLog(@"%@",dict);
     }];

     //7.执行任务
     [dataTask resume];
}

-(void)post1:(NSString *)url withParam:(NSDictionary *)dic{


     NSURL *urlStr = [NSURL URLWithString:url];

     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr];

     request.HTTPMethod = @"POST";

     [request setValue:@"application/jason" forHTTPHeaderField:@"Content-Type"];

     NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];

     request.HTTPBody = data;


     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

     NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];

     [dataTask resume];
}


//1.接收到服务器响应的时候调用该方法
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
     //在该方法中可以得到响应头信息，即response
     NSLog(@"didReceiveResponse--%@",[NSThread currentThread]);

     //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
     //默认是取消的
      /*
             NSURLSessionResponseCancel = 0,        默认的处理方式，取消
             NSURLSessionResponseAllow = 1,         接收服务器返回的数据
             NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
             NSURLSessionResponseBecomeStream        变成一个流
     */
     completionHandler(NSURLSessionResponseAllow);

}


//2.接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
     NSLog(@"didReceiveData--%@",[NSThread currentThread]);
     //拼接服务器返回的数据
//     if(self.responseData)
          self.responseData = [[NSMutableData alloc] init];
     [self.responseData appendData:data];

}


//3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
     NSLog(@"didCompleteWithError--%@",[NSThread currentThread]);
     if(error == nil)
     {
          //解析数据,JSON解析请参考http://www.cnblogs.com/wendingding/p/3815303.html
          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:nil];
          NSLog(@"%@",dict);
     }

}


@end
