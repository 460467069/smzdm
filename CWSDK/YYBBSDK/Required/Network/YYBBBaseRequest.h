//
//  YYBBBaseRequest.h
//  
//
//  Created by Wang_Ruzhou on 9/18/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBBaseModel.h"
#import "YYBBNetworkEnum.h"

static inline void YYBBConfigureRequestParams(NSMutableDictionary *parms) {
    parms[@"isShouldCache"] = nil;
    parms[@"method"] = nil;
    parms[@"urlString"] = nil;
    parms[@"responseClass"] = nil;
    parms[@"itemClass"] = nil;
}

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseRequest : YYBBBaseModel<YYModel>

@property (nonatomic, assign) BOOL isShouldCache;                  // 是否缓存数据
@property (nonatomic, assign) YYBBNetworkReuqetMethod method;
@property (nonatomic,   copy) NSString *urlString;                 // 接口相对路径
@property (nonatomic, strong) Class responseClass;                 // 返回请求参数
@property (nonatomic, strong, nullable) Class itemClass;           // list中的Class类型
@property (nonatomic, copy, readonly) NSDictionary *parameters;    // 返回请求参数

@end

#pragma mark - 分页加载数据网络请求基类

@interface YYBBBaseTableRequest : YYBBBaseRequest<YYModel>

@property (nonatomic, assign) NSInteger page;    // 当前页，默认1
@property (nonatomic, assign) NSInteger pageSize;       // 分页值，默认10

@end

@interface YYBBBaseTableSearchRequest : YYBBBaseTableRequest<YYModel>

@property (nonatomic, copy) NSString *searchKey;    // 当前页，默认1

@end

NS_ASSUME_NONNULL_END
