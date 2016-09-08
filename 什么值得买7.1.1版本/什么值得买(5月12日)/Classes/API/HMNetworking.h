//
//  HMNetworking.h
//  HMSMZDM
//
//  Created by Wang_ruzhou on 16/8/18.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpComplectionBlcok)(id responseObject, NSError *error);
@interface HMNetworking : NSObject

+ (void)Get:(NSString *)URLString parameters:(NSMutableDictionary *)parameters complectionBlock:(HttpComplectionBlcok)complectionBlock;

@end
