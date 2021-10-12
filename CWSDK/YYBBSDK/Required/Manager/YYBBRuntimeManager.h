//
//  YYBBRuntimeManager.h
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/21/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBRuntimeManager : NSObject

/// 当前登录用户
@property (nonatomic, strong, nullable) YYBBUserInfo *currentUser;
@property (nonatomic, assign) BOOL isHaveNewVersion;
// 严格判断当前用户是否登录, 具体看实现
@property (nonatomic, assign) BOOL isCurrentUserLogin;
// 当前版本是否是新版本, 具体看实现
@property (nonatomic, assign) BOOL isLatestVersion;
// 是否暂不更新
@property (nonatomic, assign) BOOL isCustomerClickNotUpdate;

@property (nonatomic, assign) BOOL isJumpToYYBBSupplyVc;
@property (nonatomic, assign) BOOL isNotFirstToast;

+ (instancetype)sharedInstance;

- (void)yybb_initialization;

- (void)clearAll;

- (void)saveUserInfo;

// 保存用户手机号
- (void)saveUserLoginMobile:(NSString *)mobile;
// 获取用户手机号
- (NSString *)getUserLoginMobile;

// 保存用户登录密码
- (void)saveUserLoginPwd:(NSString *)pwd account:(NSString *)account;
// 根据手机号码获取密码
- (NSString *)getUserLoginPwdWithAccount:(NSString *)account;
// 删除用户登录密码
- (void)deleteUserLoginPwdWithAccount:(NSString *)account;

// 登入
- (void)userDidLogin;
// 登出
- (void)userDidLogout;

// 检查something, 安装了新版本, 主动退出, 否则检查完善信息是否异常退出
- (void)checkSomethingWithSourceViewController:(UIViewController *)sourceViewController;

- (void)updateDeviceToService;

@end

NS_ASSUME_NONNULL_END
