//
//  YYBBSDK_ThirdLib.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/23.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSDK_ThirdLib.h"
#import "YYBBKit.h"
#import "YYBBErrors.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <JLPermissions/JLLocationPermission.h>

@implementation YYBBSDK_ThirdLib

#pragma mark - UIApplicationDelegate
- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    [self configureKeyboardManagerPreference];
    [self _initThirdSDK];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
#if 0
    [Appirater setAppId:serverConfig.appsFlyerAppId];
    [Appirater setDaysUntilPrompt:serverConfig.iraterDays];
    [Appirater setUsesUntilPrompt:serverConfig.iraterUses];
    [Appirater setSignificantEventsUntilPrompt:serverConfig.iraterSignificantEvents];
    [Appirater setTimeBeforeReminding:serverConfig.iraterTimeBeforeReminding];
    [Appirater appLaunched:YES];
#endif
    
    [self _initThirdSDK];
}

- (void)configureKeyboardManagerPreference {
#if 1
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarTintColor = [UIColor redColor];
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 40.0f; // 输入框距离键盘的距离
    keyboardManager.shouldShowToolbarPlaceholder = NO;
    keyboardManager.enableDebugging = NO;
    keyboardManager.previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
#endif
}

- (void)configureProgressHUD {

}

#pragma mark - Private

- (void)_initThirdSDK {
#if 0
    NSString *buglyAppId = @"7c80d832cc";
    if (YYBBIsDebug()) {
        buglyAppId = @"1668d34415";
    }
    [Bugly startWithAppId:buglyAppId];
#endif
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:kMBProgressDelay];
    
    [JLLocationPermission sharedInstance].extraAlertEnabled = NO;
}

@end
