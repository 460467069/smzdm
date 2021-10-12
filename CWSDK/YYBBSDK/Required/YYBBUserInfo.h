//
//  YYBBUserInfoInfo.h
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/21/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBBaseModel.h"
#import <CoreLocation/CoreLocation.h>
#import "YYBBLoginConstants.h"
#import "YYBBEnums.h"
#import "YYBBUtilsMacro.h"
#import "YYBBBaseResponse.h"
#import <WHC_ModelSqliteKit/WHC_ModelSqlite.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBUserInfo : YYBBBaseModel<WHC_SqliteInfo>

@property (nonatomic, assign) BOOL isLogin;
// 用户ID
@property (nonatomic,   copy) NSString *userId;
@property (nonatomic,   copy) NSString *token;
// 性别
@property (nonatomic, assign) YYBBGenderType sex;
// 手机号码
@property (nonatomic,   copy) NSString *mobile;
// 昵称
@property (nonatomic, strong) NSString * nickname;
// 验证码
@property (nonatomic,   copy) NSString *smsCode;
// 1：新用户，2：老用户
@property (nonatomic, assign) NSInteger isNew;

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, assign) NSTimeInterval birthday;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSString * diamond;
@property (nonatomic, strong) NSString * height;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, assign) NSInteger isZhubo;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * region;
@property (nonatomic, assign) NSInteger vipEndTime;
@property (nonatomic, assign) NSInteger vipStartTime;
@property (nonatomic, strong) NSString * weight;
@property (nonatomic, assign) NSInteger yCoin;

@property (nonatomic, strong) NSString * aboutMe;
@property (nonatomic, strong) NSString * countryCode;
@property (nonatomic, strong) NSString * countryIcon;
@property (nonatomic, strong) NSString * datingPurpose;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSString * expectation;
@property (nonatomic, assign) NSInteger follower;
@property (nonatomic, assign) NSInteger intimate;
@property (nonatomic, assign) NSInteger isFollow;
@property (nonatomic, assign) NSInteger isSh;
@property (nonatomic, strong) NSString * lookingFor;
@property (nonatomic, strong) NSString * myInterests;
@property (nonatomic, strong) NSString * occupation;
@property (nonatomic, assign) NSInteger onlineStatus;
@property (nonatomic, assign) YYBBUserRelationType relation;
@property (nonatomic, strong) NSString * remarkName;
@property (nonatomic, strong) NSString * scoreFascinated;
@property (nonatomic, strong) NSString * scoreLovely;
@property (nonatomic, strong) NSString * scoreSatisfied;
@property (nonatomic, strong) NSString * scoreSurprised;
@property (nonatomic, assign) NSInteger spend;
@property (nonatomic, assign) NSInteger subscribePrice;
@property (nonatomic, assign) NSInteger totalImage;
@property (nonatomic, assign) NSInteger totalMoment;
@property (nonatomic, assign) NSInteger totalVideo;
@property (nonatomic, strong) NSString * tycoonLevel;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, strong) NSString * video;
@property (nonatomic, strong) NSString * videoCover;
@property (nonatomic, assign) NSInteger videoId;
@property (nonatomic, strong) NSString * videoPrice;
@property (nonatomic, strong) NSString * videoUser;
@property (nonatomic, strong) NSString * videoUserCover;
@property (nonatomic, strong) NSString * vipIcon;

@property (nonatomic, strong) NSString * agoraRtmToken;
@property (nonatomic, strong) NSString * balanceInr;
@property (nonatomic, assign) NSInteger disturb;
@property (nonatomic, assign) NSInteger isNaturalUser;
// 是否是付费用户（1：否，2：是）
@property (nonatomic, assign) NSInteger isPayUser;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSArray * photos;
@property (nonatomic, strong) NSString * refUrl;
@property (nonatomic, assign) NSInteger registerTime;
@property (nonatomic, assign) NSInteger shareRatio;
@property (nonatomic, assign) NSInteger tycoonLevelInt;
@property (nonatomic, strong) NSArray * videos;
@property (nonatomic, assign) NSInteger withdrawable;
@property (nonatomic, strong, nullable) NSString *settingPwd;

+ (instancetype)currentUser;

// 根据指定id查询用户数据
+ (instancetype)queryUserWithUserId:(NSString *)userId;

// 获取用户信息时, 更新
- (void)updateUserInfo;

// 删除用户信息
- (void)dropUserInfo;

// 主动登出
+ (void)userDidLogout;

/**
 *  验证码/密码登录
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)loginWithParams:(nullable NSDictionary *)params completionHandler:(YYBBErrorCompletionBlock)completionHandler;

/**
 *  保存用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)updateUserInfoWithParams:(NSDictionary *)params completionHandler:(YYBBErrorCompletionBlock)completionHandler;

/**
 *  获取用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)getUserInfoWithCompletionHandler:(nullable YYBBErrorCompletionBlock)completionHandler;

/**
 *  搜索用户信息
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)searchUserInfoWithParams:(NSDictionary *)params completionHandler:(void (^)(NSArray<YYBBUserInfo *> *results, NSError *error))completionHandler;

/**
 *  获取好友列表
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)getFriendsWithParams:(NSDictionary *)params completionHandler:(void (^)(NSArray<YYBBUserInfo *> *results, NSError *error))completionHandler;

/**
 *  退出登录
 *  @param completionHandler 请求回调
 */
+ (NSURLSessionTask *)logoutWithCompletionHandler:(nullable YYBBErrorCompletionBlock)completionHandler;


@end



NS_ASSUME_NONNULL_END
