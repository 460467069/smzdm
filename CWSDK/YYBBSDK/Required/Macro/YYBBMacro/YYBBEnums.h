//
//  YYBBEnums.h
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/31/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#ifndef YYBBEnums_h
#define YYBBEnums_h

#import "NSObject+YYBBAdd.h"

typedef NS_ENUM(NSUInteger, YYBBAppType) {
    YYBBAppTypeMeLive  = 8,   // MeLive
    YYBBAppTypeOther   = 10,  //
};

typedef NS_ENUM(NSUInteger, YYBBGenderType) {
    YYBBGenderTypeUnknown  = 0,   // 
    YYBBGenderTypeMale     = 2,   // 男
    YYBBGenderTypeFemale   = 1,   // 女
};

typedef NS_ENUM(NSUInteger, YYBBLoginType) {
    YYBBLoginTypeSmsCode  = 1,
    YYBBLoginTypePwd      = 2,
};


static inline NSString * _Nonnull YYBBGenderTypeStr(YYBBGenderType type) {
    NSString *str = nil;
    switch (type) {
        case YYBBGenderTypeUnknown:
            str = @"Unknown";
            break;
        case YYBBGenderTypeMale:
            str = @"Male";
            break;
        case YYBBGenderTypeFemale:
            str = @"Female";
            break;
        default:
            break;
    }
    return str;
}

typedef NS_ENUM(NSUInteger, YYBBUpdateUserInfoFrom) {
    YYBBUpdateUserInfoFromFirstLogin     = 1,   // 首次登陆
    YYBBUpdateUserInfoFromPersonalCenter = 2,   // 用户个人中心/设置
};

// 呼叫方式
typedef NS_ENUM(NSUInteger, YYBBVideoCallType) {
    YYBBVideoCallTypeDefault    = 1,   // 直接呼叫
    YYBBVideoCallTypeTransfer   = 2,   // 呼叫转移
};

// 哪个页面发起的呼叫
typedef NS_ENUM(NSUInteger, YYBBVideoCallScene) {
    YYBBVideoCallSceneDefault = 1,   // 默认
    YYBBVideoCallSceneMatch   = 2,   // 匹配
};

// 呼叫结果
typedef NS_ENUM(NSUInteger, YYBBVideoCallResponseStatus) {
    YYBBVideoCallResponseStatusSuccess     = 1,             // 可以呼叫
    YYBBVideoCallResponseStatusErrorDiamondNotEnough = 2,   // 钻石不足
    YYBBVideoCallResponseStatusErrorInBlacklist = 3,        // 呼叫失败, 被拉黑
};

// 呼叫结果
typedef NS_ENUM(NSUInteger, YYBBUserRelationType) {
    YYBBUserRelationTypeDefault     = 0,   // 无关系
    YYBBUserRelationTypeFriends     = 1,   // 好友
    YYBBUserRelationTypeBlackList   = 2,   // 拉黑
};


#endif /* YYBBEnums_h */
