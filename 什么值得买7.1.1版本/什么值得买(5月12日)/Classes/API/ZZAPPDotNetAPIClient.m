//
//  ZZNetworking.m
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZAPPDotNetAPIClient.h"
#import "AFNetworking.h"
#import "ZZNetworkHandler.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation ZZAPPDotNetAPIClient

+ (instancetype _Nonnull)sharedClient{
    static ZZAPPDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ZZAPPDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        _sharedClient.requestSerializer.timeoutInterval = 20;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sharedClient.securityPolicy = securityPolicy;
    });
    
    return _sharedClient;
}

- (void)GET:(NSString *)URLString parameters:(NSMutableDictionary *)parameters completionBlock:(HttpCompletionBlcok)completionBlock{
    
    [self configurePublicParameters:parameters];
    
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LxDBAnyVar(task.response.URL.absoluteString);
        if ([responseObject[@"error_code"] isEqualToString:@"0"]) {
            completionBlock(responseObject[@"data"], nil);
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
        completionBlock(nil, error);
    }];
    
}

- (void)GET:(ZZBaseRequest * _Nonnull)request completionBlock:(_Nonnull HttpCompletionBlcok)completionBlock {
    [self GET:request.urlStr parameters:[request mj_keyValuesWithIgnoredKeys:@[@"urlStr"]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LxDBAnyVar(task.response.URL.absoluteString);
        if ([responseObject[@"error_code"] isEqualToString:@"0"]) {
            completionBlock(responseObject[@"data"], nil);
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
        completionBlock(nil, error);
    }];
}

+ (void)Get:( NSString * _Nonnull)URLString parameters:(NSMutableDictionary * _Nonnull)parameters completionBlock:(_Nonnull HttpCompletionBlcok)completionBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [self configurePublicParameters:parameters];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        LxDBAnyVar(task.response.URL.absoluteString);
        
        if ([responseObject[@"error_code"] isEqualToString:@"0"]) {
        
            completionBlock(responseObject[@"data"], nil);
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
        completionBlock(nil, error);
//        LxDBAnyVar(task.response.URL.absoluteString);
    }];
    
}

/** 配置公共参数7.1.1版本 */
+ (void)configurePublicParameters:(NSMutableDictionary *)parameters{
    
    [parameters setValue:@"iphone" forKey:@"f"];
    [parameters setValue:@"7.1.1" forKey:@"v"];
    [parameters setValue:@"1" forKey:@"weixin"];
    
}

- (void)configurePublicParameters:(NSMutableDictionary *)parameters{
    
    [parameters setValue:@"iphone" forKey:@"f"];
    [parameters setValue:@"7.1.1" forKey:@"v"];
    [parameters setValue:@"1" forKey:@"weixin"];
    
}


@end
