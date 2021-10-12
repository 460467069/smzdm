//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYBBUtilsMacro.h"

//YYBBUser 账号登录相关接口
@protocol YYBBUserLoginDelegate <NSObject>

@optional
- (void)login;
- (void)logout;
- (void)switchAccount;
- (BOOL)hasAccountCenter;

- (void)requestAuth;                      // 请求第三方授权, 必须实现
- (void)thirdLogout;                      // 第三方登出逻辑, 可选, 可重写
- (void)loginWithSocialAccount;           // 登录, 如果在YYBBLogin中抽取的方法不符合需求, 重写改该方法即可(如GameCenter)
- (void)bindSocialAccount;                // 绑定, 如果在YYBBLogin中抽取的方法不符合需求, 重写改该方法即可(如GameCenter)
- (void)loginOrBindAccountToOwnServer;    // 登录或绑定账号到自己服务器
- (void)loginOrBindAccountToThirdFailed;  // 登录或绑定账号第三方失败
- (void)loginOrBindAccountToThirdCanceled;// 登录或绑定账号第三方用户中途取消
- (void)loginOrBindAccountToOwnServerSuccessHandler; // 登录或绑定成功后逻辑处理

- (void)bindAccount;
- (void)loginCustom:(NSString*)customData;
- (void)showAccountCenter;

@end
