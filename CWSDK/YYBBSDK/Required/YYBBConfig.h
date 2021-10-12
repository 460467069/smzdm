//
//  YYBBConfig.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/9/10.
//

#import <Foundation/Foundation.h>
#import <YYModel/NSObject+YYModel.h>


@interface YYBBURL : NSObject
@property (nonatomic,   copy) NSString *afActivate;
@property (nonatomic,   copy) NSString *firebaseInitialize;
@end

@interface YYBBConfig : NSObject<YYModel>

@property (nonatomic,   copy) NSString *appsFlyerDevKey;
@property (nonatomic,   copy) NSString *appId;
@property (nonatomic,   copy) NSString *appKey;
@property (nonatomic,   copy) NSString *appSecret;
@property (nonatomic,   copy) NSString *appsFlyerAppId;
@property (nonatomic,   copy) NSString *baseURL;
@property (nonatomic,   copy) NSString *channelId;
@property (nonatomic,   copy) NSString *headerDomainURL;
@property (nonatomic,   copy) NSArray *iaps;
@property (nonatomic, assign) NSInteger orderWay;
@property (nonatomic, strong) YYBBURL *url;

// 环境配置, 参考YYBBCommonUtilities.h YYBBEnvs
@property (nonatomic, strong) NSArray *envs;
@property (nonatomic, strong) NSString * appStoreID;
@property (nonatomic, strong) NSString * BuglyAppId;
@property (nonatomic, strong) NSString * JpushAppKey;
@property (nonatomic, strong) NSString * JpushChannel;
@property (nonatomic, strong) NSString * WeChatAppId;
@property (nonatomic, strong) NSString * WeChatuniversalLink;
@property (nonatomic, strong) NSString * WeChatSecret;
@property (nonatomic, strong) NSString * QQAppId;
@property (nonatomic, strong) NSString * QQSecret;
@property (nonatomic, strong) NSString * QQUniversalLink;
@property (nonatomic, strong) NSString * UMAppKey;
@property (nonatomic, strong) NSString * UMChannel;
@property (nonatomic, strong) NSString * PGYAppKey;
@property (nonatomic, strong) NSString * themeColor;
@property (nonatomic, strong) NSString * themeColor2;
// 二维码分享地址
@property (nonatomic, strong) NSString * shareQrcodeStr;

+ (instancetype)currentConfig;

@end
