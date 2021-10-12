//
//  YYBBSDK_AppsFlyer.m
//  YYBBSDK_AppsFlyer
//
//  Created by Killua Liu on 1/23/17.
//  Copyright © 2017 yybbsdk. All rights reserved.
//

#import "YYBBSDK_UMCAnalytics.h"
#import "YYBBKit.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMCommonLog/UMCommonLogManager.h>

@interface YYBBSDK_UMCAnalytics()

@end

@implementation YYBBSDK_UMCAnalytics

#pragma mark - UIApplicationDelegate

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    // 添加了测试设备, 不会显示在正式环境报表中
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMCommonLogManager setUpUMCommonLogManager];
//#if DEBUG
//    [UMConfigure setLogEnabled:YES];
//#else
//
//#endif
    [UMConfigure setLogEnabled:NO];
    [UMConfigure initWithAppkey:YYBBUMAppKey channel:YYBBUMChannel];
    [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
//    [MobClick setAutoPageEnabled:YES];
    //此函数在UMCommon.framework版本1.4.2及以上版本，在UMConfigure.h的头文件中加入。
    //如果用户用组件化SDK,需要升级最新的UMCommon.framework版本。
    NSString * deviceID =[UMConfigure deviceIDForIntegration];
    NSLog(@"集成测试的deviceID:%@", deviceID);
}

@end
