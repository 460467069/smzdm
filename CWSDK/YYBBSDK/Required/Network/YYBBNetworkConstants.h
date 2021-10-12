//
//  YYBBNetworkConstants.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 9/6/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 网络请求超时时间
FOUNDATION_EXPORT NSTimeInterval const YYBBNetworkTimeoutInterval;

// 网络异常用户提示
FOUNDATION_EXPORT NSString *const YYBBNetworkErrorTipStr;
FOUNDATION_EXPORT NSString *const YYBBServerErrorTipStr;
FOUNDATION_EXPORT NSString *const YYBBTokenInvalidTipKey;
FOUNDATION_EXPORT NSString *const YYBBTokenInvalidTipStr;

// 请求包含非法参数
FOUNDATION_EXPORT NSString *const YYBBRequestInvalidParameter;
// 请求
FOUNDATION_EXPORT NSString *const YYBBNetworkRequestRegisterSourceKey;
FOUNDATION_EXPORT NSString *const YYBBNetworkRequestRegisterSourceValue;

FOUNDATION_EXPORT NSString *const YYBBNetworkRequestDownSourceKey;
FOUNDATION_EXPORT NSString *const YYBBNetworkRequestDownSourceValue;

FOUNDATION_EXPORT NSString *const YYBBNetworkRequestLoginDeviceKey;

// 响应
FOUNDATION_EXPORT NSString *const YYBBNetworkResponseDataKey;
FOUNDATION_EXPORT NSString *const YYBBNetworkResponseMsgKey;
FOUNDATION_EXPORT NSString *const YYBBNetworkResponseStatusKey;
FOUNDATION_EXPORT NSString *const YYBBNetworkResponseMsgTokenInvalid;
FOUNDATION_EXPORT NSString *const YYBBNetworkResponseDataInvalid;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

FOUNDATION_EXPORT NSErrorDomain const YYBBErrorDomain;

#else

FOUNDATION_EXPORT NSString *const YYBBErrorDomain;

#endif

/**
 YYBBError
 Error codes for YYBBErrorDomain.
 */
typedef NS_ERROR_ENUM(YYBBErrorDomain, YYBBError)
{
    /**
     Reserved.
     */
    YYBBErrorReserved = 0,
    
    /**
     The error code for errors from invalid encryption on incoming encryption URLs.
     */
    YYBBErrorEncryption,
    
    /**
     The error code for errors from invalid arguments to SDK methods.
     */
    YYBBErrorInvalidArgument,
    
    // 返回数据不是字典类型的json字符
    YYBBErrorInvalidResponseDataFormat,
    
    /**
     The error code for unknown errors.
     */
    YYBBErrorUnknown,
    
    /**
     A request failed due to a network error. Use NSUnderlyingErrorKey to retrieve
     the error object from the NSURLSession for more information.
     */
    YYBBErrorNetwork,
    
    /**
     The error code for errors encountered during an App Events flush.
     */
    YYBBErrorAppEventsFlush,
    
    /**
     An endpoint that returns a binary response was used with YDGraphRequestConnection.
     
     Endpoints that return image/jpg, etc. should be accessed using NSURLRequest
     */
    YYBBErrorGraphRequestNonTextMimeTypeReturned,
    
    /**
     The operation failed because the server returned an unexpected response.
     
     You can get this error if you are not using the most recent SDK, or you are accessing a version of the
     Graph API incompatible with the current SDK.
     */
    YYBBErrorGraphRequestProtocolMismatch,
    
    /**
     The Graph API returned an error.
     
     See below for useful userInfo keys (beginning with YDGraphRequestError*)
     */
    YYBBErrorGraphRequestGraphAPI,
    
    /**
     The specified dialog configuration is not available.
     
     This error may signify that the configuration for the dialogs has not yet been downloaded from the server
     or that the dialog is unavailable.  Subsequent attempts to use the dialog may succeed as the configuration is loaded.
     */
    YYBBErrorDialogUnavailable,
    
    YYBBErrorAccessTokenInvalid,
    /**
     Indicates an operation failed because a required access token was not found.
     */
    YYBBErrorAccessTokenRequired,
    
    /**
     Indicates an app switch (typically for a dialog) failed because the destination app is out of date.
     */
    YYBBErrorAppVersionUnsupported,
    
    /**
     Indicates an app switch to the browser (typically for a dialog) failed.
     */
    YYBBErrorBrowserUnavailable,
};


NS_ASSUME_NONNULL_END
