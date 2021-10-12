//
//  YYBBUserInfo.m
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/21/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBUserInfo.h"
#import "YYBBRuntimeManager.h"
#import <YYBBSDK/YYBBNotificationConstants.h>
#import <YYBBSDK/YYBBUtilsMacro.h>
#import <YYBBSDK/UIDevice+YYBBAdd.h>
#import <YYBBSDK/YYBBUtilities.h>
#import "YYBBConfig.h"
#import "YYBBNetworkApiClient.h"
#import "YYBBNotificationConstants.h"
#import "NSNotificationCenter+YYAdd.h"
#import "YYBBNetworkConstants.h"
#import <YYCategories/UIDevice+YYAdd.h>
#import <YYCategories/NSDictionary+YYAdd.h>
#import <AdSupport/AdSupport.h>

#if JPushSwitch
//#import "JPUSHService.h"
#endif

static NSString * const kYYBBBossId = @"740016";

@implementation YYBBUserInfo

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"videos" : @"YYBBVideo"};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"aboutMe"]          = @"about_me";
    dictM[@"age"]              = @"age";
    dictM[@"avatar"]           = @"avatar";
    dictM[@"country"]          = @"country";
    dictM[@"countryCode"]      = @"country_code";
    dictM[@"countryIcon"]      = @"country_icon";
    dictM[@"datingPurpose"]    = @"dating_purpose";
    dictM[@"diamond"]          = @"diamond";
    dictM[@"distance"]         = @"distance";
    dictM[@"expectation"]      = @"expectation";
    dictM[@"follower"]         = @"follower";
    dictM[@"height"]           = @"height";
    dictM[@"intimate"]         = @"intimate";
    dictM[@"introduction"]     = @"introduction";
    dictM[@"isFollow"]         = @"is_follow";
    dictM[@"isSh"]             = @"is_sh";
    dictM[@"isVip"]            = @"is_vip";
    dictM[@"isZhubo"]          = @"is_zhubo";
    dictM[@"lookingFor"]       = @"looking_for";
    dictM[@"myInterests"]      = @"my_interests";
    dictM[@"nickname"]         = @"nickname";
    dictM[@"occupation"]       = @"occupation";
    dictM[@"onlineStatus"]     = @"online_status";
    dictM[@"region"]           = @"region";
    dictM[@"relation"]         = @"relation";
    dictM[@"remarkName"]       = @"remark_name";
    dictM[@"scoreFascinated"]  = @"score_fascinated";
    dictM[@"scoreLovely"]      = @"score_lovely";
    dictM[@"scoreSatisfied"]   = @"score_satisfied";
    dictM[@"scoreSurprised"]   = @"score_surprised";
    dictM[@"sex"]              = @"sex";
    dictM[@"spend"]            = @"spend";
    dictM[@"subscribePrice"]   = @"subscribe_price";
    dictM[@"totalImage"]       = @"total_image";
    dictM[@"totalMoment"]      = @"total_moment";
    dictM[@"totalVideo"]       = @"total_video";
    dictM[@"tycoonLevel"]      = @"tycoon_level";
    dictM[@"userId"]           = @"user_id";
    dictM[@"userStatus"]       = @"user_status";
    dictM[@"userType"]         = @"user_type";
    dictM[@"video"]            = @"video";
    dictM[@"videoCover"]       = @"video_cover";
    dictM[@"videoId"]          = @"video_id";
    dictM[@"videoPrice"]       = @"video_price";
    dictM[@"videoUser"]        = @"video_user";
    dictM[@"videoUserCover"]   = @"video_user_cover";
    dictM[@"vipEndTime"]       = @"vip_end_time";
    dictM[@"vipIcon"]          = @"vip_icon";
    dictM[@"weight"]           = @"weight";
    
    dictM[@"agoraRtmToken"]    = @"agora_rtm_token";
    dictM[@"balanceInr"]       = @"balance_inr";
    dictM[@"birthday"]         = @"birthday";
    dictM[@"disturb"]          = @"disturb";
    dictM[@"isNaturalUser"]    = @"is_natural_user";
    dictM[@"isPayUser"]        = @"is_pay_user";
    dictM[@"password"]         = @"password";
    dictM[@"phoneNumber"]      = @"phone_number";
    dictM[@"photos"]           = @"photos";
    dictM[@"refUrl"]           = @"ref_url";
    dictM[@"registerTime"]     = @"register_time";
    dictM[@"shareRatio"]       = @"share_ratio";
    dictM[@"tycoonLevelInt"]   = @"tycoon_level_int";
    dictM[@"videos"]           = @"videos";
    dictM[@"vipStartTime"]     = @"vip_start_time";
    dictM[@"withdrawable"]     = @"withdrawable";
    dictM[@"yCoin"]            = @"y_coin";
    dictM[@"isNew"]            = @"is_new";
    return dictM.copy;
}

- (BOOL)isLogin {
    return [self.userId yybb_isNotEmpty];
}

+ (instancetype)currentUser {
    return [YYBBRuntimeManager sharedInstance].currentUser;
}


// 根据指定id查询用户数据
+ (instancetype)queryUserWithUserId:(NSString *)userId {
    NSString *searchKey = [NSString stringWithFormat:@"userId = '%@'", userId];
    NSArray *results = [WHCSqlite query:[self class] where:searchKey];
    return results.firstObject;
}

// 更新用户数据
- (void)updateUserInfo {
    NSString *searchKey = [NSString stringWithFormat:@"userId = '%@'", self.userId];
    NSArray *results = [WHCSqlite query:[self class] where:searchKey];
    // 先删除, 再添加
    if ([results yybb_isNotEmpty]) {
        [self dropUserInfo];
    }
    [WHCSqlite insert:self];
}

// 删除用户信息
- (void)dropUserInfo {
    NSString *searchKey = [NSString stringWithFormat:@"userId = '%@'", self.userId];
    [WHCSqlite delete:[self class] where:searchKey];
}

+ (NSString *)whc_SqliteVersion {
    return [UIApplication sharedApplication].appVersion;
}
/**
 *  手机设备id登录
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)loginWithParams:(NSDictionary *)params completionHandler:(YYBBErrorCompletionBlock)completionHandler {
    NSString *deviceId         = [UIDevice yybb_deviceId];
    NSString *pkgName          = [NSBundle mainBundle].bundleIdentifier;
    NSString *verName          = YYBBAppVersion();
    NSString *verCode          = YYBBAppBuild();
    NSString *deviceModel      = [UIDevice currentDevice].machineModelName;
    NSString *language         = [[NSLocale preferredLanguages] firstObject];
    NSString *osVersion        = [UIDevice currentDevice].systemVersion;
    NSInteger wifi             = [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi ? 1 : 0;
    NSString *countryCode      = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSString *identifier       = [[NSLocale currentLocale] localeIdentifier];
    NSString *countryName      = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    // 设备名称
    dictM[@"device"]           = nil;
    dictM[@"imei"]             = deviceId;
    dictM[@"imsi"]             = deviceId;
    dictM[@"android_id"]       = deviceId;
    dictM[@"oaid"]             = deviceId;
    dictM[@"brand"]            = @"iPhone";
    // 1：安卓，2：苹果
    dictM[@"platform"]         = @(2);
    dictM[@"os"]               = @([UIDevice systemVersion]);
    // 手机名称
    dictM[@"name"]             = [UIDevice currentDevice].machineModelName;
    dictM[@"display"]          = nil;
    dictM[@"viersion"]         = verName;
    dictM[@"pgname"]           = pkgName;
    dictM[@"channel"]          = [YYBBConfig currentConfig].channelId;
    dictM[@"language"]         = language;
    dictM[@"user_id"]          = @(0);
    dictM[@"idfa"]             = [UIDevice yybb_idfa];
    
    return [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kUserLogin parameters:@{@"param" : [dictM jsonStringEncoded]} onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            !completionHandler ?: completionHandler(error);
            return ;
        }
        
        [self configureLoginReponseData:responseObj];
        // 逻辑处理
        !completionHandler ?: completionHandler(nil);
    }];
}

/**
 *  获取用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)getUserInfoWithCompletionHandler:(nullable YYBBErrorCompletionBlock)completionHandler {
    NSString *userId = [YYBBUserInfo currentUser].userId;
    if (![userId yybb_isNotEmpty]) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = [YYBBUserInfo currentUser].userId;
    return [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kGetUserInfo parameters:params.copy onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            !completionHandler ?: completionHandler(error);
            return ;
        }
        YYBBUserInfo *currentUser = [YYBBUserInfo currentUser];
        [currentUser yy_modelSetWithJSON:responseObj];
                
        [YYBBRuntimeManager sharedInstance].currentUser = currentUser;
        [[YYBBRuntimeManager sharedInstance] saveUserInfo];
        // 逻辑处理
        !completionHandler ?: completionHandler(nil);
    }];
}

/**
 *  保存用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)updateUserInfoWithParams:(NSDictionary *)params completionHandler:(YYBBErrorCompletionBlock)completionHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    dictM[@"user_id"] = [YYBBUserInfo currentUser].userId;
    return [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kSaveProfile parameters:dictM.copy onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            !completionHandler ?: completionHandler(error);
            return ;
        }
        // 逻辑处理
        !completionHandler ?: completionHandler(nil);
    }];
}

/**
 *  搜索用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)searchUserInfoWithParams:(NSDictionary *)params completionHandler:(void (^)(NSArray<YYBBUserInfo *> *results, NSError *error))completionHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    dictM[@"user_id"] = [YYBBUserInfo currentUser].userId;
    return [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kUserSearch parameters:dictM.copy onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            !completionHandler ?: completionHandler(nil, error);
            return ;
        }
        if ([responseObj isKindOfClass:[NSArray class]]) {
            NSArray *results = [NSArray yy_modelArrayWithClass:[YYBBUserInfo class] json:responseObj];
            !completionHandler ?: completionHandler(results, nil);
        } else if ([responseObj isKindOfClass:[NSDictionary class]]) {
            YYBBUserInfo *userInfo = [YYBBUserInfo yy_modelWithJSON:responseObj[@"info"]];
            if (userInfo) {
                // 逻辑处理
                !completionHandler ?: completionHandler(@[userInfo], nil);
            } else {
                // 逻辑处理
                !completionHandler ?: completionHandler(@[], nil);
            }
        } else {
            !completionHandler ?: completionHandler(@[], nil);
        }
    }];
}

/**
 *  获取好友列表
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)getFriendsWithParams:(NSDictionary *)params completionHandler:(void (^)(NSArray<YYBBUserInfo *> *results, NSError *error))completionHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    dictM[@"user_id"] = [YYBBUserInfo currentUser].userId;
    return [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kUserSearch parameters:dictM.copy onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            !completionHandler ?: completionHandler(nil, error);
            return ;
        }
        NSArray *results = [NSArray yy_modelArrayWithClass:[YYBBUserInfo class] json:responseObj];
        !completionHandler ?: completionHandler(results, nil);
    }];
}



/**
 *  退出登录
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)logoutWithCompletionHandler:(nullable YYBBErrorCompletionBlock)completionHandler {
    NSString *url = [NSString stringWithFormat:kLogout, [YYBBUserInfo currentUser].userId];
    NSURLSessionTask *task = [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithMethod:YYBBNetworkReuqetMethodDelete url:url parameters:nil onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        [self userDidLogout];
        if (error) {
            !completionHandler ?: completionHandler(error);
            return ;
        }
        // 逻辑处理
        !completionHandler ?: completionHandler(nil);
    }];
    return task;
}

#pragma mark - Private

+ (void)configureLoginReponseData:(id)responseObj {
    YYBBUserInfo *userInfo = [YYBBUserInfo yy_modelWithJSON:responseObj];
    [YYBBRuntimeManager sharedInstance].currentUser = userInfo;
    [[YYBBRuntimeManager sharedInstance] saveUserInfo];
}

// 登录成功
+ (void)userDidLogin {
    [[YYBBRuntimeManager sharedInstance] userDidLogin];
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:YYBBUserDidLoginNotification
                                                                        object:nil
                                                                      userInfo:nil
                                                                 waitUntilDone:YES];
}

// 登出
+ (void)userDidLogout {
    [[YYBBRuntimeManager sharedInstance] userDidLogout];
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:YYBBUserDidLogoutNotification
                                                                        object:nil
                                                                      userInfo:nil
                                                                 waitUntilDone:YES];
}

@end
