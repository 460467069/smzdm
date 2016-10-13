//
//  ZZNetworking.m
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZNetworking.h"
#import "AFNetworking.h"
#import "ZZNetworkHandler.h"
#import "AFNetworkActivityIndicatorManager.h"
#define ZZBaseURL @"http://api.smzdm.com"

@implementation ZZNetworking


+ (void)Get:(NSString *)URLString parameters:(NSMutableDictionary *)parameters complectionBlock:(HttpComplectionBlcok)complectionBlock{
    
//    ZZNetworkHandler *handler = [ZZNetworkHandler sharedInstance];
//    if (handler.networkError) {
//        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
//        return;
//    }
//    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:ZZBaseURL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [self configurePublicParameters:parameters];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        LxDBAnyVar(task.response.URL.absoluteString);
        
        if ([responseObject[@"error_code"] isEqualToString:@"0"]) {
        
            complectionBlock(responseObject[@"data"], nil);
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
        complectionBlock(nil, error);
        LxDBAnyVar(task.response.URL.absoluteString);
    }];
    
}

/** 配置公共参数7.1.1版本 */
+ (void)configurePublicParameters:(NSMutableDictionary *)parameters{
    
    [parameters setValue:@"iphone" forKey:@"f"];
    [parameters setValue:@"7.1.1" forKey:@"v"];
    [parameters setValue:@"1" forKey:@"weixin"];
    
}


@end
