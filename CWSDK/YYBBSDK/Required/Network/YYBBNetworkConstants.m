//
//  YYBBNetworkConstants.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 9/6/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBNetworkConstants.h"

// 网络请求超时时间
NSTimeInterval const YYBBNetworkTimeoutInterval       = 30;

// 网络异常提示
NSString *const YYBBNetworkErrorTipStr                = @"It seems that the network is not stable, please try again later ";
NSString *const YYBBServerErrorTipStr                 = @"There seems to be a small problem, please try again later ";
NSString *const YYBBTokenInvalidTipKey                = @"token_invalid_tip_key";
NSString *const YYBBTokenInvalidTipStr                = @"Token Expired";
NSString *const YYBBRequestInvalidParameter           = @"Invalid request parameter";

// 请求字段
NSString *const YYBBNetworkRequestRegisterSourceKey   = @"register_source";
NSString *const YYBBNetworkRequestRegisterSourceValue = @"iOS";

NSString *const YYBBNetworkRequestDownSourceKey       = @"down_source";
NSString *const YYBBNetworkRequestDownSourceValue     = @"AppleStore";

NSString *const YYBBNetworkRequestLoginDeviceKey      = @"login_device";

// 响应字段
NSString *const YYBBNetworkResponseDataKey            = @"response";
NSString *const YYBBNetworkResponseMsgKey             = @"message";
NSString *const YYBBNetworkResponseStatusKey          = @"code";

NSString *const YYBBNetworkResponseMsgTokenInvalid    = @"Token Expired";
NSString *const YYBBNetworkResponseDataInvalid        = @"Unknow Error";

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

NSErrorDomain const YYBBErrorDomain = @"com.standard.ininin.cardboard";

#else

NSString *const YYBBErrorDomain = @"com.standard.ininin.cardboard";

#endif
