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

@implementation YYBBSDK_ShareSDK

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        [platformsRegister setupWeChatWithAppId:YYBBWeChatAppId
                                      appSecret:YYBBWeChatSecret
                                  universalLink:YYBBWeChatuniversalLink];
        
        [platformsRegister setupQQWithAppId:YYBBQQAppId
                                     appkey:YYBBQQSecret];
    }];
}

- (void)share:(YYBBShareInfo *)shareInfo sourceView:(UIView *)sourceView {
    
}

@end
