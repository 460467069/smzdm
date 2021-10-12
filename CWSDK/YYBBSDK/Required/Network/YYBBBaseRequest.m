//
//  YYBBBaseRequest.m
//  
//
//  Created by Wang_Ruzhou on 9/18/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBBaseRequest.h"
#import "YYBBBaseResponse.h"

@implementation YYBBBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _method = YYBBNetworkReuqetMethodPost;
    }
    return self;
}

- (NSDictionary *)parameters {
    return [self yy_modelToJSONObject];
}

// 当 Model 转为 JSON 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    YYBBConfigureRequestParams(dic);
    return YES;
}

@end

@implementation YYBBBaseTableRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageSize = 10;
        _page = 1;
        self.responseClass = [YYBBBaseListResponse class];
    }
    return self;
}

@end

@implementation YYBBBaseTableSearchRequest

@end
