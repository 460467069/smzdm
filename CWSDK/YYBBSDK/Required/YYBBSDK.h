//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c)2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import <UIKit/UIKit.h>

#import "YYBBUserLoginDelegate.h"
#import "YYBBShare.h"
#import "YYBBPay.h"
#import "YYBBConfig.h"
#import "YYBBPush.h"
#import "YYBBEnums.h"

#ifdef __cplusplus
#define YYBBSDK_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define YYBBSDK_EXTERN	    extern __attribute__((visibility ("default")))
#endif


// YYBBSDK回调接口
@protocol YYBBSDKDelegate <NSObject>

// 必须实现, 否则崩给你看
- (BOOL)yybb_isDebug;
- (NSString *)yybb_apiBaseURL;
- (NSString *)yybb_webBaseURL;
- (NSString *)yybb_token;
- (NSDictionary *)yybb_sessionManagerHeaders;
- (NSDictionary *)yybb_configDict;
- (YYBBAppType)appType;
// 主动退出当前账户, 如token过期, 账号被禁
- (void)yybb_logoutCurrentUserWithTipStr:(NSString *)tipStr;

// 针对友盟埋点
- (void)yybb_um_beginLogPageView:(NSString *)pageName;
- (void)yybb_um_endLogPageView:(NSString *)pageName;

@optional

- (void)OnPlatformInit:(NSNotification*)notification;
- (void)OnUserLogin:(NSNotification*)notification;
- (void)OnUserLogout:(NSNotification*)notification;
- (void)OnEventCustom:(NSNotification*)notification;
- (void)OnEventUpdateRole:(NSNotification*)notification;
- (void)yybb_didReceiveNotificationMessage:(NSDictionary *)params;

@end

// YYBBSDK的核心类
// 负责插件管理和事件分发
@interface YYBBSDK : NSObject<UIApplicationDelegate, UNUserNotificationCenterDelegate, YYBBShare, YYBBPush>

@property NSInteger supportedOrientations;
@property (strong, nonatomic) YYBBConfig *config;                                 // 本地配置
@property (weak,   nonatomic) id<YYBBSDKDelegate> delegate;                       //
@property (assign, nonatomic) BOOL isReview;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *protdctParams; // 游戏商品id, 格式化后的价格名称

+ (instancetype)sharedInstance;

- (void)checkUpdateByPGY;

// 评分
- (void)appReview1;
- (void)appReview2;
- (void)appReview3;

- (NSObject*)getInterfaceByName:(NSString*)name andProtocol:(Protocol *)aProtocol;
// 获取当前显示的控制器View
- (UIView *)getView;
// 获取当前显示的控制器
- (UIViewController *)getViewController;
// 内购支付
- (void)payWithPayOrderInfo:(YYBBPayOrderInfo *)payOrderInfo completionHandler:(YYBBErrorCompletionBlock)completionHandler;


@end

YYBBSDK_EXTERN NSString* const YYBBSDKPlatformInit;
YYBBSDK_EXTERN NSString* const YYBBSDKUserLogin;
YYBBSDK_EXTERN NSString* const YYBBSDKUserLogout;
YYBBSDK_EXTERN NSString* const YYBBSDKUserVerified;
YYBBSDK_EXTERN NSString* const YYBBSDKAddedToCart;
YYBBSDK_EXTERN NSString* const YYBBSDKPayPaid;
YYBBSDK_EXTERN NSString* const YYBBSDKCustomEvent;
// 只有一个作用, 变更按钮 是否交互
YYBBSDK_EXTERN NSString* const YYBBSDKLoginResultEvent;
