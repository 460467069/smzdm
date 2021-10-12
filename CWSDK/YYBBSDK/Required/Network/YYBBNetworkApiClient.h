//
//  YYBBFormNetworkAPIClient.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "YYBBRequestURL.h"
#import "YYBBBaseRequest.h"
#import "YYBBBaseResponse.h"
#import "YYBBBaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN
/** 缓存的Block */
typedef void(^YYBBRequestCache)(id responseCache);

@protocol YYBBAppSessionManagerDelegate <NSObject>

+ (instancetype _Nonnull)sharedClient;


// AFN请求 失败成功整合, 返回数据不做处理

- (NSURLSessionDataTask *)yybb_requestWithMethod:(YYBBNetworkReuqetMethod)method
                                             url:(NSString *)URLString
                                      parameters:(nullable id)parameters
                                 completionBlock:(YYBBCompletionBlcok)completionBlock;


/**
 服务器协议好的成功回调, 默认Post
 
 @param url url
 @param parameters 参数
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithUrl:(NSString *)url
                                         parameters:(nullable id)parameters
                                         onFinished:(nullable YYBBCompletionBlcok)finishedBlock;

/**
 服务器协议好的成功回调
 
 @param method 请求方法
 @param url url
 @param parameters 参数
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithMethod:(YYBBNetworkReuqetMethod)method
                                                   url:(NSString *)url
                                            parameters:(nullable id)parameters
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock;

/**
 服务器协议好的成功回调, 可带缓存
 
 @param method 请求方法
 @param url url
 @param parameters 参数
 @param responseCache 缓存
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithMethod:(YYBBNetworkReuqetMethod)method
                                                   url:(NSString *)url
                                            parameters:(nullable id)parameters
                                         responseCache:(nullable YYBBRequestCache)responseCache
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock;


/**
 request 对象请求  服务器协议好的成功回调
 
 @param request request对象
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithRequest:(YYBBBaseRequest *)request
                                             onFinished:(nullable YYBBCompletionBlcok)finishedBlock;


/**
 request 对象 请求  服务器协议好的成功回调
 
 @param request request对象
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithRequest:(YYBBBaseRequest *)request
                                          responseCache:(nullable YYBBRequestCache)responseCache
                                             onFinished:(nullable YYBBCompletionBlcok)finishedBlock;

/// 文件下载
/// @param urlString url
/// @param completion 完成回调
- (NSURLSessionDownloadTask *)yybb_downloadWithUrl:(NSString *)urlString
                                          filePath:(NSString *)filePath
                                        completion:(void (^)(NSURL *filePath, NSError *error))completion;

// 图片上传
- (NSURLSessionDownloadTask *)yybb_uploadWithURLString:(NSString *)URLString
                                            parameters:(NSDictionary *)parameters
                             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                              progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock;

// 网络成功数据处理, 暴露出来给flutter调用
- (void)commonHandleResponseObjec:(id)responseObject
                            error:(NSError *)error
                    responseClass:(Class)responseClass
                        itemClass:(Class)itemClass
                    responseCache:(nullable YYBBRequestCache)responseCache
                       requestUrl:(NSString *)requestUrl
                       onFinished:(nullable YYBBCompletionBlcok)finishedBlock;
@end

/**
 Body为 FormData
 */
@interface YYBBAPPBaseAPIClient : AFHTTPSessionManager<YYBBAppSessionManagerDelegate>


@end

/**
 Body为 FormData
 */
@interface YYBBFormNetworkAPIClient : YYBBAPPBaseAPIClient


@end


/**
 Body为raw json
 */
@interface YYBBJsonNetworkAPIClient : YYBBAPPBaseAPIClient


@end


NS_ASSUME_NONNULL_END
