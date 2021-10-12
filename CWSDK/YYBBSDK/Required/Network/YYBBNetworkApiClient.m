//
//  YYBBFormNetworkAPIClient.m
//  YYBBSDK
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBNetworkApiClient.h"
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/NSDictionary+YYAdd.h>
#import "YYBBSDK.h"
#import "YYBBUserInfo.h"
#import "YYBBBaseResponse.h"
#import "YYBBNetworkConstants.h"
#import "YYBBRequestURL.h"
#import "YYBBNetworkCache.h"
#import "NSString+YYBBAdd.h"
#import "NSObject+YYBBAdd.h"
#import "NSData+YYBBAdd.h"
#import "NSDictionary+AES.h"
#import "YYBBUtilities.h"

static inline NSString * _Nonnull YYBBConfigureFullURLStringWithCurrentURLString(NSString * url) {
    if ([url hasPrefix:@"/"]) {
        url = [url substringFromIndexSafe:1];
    }
    if (![url hasPrefix:@"http"]) {
        NSString *baseUrlStr = [YYBBSDK sharedInstance].delegate.yybb_apiBaseURL;
        if (![baseUrlStr hasSuffix:@"/"]) {
            baseUrlStr = [NSString stringWithFormat:@"%@/", baseUrlStr];
        }
        url = [NSString stringWithFormat:@"%@%@", baseUrlStr, url];
    }
    return url.copy;
}

@implementation YYBBAPPBaseAPIClient

+ (instancetype _Nonnull)sharedClient {
    static YYBBAPPBaseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sharedClient = [[YYBBAPPBaseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[YYBBSDK sharedInstance].delegate.yybb_apiBaseURL]];
        _sharedClient.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        _sharedClient.requestSerializer.timeoutInterval = 30;
        _sharedClient.securityPolicy = securityPolicy;
    });
    
    return _sharedClient;
}

// AFN请求 失败成功整合, 返回数据不做处理
- (NSURLSessionDataTask *)yybb_requestWithMethod:(YYBBNetworkReuqetMethod)method
                                             url:(NSString *)URLString
                                      parameters:(nullable id)parameters
                                 completionBlock:(YYBBCompletionBlcok)completionBlock {
    
    URLString = YYBBConfigureFullURLStringWithCurrentURLString(URLString);
    NSDictionary *headers = [[YYBBSDK sharedInstance].delegate yybb_sessionManagerHeaders];
    @weakify(self)
    void (^successBlock)(id responseObject) = ^(id responseObject) {
        @strongify(self)
        !completionBlock ?: completionBlock(responseObject, nil);
        [self commonHandleResponseObjec:responseObject
                                  error:nil
                          responseClass:nil
                              itemClass:nil
                          responseCache:nil
                             requestUrl:URLString
                             onFinished:nil];
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error) {
        @strongify(self)
        !completionBlock ?:completionBlock(nil, error);
        [self _handleNetworkNotConnectedToInternet:error];
    };
    switch (method) {
        case YYBBNetworkReuqetMethodGet: {
            return [self GET:URLString parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodPost: {
            return [self POST:URLString parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodPut: {
            return [self PUT:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodDelete: {
            return [self DELETE:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodPatch: {
            return [self PATCH:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        default:
            break;
    }
}

/**
 服务器协议好的成功回调, 默认Post
 
 @param url url
 @param parameters 参数
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithUrl:(NSString *)url
                                         parameters:(nullable id)parameters
                                         onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    return [self yybb_commonRequestWithMethod:YYBBNetworkReuqetMethodPost
                                          url:url
                                   parameters:parameters
                                   onFinished:finishedBlock];
}

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
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    return [self yybb_commonRequestWithMethod:method
                                          url:url
                                   parameters:parameters
                                responseClass:nil
                                    itemClass:nil
                                responseCache:nil
                                   onFinished:finishedBlock];
}

- (NSURLSessionDataTask *)yybb_commonRequestWithMethod:(YYBBNetworkReuqetMethod)method
                                                   url:(NSString *)url
                                            parameters:(nullable id)parameters
                                         responseCache:(nullable YYBBRequestCache)responseCache
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    return [self yybb_commonRequestWithMethod:method
                                          url:url
                                   parameters:parameters
                                responseClass:nil
                                    itemClass:nil
                                responseCache:responseCache
                                   onFinished:finishedBlock];
    
}

/**
 Get request 对象 请求  服务器协议好的成功回调
 
 @param request request对象
 @param finishedBlock 完成回调, 其中responseObject已经取到resultData
 */
- (NSURLSessionDataTask *)yybb_commonRequestWithRequest:(YYBBBaseRequest *)request
                                             onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    return [self yybb_commonRequestWithMethod:request.method
                                          url:request.urlString
                                   parameters:[self formatParams:request.parameters]
                                responseClass:request.responseClass
                                    itemClass:request.itemClass
                                responseCache:nil
                                   onFinished:finishedBlock];
}


- (nonnull NSURLSessionDataTask *)yybb_commonRequestWithRequest:(nonnull YYBBBaseRequest *)request
                                                  responseCache:(nullable YYBBRequestCache)responseCache
                                                     onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    return [self yybb_commonRequestWithMethod:request.method
                                          url:request.urlString
                                   parameters:[self formatParams:request.parameters]
                                responseClass:request.responseClass
                                    itemClass:request.itemClass
                                responseCache:responseCache
                                   onFinished:finishedBlock];
}

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
                                         responseClass:(nullable Class)responseClass
                                             itemClass:(nullable Class)itemClass
                                         responseCache:(nullable YYBBRequestCache)responseCache
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    url = YYBBConfigureFullURLStringWithCurrentURLString(url);
    !responseCache ?: responseCache([YYBBNetworkCache getHttpCacheForKey:url]);
    NSDictionary *headers = [[YYBBSDK sharedInstance].delegate yybb_sessionManagerHeaders];
    
    @weakify(self)
    void (^successBlock)(id responseObject) = ^(id responseObject) {
        @strongify(self)
        [self commonHandleResponseObjec:responseObject
                                  error:nil
                          responseClass:responseClass
                              itemClass:itemClass
                          responseCache:responseCache
                             requestUrl:url
                             onFinished:finishedBlock];
    };
    
    void (^failureBlock)(NSError *error) = ^(NSError *error) {
        @strongify(self)
        [self commonHandleFailure:error onFinished:finishedBlock];
    };
    
    switch (method) {
        case YYBBNetworkReuqetMethodGet: {
            return [self GET:url parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
            
        case YYBBNetworkReuqetMethodPost: {
            if ([self isKindOfClass:[YYBBJsonNetworkAPIClient class]]) {
                return [self POST:url parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    !successBlock ?: successBlock(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    !failureBlock ?: failureBlock(error);
                }];
            } else if ([self isKindOfClass:[YYBBFormNetworkAPIClient class]]) {
                return [self yybb_multipartFormRequestWithURLString:url parameters:parameters constructingBodyWithBlock:nil progress:nil onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
                    if (error) {
                        !failureBlock ?: failureBlock(error);
                        return;
                    }
                    !successBlock ?: successBlock(responseObj);
                }];
            }
            break;
        }
        case YYBBNetworkReuqetMethodPut: {
            return [self PUT:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodDelete: {
            return [self DELETE:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        case YYBBNetworkReuqetMethodPatch: {
            return [self PATCH:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                !successBlock ?: successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                !failureBlock ?: failureBlock(error);
            }];
            break;
        }
        default:
            break;
    }
    
}

- (NSURLSessionDownloadTask *)yybb_downloadWithUrl:(NSString *)urlString
                                          filePath:(NSString *)filePath
                                        completion:(void (^)(NSURL *filePath, NSError *error))completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *task = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",[NSString stringWithFormat:@"%.2lldkB/%.2lldkB %.2f%%",downloadProgress.completedUnitCount/1024,downloadProgress.totalUnitCount/1024,(float)downloadProgress.completedUnitCount/downloadProgress.totalUnitCount*100.0]);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *path = [NSString stringWithFormat:@"file://%@",filePath];
        return [[NSURL URLWithString:path] URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath:%@\nerror:%@\n",[filePath absoluteString],error);
        completion(filePath,error);
    }];
    [task resume];
    return task;
}

- (NSURLSessionDownloadTask *)yybb_multipartFormRequestWithURLString:(NSString *)URLString
                                                          parameters:(NSDictionary *)parameters
                                                          onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    [self yybb_multipartFormRequestWithURLString:URLString
                                      parameters:parameters
                       constructingBodyWithBlock:nil
                                        progress:nil onFinished:finishedBlock];
}

- (NSURLSessionDownloadTask *)yybb_multipartFormRequestWithURLString:(NSString *)URLString
                                                          parameters:(NSDictionary *)parameters
                                           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                            progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                                                          onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    URLString = YYBBConfigureFullURLStringWithCurrentURLString(URLString);
    NSString *iv = [NSString getRandomStringWithLength:16];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[[YYBBSDK sharedInstance].delegate yybb_sessionManagerHeaders]];
    headers[@"iv"] = iv;
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dictM[@"timestamp"] = [NSString getNowTimeTimestamp];
    dictM[@"user_id"] = YYBBString([YYBBUserInfo currentUser].userId);
    if (!YYBBIsDebug()) {
        NSString *base64Str = [dictM encryptionWithIv:iv];
        [dictM removeAllObjects];
        dictM[@"param"] = base64Str;
    }
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *userAgent = [requestSerializer valueForHTTPHeaderField:@"User-Agent"];
    // 后台有这个判断
    [requestSerializer setValue:[NSString stringWithFormat:@"okhttp%@", userAgent] forHTTPHeaderField:@"User-Agent"];
    
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                           URLString:URLString
                                                                          parameters:dictM
                                                           constructingBodyWithBlock:block
                                                                               error:nil];
    [request setAllHTTPHeaderFields:headers];
    NSURLSessionDataTask *dataTask;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgressBlock
                        downloadProgress:nil
                       completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (YYBBIsDebug()) {
            !finishedBlock ?: finishedBlock(responseObject, error);
        } else {
            NSDictionary *dict = [NSDictionary decryptWithEncryBodyData:responseObject iv:[(NSHTTPURLResponse *)response valueForHTTPHeaderField:@"iv"]];
            !finishedBlock ?: finishedBlock(dict, error);
        }
    }];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDownloadTask *)yybb_uploadWithURLString:(NSString *)URLString
                                            parameters:(NSDictionary *)parameters
                             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                              progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                                            onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    
    URLString = YYBBConfigureFullURLStringWithCurrentURLString(URLString);
    NSDictionary *headers = [[YYBBSDK sharedInstance].delegate yybb_sessionManagerHeaders];
    @weakify(self)
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"timestamp"] = [NSString getNowTimeTimestamp];
    dictM[@"param"] = [parameters jsonStringEncoded];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:URLString
                                                                                             parameters:dictM
                                                                              constructingBodyWithBlock:block
                                                                                                  error:nil];
    [request setAllHTTPHeaderFields:headers];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [self
                  uploadTaskWithStreamedRequest:request
                  progress:uploadProgressBlock
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        @strongify(self)
        [self commonHandleResponseObjec:responseObject
                                  error:error
                          responseClass:nil
                              itemClass:nil
                          responseCache:nil
                             requestUrl:nil
                             onFinished:finishedBlock];
    }];
    
    [uploadTask resume];
    return uploadTask;
}

#pragma mark - Private

- (void)setupHttpSessionManagerHeader {
    NSDictionary *dict = [[YYBBSDK sharedInstance].delegate yybb_sessionManagerHeaders];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}


- (void)commonHandleFailure:(NSError *)error onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    [self commonHandleResponseObjec:nil
                              error:error
                      responseClass:nil
                          itemClass:nil
                      responseCache:nil
                         requestUrl:nil
                         onFinished:finishedBlock];
    [self _handleNetworkNotConnectedToInternet:error];
}

- (void)commonHandleResponseObjec:(id)responseObject
                            error:(NSError *)error
                    responseClass:(Class)responseClass
                        itemClass:(Class)itemClass
                    responseCache:(nullable YYBBRequestCache)responseCache
                       requestUrl:(NSString *)requestUrl
                       onFinished:(nullable YYBBCompletionBlcok)finishedBlock {
    if (error) {
        !finishedBlock ?: finishedBlock(nil, error);
#if 0
        NSError *networkError = [NSError errorWithDomain:YYBBErrorDomain
                                                    code:YYBBErrorNetwork
                                                userInfo:@{NSLocalizedDescriptionKey: YYBBNetworkErrorTipStr}];
        !finishedBlock ?: finishedBlock(nil, networkError);
#endif
        return;
    }
    void (^logoutBlock)(NSString *tip) = ^void(NSString *tip) {
        [YYBBUserInfo logoutWithCompletionHandler:nil];
        if ([[YYBBSDK sharedInstance].delegate respondsToSelector:@selector(yybb_logoutCurrentUserWithTipStr:)]) {
            [[YYBBSDK sharedInstance].delegate yybb_logoutCurrentUserWithTipStr:tip];
        }
    };
    YYBBGlobalResponse *response = [YYBBGlobalResponse yy_modelWithJSON:responseObject];
    BOOL isLogin = [YYBBUserInfo currentUser].isLogin;
    if (response) {
        if (response.status == YYBBNetworkCompleteTypeSuccess) {
            if (responseCache) {
                [YYBBNetworkCache saveHttpCache:response.data forKey:requestUrl];
            }
            if (responseClass) { // 直接转模型
                id dataResponseModel = nil;
                if ([response.data isKindOfClass:[NSArray class]]) {
                    YYBBBaseListResponse *listResponse =  [[responseClass alloc] init];
                    listResponse.list = [NSArray yy_modelArrayWithClass:itemClass json:response.data];
                    dataResponseModel = listResponse;
                } else if ([response.data isKindOfClass:[NSDictionary class]]) {
                    dataResponseModel = [responseClass yy_modelWithJSON:response.data];
                    // 细分列表还是普通
                    if (itemClass) {
                        YYBBBaseListResponse *baseListResponse = (YYBBBaseListResponse *)dataResponseModel;
                        NSArray *resultModels = [NSArray yy_modelArrayWithClass:itemClass json:baseListResponse.list];
                        baseListResponse.list = resultModels;
                    }
                }
                !finishedBlock ?: finishedBlock(dataResponseModel, nil);
            } else { // data数据(字典/数组)
                !finishedBlock ?: finishedBlock(response.data, nil);
            }
        } else {
            NSString *tip = YYBBFormatString(response.msg, YYBBServerErrorTipStr);
            NSError *invalidRequestError = [NSError errorWithDomain:YYBBErrorDomain
                                                               code:response.status
                                                           userInfo:@{NSLocalizedDescriptionKey: tip}];
            !finishedBlock ?: finishedBlock(nil, invalidRequestError);
        }
        
    } else {
        NSString *errorStr = YYBBNetworkErrorTipStr;
#if DEBUG
        errorStr = YYBBNetworkResponseDataInvalid;
#endif
        NSError *invalidRequestError = [NSError errorWithDomain:YYBBErrorDomain
                                                           code:YYBBErrorInvalidResponseDataFormat
                                                       userInfo:@{NSLocalizedDescriptionKey: errorStr}];
        !finishedBlock ?: finishedBlock(nil, invalidRequestError);
    }
}


#pragma mark - Private

- (void)_handleNetworkNotConnectedToInternet:(NSError *)error {
    if (error.code == kCFURLErrorNotConnectedToInternet ||
        error.code == kCFURLErrorCannotConnectToHost) {
        NSString *title = [NSString stringWithFormat:@"No internet", YYBBAppName()];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:@"You can turn on wireless LAN for this App in \"Settings\" "
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        
        UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSDictionary *)formatParams:(NSDictionary *)originalParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:originalParams];
    params[@"isShouldCache"] = nil;
    params[@"itemClass"] = nil;
    params[@"method"] = nil;
    params[@"urlString"] = nil;
    params[@"responseClass"] = nil;
    return params.copy;
}

@end

@implementation YYBBFormNetworkAPIClient

+ (instancetype _Nonnull)sharedClient {
    static YYBBFormNetworkAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sharedClient = [[YYBBFormNetworkAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[YYBBSDK sharedInstance].delegate.yybb_apiBaseURL]];
        _sharedClient.requestSerializer.timeoutInterval = 30;
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.requestSerializer = requestSerializer;
        if (YYBBIsDebug()) { // 调试状态正常解析json
            _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        } else { //
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        
        _sharedClient.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        
        _sharedClient.securityPolicy = securityPolicy;
    });
    
    return _sharedClient;
}

@end


@implementation YYBBJsonNetworkAPIClient

+ (instancetype _Nonnull)sharedClient {
    static YYBBJsonNetworkAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _sharedClient = [[YYBBJsonNetworkAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[YYBBSDK sharedInstance].delegate.yybb_apiBaseURL]];
        _sharedClient.requestSerializer.timeoutInterval = 30;
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _sharedClient.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        _sharedClient.securityPolicy = securityPolicy;
    });
    
    return _sharedClient;
}

@end
