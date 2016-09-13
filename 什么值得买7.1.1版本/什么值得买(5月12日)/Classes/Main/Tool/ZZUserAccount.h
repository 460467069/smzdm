
//  ZZUserAccount.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/6/22.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 表情选中的通知
extern NSString * const ZZUserAccountDidHandleUserDataNotification;


@interface ZZUserAccount : NSObject

/**
 用户ID
 */
@property (nonatomic, strong) NSString *userID;

/**
 认证口令
 */
@property (nonatomic, strong) NSString *accessToken;

/**
 认证过期时间
 */
@property (nonatomic, strong) NSDate *expirationDate;

/**
 当认证口令过期时用于换取认证口令的更新口令
 */
@property (nonatomic, strong) NSString *refreshToken;

/** 登陆是否过期 */
@property (nonatomic, assign, getter=isExpired)BOOL expired;

/** 是否需要进行OSS认证 */
+ (BOOL)isNeedOauth;


+ (instancetype)accountUser;

@end
