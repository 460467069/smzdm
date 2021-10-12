//
//  YYBBSDK_ThirdLib.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/23.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSDK_PGY.h"
#import "YYBBKit.h"
#import "YYBBErrors.h"

#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>


@implementation YYBBSDK_PGY

#pragma mark - UIApplicationDelegate
- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    [self configurePGY];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
}

// PGY
- (void)configurePGY {
    // 设置用户反馈界面激活方式为三指拖动
    [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:self.yybb_config.PGYAppKey];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:self.yybb_config.PGYAppKey];
    // 检查更新
    [self yybb_checkUpdateByPGY];
}

- (void)yybb_checkUpdateByPGY {
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
}

/**
 *  检查更新回调
 *
 *  @param response 检查更新的返回结果
 */
- (void)updateMethod:(NSDictionary *)response
{
    [MBProgressHUD hideHUD];
    if (response[@"downloadURL"]) {

    } else {
        [MBProgressHUD showAutoMessage:@"已经是最新内测版本!"];
    }
}

@end
