//
//  HMUserAccount.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/6/22.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMUserAccount.h"

/** 通知 */
NSString *const HMUserAccountDidHandleUserDataNotification = @"didHandleUserData";

@implementation HMUserAccount

MJCodingImplementation

- (void)setExpirationDate:(NSDate *)expirationDate{
    _expirationDate = expirationDate;
    
    //是否需要进行OSS认证1, 过期, 2. 没有accessToken
    self.expired = ([[NSDate date] compare:expirationDate] == NSOrderedDescending);
    
    
}

//是否需要进行OSS认证1, 过期, 2. 没有accessToken
+ (BOOL)isNeedOauth {
    
    return [self accountUser] ? NO : YES;
    
}

/** 从沙河中解档用户对象 */
+ (instancetype)accountUser{
    
    HMUserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    //只要时间过期或accessToken不存在, 就返回nil
    if (account.accessToken == nil || account.isExpired) {
        return nil;
    }
    
    return account;
    
}

@end
