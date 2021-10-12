//
//  YYBBRuntimeManager.m
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/21/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBRuntimeManager.h"
#import <YYBBSDK/YYBBNotificationConstants.h>
#import <AFNetworking/UIActivityIndicatorView+AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <SAMKeychain/SAMKeychain.h>
#import "YYBBKit.h"
#import <YYModel/NSObject+YYModel.h>

static NSString *const kLoginedUserKey           = @"kLoginedUser";              // 记录用户数据
static NSString *const kApplicationBuildVersion  = @"kApplicationBuildVersion";   // 记录build号
static NSString *const kApplicationShortVersion  = @"kApplicationShortVersion";   // 记录版本号

@implementation YYBBRuntimeManager

+ (void)load {
    YYBBRuntimeManager *runtimeClient = [YYBBRuntimeManager sharedInstance];
    [runtimeClient yybb_initialization];
}
    
+ (instancetype)sharedInstance {
    static YYBBRuntimeManager *runtimeClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        runtimeClient = [[self alloc] init];
    });
    return runtimeClient;
}

- (void)yybb_initialization {
    [self setupCurrentUser];
    [self setupAFNetwork];
    
    [self beginMonitorgNotification];
}

#pragma mark - Notification

- (void)beginMonitorgNotification {
    [self endMonitorgNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SDWebImageCacheClearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
}

- (void)endMonitorgNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

- (void)SDWebImageCacheClearMemory {
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeAll completion:^{
        
    }];
}

- (void)userDidLogin {
    [self saveUserInfo];
}

- (void)userDidLogout {
    [self clearAll];
}

// 清除
- (void)clearAll {
    [self clearUserData];
}

// 清除用户数据
- (void)clearUserData {
    self.currentUser = nil;
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:kLoginedUserKey];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

// 登录成功或获取用户信息之后, 保存用户数据
- (void)saveUserInfo {
    self.currentUser.isLogin = YES;
    NSString *userStr = [self.currentUser yy_modelToJSONString];
    [[NSUserDefaults standardUserDefaults] setValue:userStr forKey:kLoginedUserKey];
    
    [self saveUserLoginMobile:self.currentUser.mobile];
    
    // 保存build号
    [[NSUserDefaults standardUserDefaults] setValue:[UIApplication sharedApplication].appBuildVersion
                                             forKey:kApplicationBuildVersion];
    // 保存版本号
    [[NSUserDefaults standardUserDefaults] setValue:[UIApplication sharedApplication].appVersion
                                             forKey:kApplicationShortVersion];
}

// 保存用户手机号
- (void)saveUserLoginMobile:(NSString *)mobile {
    [SAMKeychain setPassword:mobile
                  forService:YYBBUserLoginService
                     account:[UIApplication sharedApplication].appBundleID];
}

- (NSString *)getUserLoginMobile {
    return [SAMKeychain passwordForService:YYBBUserLoginService account:[UIApplication sharedApplication].appBundleID];
}

// 保存用户登录密码
- (void)saveUserLoginPwd:(NSString *)pwd account:(NSString *)account{
    [SAMKeychain setPassword:pwd
                  forService:YYBBUserLoginService
                     account:account];
}

- (NSString *)getUserLoginPwdWithAccount:(NSString *)account {
    return [SAMKeychain passwordForService:YYBBUserLoginService account:account];
}

// 删除用户登录密码
- (void)deleteUserLoginPwdWithAccount:(NSString *)account {
    [SAMKeychain deletePasswordForService:YYBBUserLoginService account:account];
}

#pragma mark AfNetworking

- (void)setupAFNetwork {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

#pragma mark - Request

// 检查something, 安装了新版本, 主动退出
- (void)checkSomethingWithSourceViewController:(UIViewController *)sourceViewController {
    if ([self isLatestVersion]) {
        
    } else {
        // 主动登出
        [YYBBUserInfo userDidLogout];
    }
}

-(void)updateDeviceToService {
    // 用户数据统计(MeLive8, 春辉包装 10  后台枚举)
    if ([YYBBUserInfo currentUser].isLogin) {
        NSString *urlStr     = nil;
        NSMutableDictionary *param =[NSMutableDictionary dictionary];
        param[@"userId"]     = [YYBBUserInfo currentUser].userId;
        param[@"systemName"] = [NSString stringWithFormat:@"iOS %@",[UIDevice currentDevice].systemVersion];
        param[@"deviceName"] = [UIDevice currentDevice].machineModelName;
        param[@"platform"]   = @(YYBBCurrentAppType());
        [[YYBBJsonNetworkAPIClient sharedClient] yybb_commonRequestWithMethod:YYBBNetworkReuqetMethodPost url:urlStr parameters:param onFinished:nil];
    }
}

#pragma mark - 其他用户数据
// 用户数据
- (void)setupCurrentUser {
    NSString *userStr = [[NSUserDefaults standardUserDefaults] valueForKey:kLoginedUserKey];
    if (userStr) {
        _currentUser = [YYBBUserInfo yy_modelWithJSON:userStr];
        _currentUser.isLogin = YES;
    }
}

#pragma mark - Getter && Setter

- (BOOL)isCurrentUserLogin {
    return [self isLatestVersion] && self.currentUser.isLogin;
}

// 是否是最新版本
- (BOOL)isLatestVersion {
    // build号
    NSString *buildVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kApplicationBuildVersion];
    // 版本号
    NSString *shortVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kApplicationShortVersion];
    
    return  ([[UIApplication sharedApplication].appBuildVersion compare:buildVersion] == NSOrderedSame &&
             [[UIApplication sharedApplication].appVersion compare:shortVersion] == NSOrderedSame);
}

- (BOOL)isHaveNewVersion {
    return NO;
}

#pragma mark - Dealloc

- (void)dealloc {
    [self endMonitorgNotification];
}


@end
