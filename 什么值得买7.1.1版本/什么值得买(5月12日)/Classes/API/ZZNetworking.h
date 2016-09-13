//
//  ZZNetworking.h
//  ZZSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpComplectionBlcok)(id responseObject, NSError *error);
@interface ZZNetworking : NSObject

+ (void)Get:(NSString *)URLString parameters:(NSMutableDictionary *)parameters complectionBlock:(HttpComplectionBlcok)complectionBlock;

@end
