//
//  ZZNetworking.h
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZBaseRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <Bugly/Bugly.h>

@import AFNetworking;

NS_ASSUME_NONNULL_BEGIN

typedef void(^HttpCompletionBlcok)(id _Nullable responseObj, NSError * _Nullable error);
@interface ZZAPPDotNetAPIClient : AFHTTPSessionManager

+ (instancetype _Nonnull)sharedClient;

- (NSURLSessionDataTask *)GET:(ZZBaseRequest *)request completionBlock:(HttpCompletionBlcok)completionBlock;

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSMutableDictionary * _Nullable)parameters completionBlock:(HttpCompletionBlcok)completionBlock;

+ (NSURLSessionDataTask *)Get:(NSString *)URLString parameters:(NSMutableDictionary * _Nullable)parameters completionBlock:(HttpCompletionBlcok)completionBlock;

@end

NS_ASSUME_NONNULL_END
