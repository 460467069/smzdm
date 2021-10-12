//
//  YYBBBonusResponseModel.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 11/9/18.
//

#import <Foundation/Foundation.h>
#import <YYModel/NSObject+YYModel.h>
#import "YYBBBaseResponseModel.h"

typedef NS_ENUM(NSUInteger, YYBBBonusType) {
    YYBBBonusTypeOK          = 1,        // 显示积分兑换
    YYBBBonusTypeNotRegister = 6,        // 显示积分注册
    YYBBBonusTypeSignError   = 12,
    YYBBBonusTypeParaError   = 401,
    YYBBBonusTypeNotShow     = 999      // 不显示积分按钮
};

typedef NS_ENUM(NSUInteger, YYBBBonusGetSMSCodeType) {
    YYBBBonusGetSMSCodeTypeOK                = 1,
    YYBBBonusGetSMSCodeTypeFail              = 5,     // 短信发送失败
    YYBBBonusGetSMSCodeTypeAlreadyRegistered = 6,     // 用户ID或手机号已经注册, 或该用户ID不存在
    YYBBBonusGetSMSCodeTypeTooFrequent       = 16,    // 请求国语频繁(距离上次请求验证码小于60s)
};

typedef NS_ENUM(NSUInteger, YYBBBonusCodeVerifyType) {
    YYBBBonusCodeVerifyTypeOK                = 1,     // 注册成功
    YYBBBonusCodeVerifyTypeFail              = 5,     // 验证码错误
    YYBBBonusCodeVerifyTypeAlreadyRegister   = 6,     // 用户ID或手机号已经注册, 或该用户ID不存在
    YYBBBonusCodeVerifyTypeAccountVerfied    = 16,    // 账号已经验证过
};


@class YYBBUserBounsModel, YYBBShopBonusItem;
@interface YYBBBonusResponseModel: NSObject<YYBBResponseDelegate, YYModel>

@property (nonatomic, strong) YYBBUserBounsModel *userBounsModel;
@property (nonatomic, assign) YYBBBonusType state;

@end

@interface YYBBUserBounsModel: NSObject

@property (nonatomic,   copy) NSString *phone;
@property (nonatomic,   copy) NSString *rule;
@property (nonatomic,   copy) NSString *unit;
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *content;
@property (nonatomic, assign) CGFloat points;
@property (nonatomic, strong) NSArray<YYBBShopBonusItem *> *products;

@end

@interface YYBBShopBonusItem: NSObject

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *productID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) CGFloat points;

@end


@interface YYBBBonusRegisterResponseModel: NSObject<YYBBResponseDelegate, YYModel>

@property (nonatomic,   copy) NSString *smsCode;
@property (nonatomic, assign) YYBBBonusGetSMSCodeType state;

@end

@interface YYBBBonusVerifyCodeResponseModel: NSObject<YYBBResponseDelegate>

@property (nonatomic, assign) YYBBBonusCodeVerifyType state;

@end

@class YYBBBonusExchangeRecordDetailModel;
@interface YYBBBonusExchangeRecordModel: NSObject<YYModel>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray<YYBBBonusExchangeRecordDetailModel *> *list;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalPage;

@end

@interface YYBBBonusExchangeRecordDetailModel: NSObject

@property (nonatomic, assign) CGFloat after;
@property (nonatomic, assign) CGFloat before;
@property (nonatomic, assign) CGFloat differ;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *time;

@end
