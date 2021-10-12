//
//  YYBBSDK_NativeShare.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2019/5/14.
//  Copyright © 2019年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSDK_ShareSDK.h"
#import "NSArray+YYBBAdd.h"
#import "UIViewController+YYBBAdd.h"
#import <ShareSDK/ShareSDK.h>
#import "../../../Required/YYBBConfig.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation YYBBSDK_ShareSDK

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    [self _initShareSDK];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
//    [self _initShareSDK];
}


#pragma mark - YYBBShare

- (void)share:(YYBBShareInfo *)shareInfo sourceView:(UIView *)sourceView {
    
}

#pragma mark - Private

- (void)_initShareSDK {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        [platformsRegister setupWeChatWithAppId:self.yybb_config.WeChatAppId
                                      appSecret:self.yybb_config.WeChatSecret
                                  universalLink:self.yybb_config.WeChatuniversalLink];
        
        [platformsRegister setupQQWithAppId:self.yybb_config.QQAppId
                                     appkey:self.yybb_config.QQSecret
                        enableUniversalLink:YES
                              universalLink:self.yybb_config.QQUniversalLink];
    }];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [QQApiInterface handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler API_AVAILABLE(ios(8.0)) {
    
    [QQApiInterface handleOpenUniversallink:userActivity.webpageURL delegate:self];
    return YES;
}



@end
