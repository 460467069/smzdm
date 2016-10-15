//
//  ZZNetworking.h
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpComplectionBlcok)(id _Nullable responseObj,  NSError * _Nullable error);
@interface ZZNetworking : NSObject

+ (void)Get:( NSString * _Nonnull )URLString parameters:( NSMutableDictionary * _Nonnull )parameters complectionBlock:(_Nonnull HttpComplectionBlcok)complectionBlock;

@end
