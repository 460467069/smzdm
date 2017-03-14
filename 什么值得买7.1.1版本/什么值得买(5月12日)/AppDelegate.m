//
//  AppDelegate.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZTabBarViewController.h"
#import "ZZUserAccount.h"
#import<libkern/OSAtomic.h>
#import <RongIMKit/RongIMKit.h>
#import "ZZGlobalApperance.h"
#import "ZZNetworkHandler.h"
#import <WeiboSDK.h>
#import "AppDelegate+SDKInit.h"
#import "NSString+ZZBound.h"
#import "NSTimer+ZZAdd.h"
#import <SDWebImage/UIView+WebCacheOperation.h>
#import <IQKeyboardManagerSwift/IQKeyboardManagerSwift-Swift.h>



@interface AppDelegate ()<WeiboSDKDelegate>

@property (nonatomic, strong) ZZUserAccount *account;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [IQKeyboardManager sharedManager].enable = YES;

    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:20 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    // 向微博客户端程序注册第三方应用
    [WeiboSDK registerApp:kShareSinaWeiboKey];
    
    [self SDKInit];
    
    //初始化融云
    [self configureRongYun];
    //全局定制
    [ZZGlobalApperance configureGlobalApperance];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ZZTabBarViewController *tab = [[ZZTabBarViewController alloc] init];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
}


- (void)dealloc{
    
    [self.account removeObserver:self forKeyPath:@"userID"];
}

/** 初始化融云 */
- (void)configureRongYun{
    
    [[RCIM sharedRCIM] initWithAppKey:@"pvxdm17jxjazr"];
    
    [[RCIM sharedRCIM] connectWithToken:@"tzKb9I9fsboKoVsC2rn/yy8nIw4YEFm9bQo6U/nEZBnKYvSfMlN988HcEIWtnyo3JLfnwco2cWYfLmrYxTxSPvHCblTYo0wq" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%@", @(status));
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}


#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        
        NSDictionary *dict = authorizeResponse.mj_keyValues;
        
        ZZUserAccount *userAccount = [ZZUserAccount mj_objectWithKeyValues:dict];
        
        [NSKeyedArchiver archiveRootObject:userAccount toFile:kAccountPath];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ZZUserAccountDidHandleUserDataNotification object:nil];
    }
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}



@end
