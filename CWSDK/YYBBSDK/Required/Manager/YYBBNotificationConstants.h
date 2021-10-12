//
//  YYBBNetworkConstants.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 9/6/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSNotificationName const YYBBUserTokenInvalidNotification;
FOUNDATION_EXPORT NSNotificationName const YYBBUserNeedLoginNotification;
FOUNDATION_EXPORT NSNotificationName const YYBBUserDidLoginNotification;
FOUNDATION_EXPORT NSNotificationName const YYBBUserDidLogoutNotification;


// TabBar按钮点击
FOUNDATION_EXPORT NSNotificationName const YYBBTabBarClickNotification;
FOUNDATION_EXPORT NSNotificationName const YYBBTabBarClickNotificationKey;

// 主播端需要进行视频评价
FOUNDATION_EXPORT NSNotificationName const YYBBCallerNeedEvaluationNotification;
FOUNDATION_EXPORT NSNotificationName const YYBBCallerNeedEvaluationNotificationKey;

NS_ASSUME_NONNULL_END
