//
//  AppDelegate+SDKInit.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "AppDelegate+SDKInit.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import <JSPatchPlatform/JSPatch.h>

#import <Bugly/Bugly.h>

@implementation AppDelegate (SDKInit)

- (void)SDKInit
{
    /*================= 调用registerApp方法来初始化ShareSDK并且初始化第三方平台 =================*/
    
    
    // 要使用的分享平台的集合, 所提供的分享方式
    NSArray *platforms = @[
                           @(SSDKPlatformTypeSinaWeibo),
                           @(SSDKPlatformTypeWechat),
                           @(SSDKPlatformTypeSMS),
                           @(SSDKPlatformTypeMail),
                           ];
    
    
    // 需要在此方法中对原平台SDK进行导入操作 (ShareSDK要调用原平台)
    SSDKImportHandler importHandler = ^ (SSDKPlatformType platformType) {
        // 配置第三方平台的参数
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo: {
                // connect 到第三方平台的主要类
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            }
            case SSDKPlatformTypeWechat: {
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            }
                // 邮件与短信是系统原生的, 不需要连接SDK(本来就没有)
            default:
                break;
        }
    };
    
    // 配置第三方分享平台的参数  (第三方分配的AppKey, AppSecret, 用来验证)
    SSDKConfigurationHandler configurationHandler = ^ (SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        // 给每个平台配置相关的信息
        switch (platformType) {
            case SSDKPlatformTypeWechat: {
                // ShareSDK提供了NSMutableDictionary的扩展, 可以快速配置信息
                [appInfo SSDKSetupWeChatByAppId:kShareWeChatKey appSecret:kShareWeChatSecret];
                break;
            }
            case SSDKPlatformTypeSinaWeibo: {
                [appInfo SSDKSetupSinaWeiboByAppKey:kShareSinaWeiboKey appSecret:kShareSinaWeiboSecret redirectUri:kShareSinaWeiboRedirectUri authType:SSDKAuthTypeBoth];
                break;
            }
                // 邮件与短信不需要相关信息, 不用配置
            default:
                break;
        }
    };

    /**
     *  初始化ShareSDK应用
     *
     *  @param appKey                   ShareSDK应用标识，可在http://mob.com中登录并创建App后获得。
     *  @param activePlatforms          使用的分享平台集合，如:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo)];
     *  @param connectHandler           导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作。具体的导入方式可以参考ShareSDKConnector.framework中所提供的方法。
     *  @param configurationHandler     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:platforms onImport:importHandler onConfiguration:configurationHandler];
    
    //用来检测回调的状态，是更新或者是执行脚本之类的，相关信息，会打印在你的控制台
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        
    }];
    
    // JSPatch
    [JSPatch startWithAppKey:kJSPatchKey];
    
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
    
    [JSPatch sync];
    
    BuglyConfig *buglyconfig = [[BuglyConfig alloc] init];
    buglyconfig.debugMode = YES;
    [Bugly startWithAppId:kBuglyAppID config:buglyconfig];
    
}

@end
