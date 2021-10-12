//
//  YYBBBaseResponse.m
//  
//
//  Created by Wang_Ruzhou on 10/11/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBBaseResponse.h"

@implementation YYBBBaseResponse

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"status" : @[@"resultCode", @"code"],
        @"msg" : @[@"resultMsg", @"message", @"err_msg"],
    };
}

@end

@implementation YYBBGlobalResponse

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    NSDictionary *dict = [super modelCustomPropertyMapper];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dict];
    params[@"data"] = @[@"data", @"resultData"];
    return params.copy;
}

@end


@implementation YYBBBaseListResponse

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"isLastPage" : @"lastPage",
        @"pageIndex" : @[@"currentPage", @"current"],
        @"totalCount" : @[@"totalCount", @"count", @"total"],
    };
}



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return nil;
}

@end
