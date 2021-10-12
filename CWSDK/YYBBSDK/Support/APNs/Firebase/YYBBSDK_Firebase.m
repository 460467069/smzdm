//
//  YYBBSDK_Facebook.m
//  YYBBSDK_Facebook
//                      
//  Created by Wang_Ruzhou on 5/13/19.
//  Copyright © 2019 yybbsdk. All rights reserved.
//

#import "YYBBSDK_Firebase.h"
#import <Firebase/Firebase.h>
#import "YYBBKit.h"

NSString *const kGCMMessageIDKey = @"gcm.message_id";

@interface YYBBSDK_Firebase ()<FIRMessagingDelegate>

@property (nonatomic, strong) dispatch_semaphore_t lock;
@property (nonatomic,   copy) NSString *firebaseToken;

@end

@implementation YYBBSDK_Firebase

#if 1
- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    // Use Firebase library to configure APIs
    [FIRApp configure];
    
    // [START set_messaging_delegate]
    [FIRMessaging messaging].delegate = self;
    // [END set_messaging_delegate]
    
    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    if (@available(iOS 10.0, *)) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    [application registerForRemoteNotifications];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [center addObserver:self
               selector:@selector(notifyAPNSTokenIsSet:)
                   name:@"com.firebase.iid.notif.apns-token"
                 object:nil];
    
    self.lock = dispatch_semaphore_create(0);
//    kFIRInstanceIDAPNSTokenNotification
    
    application.applicationIconBadgeNumber = 0;
}

#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}

// ios7到ios10之间调用。在方法内部可以判断[application applicationState]确定应用是前台、后台或者关闭状态，然后做出响应的响应。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    UIApplicationState state = [application applicationState];
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
    
    [self yybb_didReceiveMessage:userInfo applicationState:state];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

// ios10以上调用，应用在前台调用。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    [self yybb_didReceiveMessage:userInfo applicationState:UIApplicationStateActive];
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

// ios10以上调用，后台模式或者应用关闭状态。用户点了通知栏后调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    [self yybb_didReceiveMessage:userInfo applicationState:UIApplicationStateInactive];
    completionHandler();
}


// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
    self.firebaseToken = fcmToken;
    [self preJudge];
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    // With swizzling disabled you must set the APNs device token here.
     [FIRMessaging messaging].APNSToken = deviceToken;
}

- (void)notifyAPNSTokenIsSet:(NSNotification *)notification {
    YYBBUNLOCK(self.lock);
}


-(void)preJudge {
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        YYBBLOCK(self.lock);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self firebaseInitialize];
        });
    });
}

- (void)firebaseInitialize {
    YYBBConfig *config         = [YYBBSDK sharedInstance].config;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appID"]            = config.appId;
    params[@"channelID"]        = config.channelId;
    params[@"deviceID"]         = [UIDevice yybb_deviceId];
    params[@"firebaseToken"]    = self.firebaseToken;
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_POST:config.url.firebaseInitialize parameters:params.copy serverSuccessBlcok:^(id  _Nonnull responseObj) {
        
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)yybb_didReceiveMessage:(NSDictionary *)message applicationState:(UIApplicationState)applicationState {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
@end

                                            
