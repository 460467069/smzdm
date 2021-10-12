//
//  YYBBSDK_Facebook.h
//  YYBBSDK_Facebook
//
//  Created by Wang_Ruzhou on 5/13/19.
//  Copyright © 2019 yybbsdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBPlugin.h"
#import "YYBBPush.h"

// iOS10+ need UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface YYBBSDK_JPush : YYBBPlugin<UNUserNotificationCenterDelegate, YYBBPush>

@end
