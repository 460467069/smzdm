//
//  YYBBSDK.m
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import "YYBBSDK.h"
#import "YYBBSafariViewController.h"
#import <StoreKit/StoreKit.h>
#import "YYBBKit.h"
#import "YYBBOther.h"

#ifdef __IPHONE_14_0
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#endif

static NSInteger const kRetryCount = 3;        // 请求失败后, 尝试次数

#define DEFINE_NOTIFICATION(name) __attribute__((visibility ("default"))) NSString* const name = @#name;

DEFINE_NOTIFICATION(YYBBSDKPlatformInit);
DEFINE_NOTIFICATION(YYBBSDKUserLogin);
DEFINE_NOTIFICATION(YYBBSDKUserLogout);
DEFINE_NOTIFICATION(YYBBSDKUserVerified);
DEFINE_NOTIFICATION(YYBBSDKAddedToCart);
DEFINE_NOTIFICATION(YYBBSDKPayPaid);
DEFINE_NOTIFICATION(YYBBSDKCustomEvent);
DEFINE_NOTIFICATION(YYBBSDKLoginResultEvent);


@interface YYBBSDK ()<SKStoreProductViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *plugins;
@property (strong, nonatomic) YYBBProductInfo *productInfo;
@property (strong, nonatomic) YYBBPaymentModel *paymentModel;
@property (strong, nonatomic) NSDictionary *pluginDict;

@property (nonatomic, assign) NSInteger serverConfigRequestRetryCount;        // 参数配置最多请求尝试次数
@property (nonatomic, assign) NSInteger languageConfigRequestRetryCount;      // 语言配置最多请求尝试次数

@end

@implementation YYBBSDK

static YYBBSDK* _instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.serverConfigRequestRetryCount = kRetryCount;
        self.languageConfigRequestRetryCount = kRetryCount;
        [self setup];
        [self beginMonitorgNotification];
    }
    return self;
}

- (void)setup {
    NSArray *configPlugins = @[
        YYBBPlugin_Adjust,
        YYBBPlugin_ThirdLib,
        YYBBPlugin_AppStore,
    ];
    _protdctParams = @{
        @"iap_12":@"$12.99",
        @"iap_14":@"$6.99",
        @"iap_2":@"$3.99",
        @"iap_22":@"$139.99",
        @"iap_3":@"$35.99",
        @"iap_4":@"$69.99",
        @"iap_15":@"$94.99",
    };
    _supportedOrientations = UIInterfaceOrientationMaskLandscape;
    _plugins = [NSMutableArray array];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (NSString *pluginName in configPlugins) {
        NSString *className = [@"YYBBSDK_" stringByAppendingString:pluginName];
        Class pluginClass = NSClassFromString(className);
        if (pluginClass != nil)
        {
            YYBBPlugin *plugin = [[pluginClass alloc] init];
            plugin.params = nil;
            [_plugins addObjectSafe:plugin];
            [dictM setValue:plugin forKey:pluginName];
        }
        else
        {
            NSLog(@"unable loadPlugin: %@", pluginName);
        }
    }
    _pluginDict = dictM.copy;
}

#pragma mark - Notification

- (void)beginMonitorgNotification {
    [self endMonitorgNotification];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationDidEnterBackground:)
                          name:UIApplicationDidEnterBackgroundNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationDidBecomeActive:)
                          name:UIApplicationDidBecomeActiveNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationWillResignActive:)
                          name:UIApplicationWillResignActiveNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationWillTerminate:)
                          name:UIApplicationWillTerminateNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationWillEnterForeground:)
                          name:UIApplicationWillEnterForegroundNotification
                        object:nil];
    
}

- (void)endMonitorgNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter removeObserver:self
                             name:UIApplicationDidEnterBackgroundNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:UIApplicationDidBecomeActiveNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:UIApplicationWillResignActiveNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:UIApplicationWillTerminateNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:UIApplicationWillEnterForegroundNotification
                           object:nil];
}

- (void)yybb_applicationDidEnterBackground:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(applicationDidEnterBackground:)]) {
        [self applicationDidEnterBackground:[UIApplication sharedApplication]];
    }
}

- (void)yybb_applicationDidBecomeActive:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(applicationDidBecomeActive:)]) {
        [self applicationDidBecomeActive:[UIApplication sharedApplication]];
    }
}

- (void)yybb_applicationWillResignActive:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(applicationWillResignActive:)]) {
        [self applicationWillResignActive:[UIApplication sharedApplication]];
    }
}

- (void)yybb_applicationWillTerminate:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(applicationWillTerminate:)]) {
        [self applicationWillTerminate:[UIApplication sharedApplication]];
    }
}

- (void)yybb_applicationWillEnterForeground:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(applicationWillEnterForeground:)]) {
        [self applicationWillEnterForeground:[UIApplication sharedApplication]];
    }
}

// 从服务器获取相关配置
- (void)getServerConfigsWithSuccessHandler:(void(^)(void))successHandler {
    self.serverConfigRequestRetryCount -= 1;
    if (self.serverConfigRequestRetryCount < 0) {
        return;
    }
    @weakify(self)
    NSString *configKey = @"";
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        configKey = @"iOS_zhiban_config";
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        configKey = @"iOS_chunhui_config";
    }
    
    NSString *urlStr = [NSString stringWithFormat:kServerToolConfig , configKey];
    [[YYBBJsonNetworkAPIClient sharedClient] yybb_commonRequestWithMethod:YYBBNetworkReuqetMethodGet url:urlStr parameters:nil onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        @strongify(self)
        if (error) {
            [self getServerConfigsWithSuccessHandler:responseObj];
            return ;
        }
//        self.config = [YYBBConfig yy_modelWithJSON:responseObj];
        if (self.config == nil) {
            [self getServerConfigsWithSuccessHandler:successHandler];
        } else {
            !successHandler ?: successHandler();
        }
    }];
}

- (void)setDelegate:(id<YYBBSDKDelegate>)obj
{
    _delegate = obj;
    [[YYBBDomainSwitchManager sharedInstance] yybb_initialization];
    if ([obj respondsToSelector:@selector(OnPlatformInit:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnPlatformInit:)
                                                     name:YYBBSDKPlatformInit
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnUserLogin:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnUserLogin:)
                                                     name:YYBBSDKUserLogin
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnUserLogout:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnUserLogout:)
                                                     name:YYBBSDKUserLogout
                                                   object:nil
         ];
    }
    
    if ([obj respondsToSelector:@selector(OnEventCustom:)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:obj
                                                 selector:@selector(OnEventCustom:)
                                                     name:YYBBSDKCustomEvent
                                                   object:nil
         ];
    }
}


- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (BOOL)IsSupportFunction:(SEL)function
{
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:function])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isInitCompleted
{
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(isInitCompleted)])
        {
            if (![plugin isInitCompleted])
            {
                return NO;
            }
        }
    }
    
    return YES;
}

- (UIView*)getView
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return vc.view;
}

- (UIViewController*)getViewController
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return vc;
}

- (NSObject*)getInterfaceByName:(NSString*)name andProtocol:(Protocol *)aProtocol
{
    for (YYBBPlugin* plugin in self.plugins) {
        NSString* pluginClassName = NSStringFromClass([plugin class]);
        
        if (![name hasPrefix:@"YYBBSDK_"])
        {
            name = [@"YYBBSDK_" stringByAppendingString:name];
        }
        if ([pluginClassName compare:name] == NSOrderedSame)
        {
            if (aProtocol == nil)
                return plugin;
            else
            {
                return [plugin getInterface:aProtocol];
            }
        }
    }
    
    return nil;
}

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            
        }];
    }
#if 0
    @weakify(self)
    [self getServerConfigsWithSuccessHandler:^{
        @strongify(self)
        for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
            if ([plugin respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)])
            {
                [plugin application:application didFinishLaunchingWithOptions:launchOptions];
            }
            if ([plugin respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
                [plugin applicationDidFinishLaunching:application];
            }
        }
    }];
#endif
    
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(yybb_application:didFinishLaunchingWithOptions:)])
        {
            [plugin yybb_application:application didFinishLaunchingWithOptions:launchOptions];
        }
        if ([plugin respondsToSelector:@selector(yybb_applicationDidFinishLaunching:)]) {
            [plugin yybb_applicationDidFinishLaunching:application];
        }
    }
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:performFetchWithCompletionHandler:)])
        {
            [plugin application:application performFetchWithCompletionHandler:completionHandler];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(applicationDidEnterBackground:)])
        {
            [plugin applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillResignActive:)])
        {
            [plugin applicationWillResignActive:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillEnterForeground:)])
        {
            [plugin applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(applicationDidBecomeActive:)])
        {
            [plugin applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(applicationWillTerminate:)])
        {
            [plugin applicationWillTerminate:application];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)])
        {
            [plugin application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)])
        {
            [plugin application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication*)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:didReceiveLocalNotification:)])
        {
            [plugin application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:didReceiveRemoteNotification:)])
        {
            [plugin application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"OpenURL options:%@",url.scheme);
    BOOL ret = NO;
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:openURL:options:)]) {
            ret |= [plugin application:application openURL:url options:options];
        }
    }
    
    return ret;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler API_AVAILABLE(ios(8.0)) {
    for (NSObject<YYBBPluginProtocol>* plugin in self.plugins) {
        if ([plugin respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)])
        {
            [plugin application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return YES;
}


#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) {
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED {
    
}

#pragma mark - Share
- (void)share:(YYBBShareInfo *)shareInfo sourceView:(UIView *)sourceView {
    id<YYBBShare> share = self.pluginDict[YYBBPlugin_NativeShare];
    [share share:shareInfo sourceView:sourceView];
}

#pragma mark - Ad
- (void)yybb_showRewardVideoWithPlacedId:(NSString *)placeId
                          successHandler:(void (^)(NSDictionary *))successHandler
                          failureHandler:(void (^)(NSError *))failureHandler {
    id<YYBBAdProtocol> ad = self.pluginDict[YYBBPlugin_UP];
    if ([ad respondsToSelector:@selector(yybb_showRewardVideoWithPlacedId:successHandler:failureHandler:)]) {
        [ad yybb_showRewardVideoWithPlacedId:placeId successHandler:successHandler failureHandler:failureHandler];
    }
}

#pragma mark - Other

- (void)checkUpdateByPGY {
    id<YYBBOther> plugin = self.pluginDict[YYBBPlugin_PGY];
    if ([plugin respondsToSelector:@selector(yybb_checkUpdateByPGY)]) {
        [plugin yybb_checkUpdateByPGY];
    }
}

#pragma mark - Review
/**
 应用内评分, 系统评分框
 只能评分，不能编写评论
 有次数限制，一年只能使用三次
 使用次数超限后，需要跳转appstore
 */
- (void)appReview1 {
    if (@available(iOS 10.3, *)) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {// iOS 10.3 以上支持
            //防止键盘遮挡
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }
    }
}

/**
 跳转到App Store
 */
- (void)appReview2 {
    NSString *appID = self.config.appStoreID;
    NSString *reviewStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewStr]];
}

/**
 应用内加载App Store页面, 玩家手动点击评论
 */
- (void)appReview3 {
    NSString *appID = self.config.appStoreID;
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = self;
    //模态弹出appstore
    [self.getViewController presentViewController:storeProductViewContorller animated:YES completion:nil];
    //加载App Store视图展示
    [storeProductViewContorller loadProductWithParameters: @{SKStoreProductParameterITunesItemIdentifier : appID} completionBlock:^(BOOL result, NSError * _Nullable error) {
        
    }];
}

// SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self.getViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// Push
- (void)setAlias:(NSString *)alias completion:(JPushAliasOperationCompletion)completion seq:(NSInteger)seq {
    id<YYBBPush> push = self.pluginDict[YYBBPlugin_JPush];
    if ([push respondsToSelector:@selector(setAlias:completion:seq:)]) {
        [push setAlias:alias completion:completion seq:seq];
    }
}

- (void)registrationIDCompletionHandler:(void (^)(int, NSString * _Nonnull))completionHandler {
    id<YYBBPush> push = self.pluginDict[YYBBPlugin_JPush];
    if ([push respondsToSelector:@selector(registrationIDCompletionHandler:)]) {
        [push registrationIDCompletionHandler:completionHandler];
    }
}

// pay
- (void)payWithPayOrderInfo:(YYBBPayOrderInfo *)payOrderInfo completionHandler:(YYBBErrorCompletionBlock)completionHandler {
    id<YYBBPay> pay = self.pluginDict[YYBBPlugin_AppStore];
    [pay payWithPayOrderInfo:payOrderInfo paymentItem:nil completionHandler:completionHandler];
}

#pragma mark - getter && setter

- (NSMutableArray *)plugins {
    if (!_plugins) {
        _plugins = [NSMutableArray array];
    }
    return _plugins;
}

- (BOOL)isReview {
    return NO;
}

- (YYBBConfig *)config {
    if (!_config) {
        _config = [YYBBConfig yy_modelWithJSON:[self.delegate yybb_configDict]];
    }
    return _config;
}

@end
