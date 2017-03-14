//
//  ZZNetworking.h
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZBaseRequest.h"

@import AFNetworking;

typedef void(^HttpCompletionBlcok)(id _Nullable responseObj,  NSError * _Nullable error);
@interface ZZAPPDotNetAPIClient : AFHTTPSessionManager

+ (instancetype _Nonnull)sharedClient;

- (NSURLSessionDataTask * _Nonnull)GET:(ZZBaseRequest * _Nonnull)request completionBlock:(_Nonnull HttpCompletionBlcok)completionBlock;

- (NSURLSessionDataTask * _Nonnull)GET:(NSString * _Nonnull)URLString parameters:(NSMutableDictionary * _Nonnull)parameters completionBlock:(_Nonnull HttpCompletionBlcok)completionBlock;

+ (NSURLSessionDataTask * _Nonnull)Get:( NSString * _Nonnull)URLString parameters:(NSMutableDictionary * _Nonnull)parameters completionBlock:(_Nonnull HttpCompletionBlcok)completionBlock;

@end
