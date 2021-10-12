//
//  YYBBNetworkEnum.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 11/6/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#ifndef YYNetworkEnum_h
#define YYNetworkEnum_h

typedef NS_ENUM(NSInteger, YYBBNetworkReuqetMethod){
    YYBBNetworkReuqetMethodGet                = 0,     // Get 请求
    YYBBNetworkReuqetMethodPost               = 1,     // Post 请求
    YYBBNetworkReuqetMethodPut                = 2,     // Put 请求
    YYBBNetworkReuqetMethodPatch              = 3,     // Patch 请求
    YYBBNetworkReuqetMethodDelete             = 4,     // Delete 请求
//    YYBBNetworkReuqetMethodHead               = 5,     // Head  请求
};


typedef NS_ENUM(NSInteger, YYBBNetworkCompleteType){
    YYBBNetworkCompleteTypeSuccess                = 0,        // 成功, 交易统一定义
    YYBBNetworkCompleteTypeFail                   = 1001,     // 操作失败
    YYBBNetworkCompleteTypeParmeterMissing        = 1002,     // 参数缺失/有误
    YYBBNetworkCompleteTypeNotLogin               = 1003,     // 没有登录, 请先登录
    YYBBNetworkCompleteTypeNoAccess               = 1004,     // 没有权限访问该资源
    YYBBNetworkCompleteTypeGetAuthFail            = 1005,     // 获取用户权限失败
    YYBBNetworkCompleteTypeFailReason             = 1006,     // 操作失败
    YYBBNetworkCompleteTypeFailMessage            = 1007,
    YYBBNetworkCompleteTypeHaveNoLoginPermissions = 1008,     // 没有登录权限
    YYBBNetworkCompleteTypeForbiddenBySupplier    = 1009,     // 账号被供应商禁用
    YYBBNetworkCompleteTypeQuotationFailReason    = 40001001, // 计价相关信息
};

#endif /* YYNetworkEnum_h */
