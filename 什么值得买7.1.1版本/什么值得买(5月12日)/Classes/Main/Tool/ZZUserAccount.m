//
//  ZZUserAccount.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/6/22.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZUserAccount.h"

/** 通知 */
NSString *const ZZUserAccountDidHandleUserDataNotification = @"didHandleUserData";

@implementation ZZUserAccount

MJCodingImplementation

- (void)setExpirationDate:(NSDate *)expirationDate {
    _expirationDate = expirationDate;
    //是否需要进行OSS认证1, 过期, 2. 没有accessToken
    self.expired = ([[NSDate date] compare:expirationDate] == NSOrderedDescending);
}

//是否需要进行OSS认证1, 过期, 2. 没有accessToken
+ (BOOL)isNeedOauth {
    return [self accountUser] ? NO : YES;
}

/** 从沙河中解档用户对象 */
+ (instancetype)accountUser {
    ZZUserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    //只要时间过期或accessToken不存在, 就返回nil
    if (account.accessToken == nil || account.isExpired) {
        return nil;
    }
    return account;
}

- (void)setUserID:(NSString *)userID {
    [self willChangeValueForKey:NSStringFromSelector(@selector(userID))];
    _userID = userID;
    [self didChangeValueForKey:NSStringFromSelector(@selector(userID))];
}

@end
