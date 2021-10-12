//
//  YYBBUtilities.h
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/20/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#ifndef YYBBUtilities_h
#define YYBBUtilities_h

#import <AVFoundation/AVFoundation.h>
#import <YYBBSDK/YYBBSDK.h>
#import <YYCategories/UIApplication+YYAdd.h>
#import <YYCategories/YYCGUtilities.h>
#import "YYBBEnvironmentSwitchController.h"
#import "NSString+YYBBAdd.h"
#import "UIImage+YYBBAdd.h"
#import "YYBBUserInfo.h"
#import "LxDBAnything.h"


static NSString * _Nonnull const YYBBInInInSecretKey       = @"gXCue61haIvwse6xGbBocnCyXeQ=";
static NSString * _Nonnull const YYBBInInInAccessKey       = @"y4JKi3/yq1hvopwqk9SYfw==";
static NSString * _Nonnull const YYBBUserLoginService      = @"UserLoginService";
static NSString * _Nonnull const YYBBImageBaseUrl          = @"https://wg.cloud.ininin.com/";
static NSString * _Nonnull const YYBBWXMiniProgramUserName = @"gh_13f0898c0e3b";

static NSTimeInterval const kMBProgressDelay = 2.0;

// app平台的标识， 0=云印微供 1=云印供应商 2=dss销售助手 3=dss采购app
static NSString * _Nonnull const YYBBPlatformType      = @"3";
static NSUInteger const YYBBMaxNumLength               = 8;
// 验证码60s
static NSInteger const kSmsCodeTimerCount = 60;
// 消息提示3秒
static NSInteger const YYBBShowAlertMsgTime = 3;
// 验证码长度
static NSInteger const kSmsCodeCount = 4;
// 登录密码最短
static NSInteger const kLoginPwdMinCount = 6;
// 登录密码最长
static NSInteger const kLoginPwdMaxCount = 18;
// 支付密码长度
static NSInteger const kPayPwdCount = 6;
// QQ最短
static NSInteger const kQQMinCount = 5;
// QQ最长
static NSInteger const kQQMaxCount = 15;
// tabBar 首页
static NSInteger const kTabBarHomeIndex = 0;
// tabBar Game
static NSInteger const kTabBarGameIndex = 1;
// tabBar chats
static NSInteger const kTabBarChatsIndex = 2;
// tabBar Line
static NSInteger const kTabBarLineIndex = 3;
// tabBar Line
static NSInteger const kTabBarMineIndex = 4;

static inline BOOL YYBBIsDebug() {
    return [[YYBBSDK sharedInstance].delegate yybb_isDebug];
}

static inline YYBBAppType YYBBCurrentAppType() {
    return [[YYBBSDK sharedInstance].delegate appType];
}

static inline NSDictionary * _Nonnull YYBBH5Parameter(){
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"token"] = [[YYBBSDK sharedInstance].delegate yybb_token];
    dictM[@"version"] = [UIApplication sharedApplication].appVersion;
    dictM[@"appType"] = @(YYBBCurrentAppType());
    dictM[@"v"] = [UIApplication sharedApplication].appVersion;
    return dictM;
}

// H5 链接 路径拼接
static inline NSString * _Nonnull YYBBH5FullUrlString(NSString *pathStr) {
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [YYBBSDK sharedInstance].delegate.yybb_webBaseURL, pathStr];
    return urlStr;
}

// 图片URL
static inline NSString * _Nonnull YYBBImageUrl(NSString * _Nonnull relativeUrl) {
    if (![relativeUrl yybb_isNotEmpty]) {
        return @"";
    }
    if ([relativeUrl hasPrefix:@"http"]) {
        return relativeUrl;
    } else if ([relativeUrl hasPrefix:@"//"]) {
        return [NSString stringWithFormat:@"https:%@", relativeUrl];
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", YYBBImageBaseUrl, relativeUrl];
    return imageUrl;
}

// 头像占位图片
static inline UIImage * _Nonnull YYBBAvatarDefaultPlaceHolderImage() {
    return [UIImage imageNamed:@"child_icon_teacher_default_head"];
}

// 订单id匹配
static inline NSRegularExpression * _Nonnull YYBBRegexOrderId(void) {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"【[0-9]*】" options:kNilOptions error:NULL];
    return regex;
}

static inline NSString *YYBBAddressString(NSString *address) {
    NSString *string = [address stringByReplacingOccurrencesOfString:@"^" withString:@""];
    return string;
}

static inline UIImage *YYBBNavigationBgImage() {
    return [UIImage gradientColorImageFromColors:@[[UIColor colorWithHexString:@"#FF5D3D"], [UIColor yybb_redColor]]
                                    gradientType:GradientTypeLeftToRight
                                         imgSize:CGSizeMake(kScreenWidth, YYBBNavHeight())];
}

static inline NSString * _Nonnull YYBBCallerMusicFilePath() {
    return [[NSBundle mainBundle] pathForResource:@"basic_ring.mp3" ofType:@""];;
}

static inline NSString * _Nonnull YYBBCalleeAnswerMusicFilePath() {
    return [[NSBundle mainBundle] pathForResource:@"aigei.mp3" ofType:@""];;
}

static inline void YYBBSystemAudioCallback(){
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}



#endif /* YYBBUtilities_h */
