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
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        
        _sharedClient = [[ZZAPPDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        _sharedClient.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        _sharedClient.requestSerializer.timeoutInterval = 20;
        _sharedClient.securityPolicy = securityPolicy;
        
        NSMutableDictionary *cookieDictM = [NSMutableDictionary dictionary];
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *cookie in cookies) {
            [cookieDictM setValue:cookie.value forKey:cookie.name];
        }
        [cookieDictM setValue:@"u2n7E7g8GN614PhgRRMTDF9mLo7nKcI/2MZzQ5N8TCijPn9NXBbmkw==" forKey:@"device_id"];
        NSMutableString *cookieStringM = [NSMutableString string];
        [cookieDictM enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
            [cookieStringM appendString:[NSString stringWithFormat:@"%@=%@;", key, value]];
        }];
        [_sharedClient.requestSerializer setValue:cookieStringM forHTTPHeaderField:@"Cookie"];
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSMutableDictionary *)parameters completionBlock:(HttpCompletionBlcok)completionBlock{
    
    [self configurePublicParameters:parameters];
    
    return [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

- (NSURLSessionDataTask *)GET:(ZZBaseRequest *)request completionBlock:(HttpCompletionBlcok)completionBlock {
    return [self GET:request.urlStr parameters:[request mj_keyValuesWithIgnoredKeys:@[@"urlStr"]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LxDBAnyVar(task.response.URL.absoluteString);
        if ([responseObject[@"error_code"] isEqualToString:@"0"]) {
            completionBlock(responseObject[@"data"], nil);
            return;
        }
        [SVProgressHUD showErrorWithStatus:responseObject[@"error_msg"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"似乎断开网络连接"];
        completionBlock(nil, error);
    }];
}

+ (NSURLSessionDataTask *)Get:( NSString *)URLString parameters:(NSMutableDictionary *)parameters completionBlock:(HttpCompletionBlcok)completionBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [self configurePublicParameters:parameters];
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
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
