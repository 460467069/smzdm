//
//  YYBBSDK_Facebook.m
//  YYBBSDK_Facebook
//
//  Created by Wang_Ruzhou on 5/13/19.
//  Copyright © 2019 yybbsdk. All rights reserved.
//

#import "YYBBSDK_JPush.h"
#import <AdSupport/AdSupport.h>
#import "YYBBKit.h"
#import "YYBBUtilsMacro.h"

#if JPushSwitch
#import "JPUSHService.h"
#endif

@interface YYBBSDK_JPush ()
#if JPushSwitch
<JPUSHRegisterDelegate>
#endif

@property (nonatomic,   copy) NSString *firebaseToken;

@end

@implementation YYBBSDK_JPush

#if JPushSwitch

- (BOOL)yybb_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self _initJpushWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [self _initJpushWithApplication:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - UIApplicationDelegate

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"deviceToken=%@", token);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error API_AVAILABLE(ios(3.0)) {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

// ios7到ios10之间调用。在方法内部可以判断[application applicationState]确定应用是前台、后台或者关闭状态，然后做出响应的响应。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler API_AVAILABLE(ios(7.0)) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    [self yybb_didReceiveMessage:userInfo isShouldJump:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self clearBadge];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
    openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)) {
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 从通知界面直接进入应用
    } else {
        // 从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger))completionHandler API_AVAILABLE(ios(10.0)) {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [self yybb_didReceiveMessage:userInfo isShouldJump:YES];
    }

    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
          withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)) {
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self yybb_didReceiveMessage:userInfo isShouldJump:YES];
    }
    
    completionHandler();
}

- (void)yybb_didReceiveMessage:(NSDictionary *)message
                   isShouldJump:(BOOL)isShouldJump {
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    LxDBAnyVar(state);
    if (state == UIApplicationStateActive) {
        //应用在前台，接收远程推送，会进入这个状态
    }
    else if (state == UIApplicationStateInactive) {
        //应用在后台，通过点击远程推送通知，进入这个状态
    }
    else if (state == UIApplicationStateBackground) {
        //应用在后台，收到静默推送，进入这个状态
    }
    NSLog(@"通知--%@", message);
    
    [JPUSHService handleRemoteNotification:message];
    [[YYBBSDK sharedInstance].delegate yybb_didReceiveNotificationMessage:message];
    [self clearBadge];
}

- (void)clearBadge {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - Private

- (void)_initJpushWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    application.applicationIconBadgeNumber = 0;
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions
                           appKey:self.yybb_config.JpushAppKey
                          channel:self.yybb_config.JpushChannel
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        LxDBAnyVar(registrationID);
    }];
}


#pragma mark - YYBBPush

- (void)setAlias:(NSString *)alias completion:(JPushAliasOperationCompletion)completion seq:(NSInteger)seq {
    [JPUSHService setAlias:alias completion:completion seq:0];
}

- (void)registrationIDCompletionHandler:(void (^)(int, NSString * _Nonnull))completionHandler {
    [JPUSHService registrationIDCompletionHandler:completionHandler];
}

#endif

@end

