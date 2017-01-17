//
//  ZZNetworking.h
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AFNetworking;

typedef void(^HttpComplectionBlcok)(id _Nullable responseObj,  NSError * _Nullable error);
@interface ZZAPPDotNetAPIClient : AFHTTPSessionManager

+ (instancetype _Nonnull)sharedClient;

+ (void)Get:( NSString * _Nonnull )URLString parameters:( NSMutableDictionary * _Nonnull )parameters complectionBlock:(_Nonnull HttpComplectionBlcok)complectionBlock;

@end
