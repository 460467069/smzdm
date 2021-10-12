//
//  YYBBSDK_AppsFlyer.m
//  YYBBSDK_AppsFlyer
//
//  Created by Killua Liu on 1/23/17.
//  Copyright © 2017 yybbsdk. All rights reserved.
//

#import "YYBBSDK_AppsFlyer.h"
#import "YYBBKit.h"

#define AFSpendVirtualCurrency                 @"custom_af_spend_virtual_currency"
#define AFViewPurchasePage                     @"custom_af_view_purchase_page"
#define AFSpendDiamond                         @"custom_af_spend_diamond"

NSString *const YYBBIsRegisterAlreadySubmitKey = @"YYBBIsRegisterAlreadySubmitKey";

#import <AppsFlyerLib/AppsFlyerTracker.h>
//@import AppsFlyerLib;

@interface YYBBSDK_AppsFlyer() <AppsFlyerTrackerDelegate>
@property (strong, nonatomic) YYBBRoleExtraModel *roleExtraModel;
@end

@implementation YYBBSDK_AppsFlyer

#pragma mark - UIApplicationDelegate

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    YYBBConfig *config = [YYBBSDK sharedInstance].config;
    if (config.appsFlyerAppId == nil || config.appsFlyerDevKey == nil) {
        [NSException raise:kYYBBCoreErrorDomain
                    format:@"请检查appsFlyerAppId或appsFlyerDevKey"];
    }
    
    [AppsFlyerTracker sharedTracker].appleAppID      = config.appsFlyerAppId;
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = config.appsFlyerDevKey;
    [AppsFlyerTracker sharedTracker].delegate        = self;
#ifdef DEBUG
    [AppsFlyerTracker sharedTracker].isDebug         = YES;
#endif
    [YYBBSDK sharedInstance].analyticsDelegate      = self;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
}

#pragma mark - AppsFlyerTrackerDelegate
- (void)onConversionDataReceived:(NSDictionary*) installData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary :installData];
    params[@"deviceID"]         = [UIDevice yybb_deviceId];
    params[@"af_deviceId"]      = [AppsFlyerTracker sharedTracker].getAppsFlyerUID;
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_POST:[YYBBSDK sharedInstance].config.url.afActivate parameters:params serverSuccessBlcok:nil serverErrorMsgBlcok:nil failureBlock:nil];
}

- (void)onConversionDataRequestFailure:(NSError *)error {
    
}

#pragma mark - AppsFlyerTracker Report
// 付款成功
- (void)yybb_paidSuccessWithProdutInfo:(YYBBProductInfo *)productInfo
{
    YYBBRoleExtraModel *roleModel     = [YYBBRoleExtraModel currentExtraModel];
    NSMutableDictionary *params        = [NSMutableDictionary dictionary];
    params[AFEventParamRevenue]        = [self getProductRealPrice:productInfo];
    params[AFEventParamContentType]    = productInfo.productName;
    params[AFEventParamContentId]      = productInfo.cpProductId;
    params[AFEventParamCurrency]       = productInfo.currencyCode;
    params[AFEventParam1]              = roleModel.serverID;
    params[AFEventParam2]              = roleModel.roleID;
    params[AFEventParamCustomerUserId] = [self getUserID];
    params[AFEventParamLevel]          = roleModel.roleLevel;
    params[AFEventParamOrderId]        = productInfo.orderID;
    
    if ([YYBBServerConfig currentConfig].isShouldReportPaySuccess) {    
        [[AppsFlyerTracker sharedTracker] trackEvent:AFEventPurchase withValues:params.copy];
    }
}

// 完成新手引导
- (void)yybb_completeBeginnerGuide
{
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventTutorial_completion withValues:params.copy];
}

// 升级
- (void)yybb_levelUp:(NSInteger)level
{
    NSString *roleID   = self.roleExtraModel.roleID;
    NSString *serverID = self.roleExtraModel.serverID;
    
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    NSString *roleLevel                 = [NSString stringWithFormat :@"%@",@(level)];

    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamLevel]           = roleLevel;
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam4]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventLevelAchieved withValues:params.copy];
    
//    NSString *levelAchived = [NSString stringWithFormat:@"%@_%@", AFEventLevelAchieved, roleLevel];
//    [[AppsFlyerTracker sharedTracker] trackEvent:levelAchived withValues:params.copy];
}

// 登录
- (void)yybb_userLogin
{
    NSMutableDictionary *params        = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId] = [self getUserID];
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventLogin withValues:params.copy];
}

// 加入购物车
- (void)yybb_addToShoppingCartWithProdutInfo:(YYBBProductInfo *)productInfo
{
    NSMutableDictionary *params        = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId] = [self getUserID];
    params[AFEventParamContentId]      = productInfo.cpProductId;
    params[AFEventParam1]              = productInfo.orderID;
    params[AFEventParam2]              = [self getProductRealPrice:productInfo];
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventAddToCart withValues:params.copy];
}

// 花费虚拟货币(花费钻石)
- (void)yybb_spendVirtualCurrency
{
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFSpendDiamond withValues:params.copy];
}

// 查看购买页面
- (void)yybb_viewPurchasePage
{
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFViewPurchasePage withValues:params.copy];
}

// 成就解锁
- (void)yybb_unlockArchivement
{
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventAchievementUnlocked withValues:params.copy];
}

// 分享
- (void)yybb_share
{
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventShare withValues:params.copy];
}

// 提交评价
- (void)yybb_submitComment
{
    
}

// 完成注册
- (void)yybb_completeRegistration
{
    NSString *userID = [self getUserID];
    BOOL isRegisterAlreadySubmit = [NSUserDefaults.standardUserDefaults boolForKey:YYBBIsRegisterAlreadySubmitKey];
    if (isRegisterAlreadySubmit == YES) {
        return;
    }
    // 更新本地数据
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:YYBBIsRegisterAlreadySubmitKey];
    
    NSString *roleID                    = self.roleExtraModel.roleID;
    NSString *serverID                  = self.roleExtraModel.serverID;
    YYBBRoleExtraModel *roleExtraModel = [self roleExtraModel];
    NSString *roleName                  = roleExtraModel.roleName;
    
    NSMutableDictionary *params         = [NSMutableDictionary dictionary];
    params[AFEventParamCustomerUserId]  = [self getUserID];
    params[AFEventParam1]               = serverID;
    params[AFEventParam2]               = roleID;
    params[AFEventParam3]               = roleName;
    
    [[AppsFlyerTracker sharedTracker] trackEvent:AFEventCompleteRegistration withValues:params.copy];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter && setter
- (NSString *)getUserID {
    YYBBUser *user = [YYBBUser currentUser];
    return user.userID;
}
    
- (NSString *)getProductRealPrice:(YYBBProductInfo *)productInfo {
    NSString *productPriceRatio = [YYBBServerConfig currentConfig].productPriceRatio;
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:productInfo.price];
    NSDecimalNumber *ratio = [NSDecimalNumber decimalNumberWithString:productPriceRatio];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp
                                                                                             scale:2
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    
    NSDecimalNumber *num = [price decimalNumberByDividingBy:ratio withBehavior:handler];
    return [NSString stringWithFormat:@"%@", num];
}

- (YYBBRoleExtraModel *)roleExtraModel {
    if (!_roleExtraModel) {
        _roleExtraModel = [YYBBRoleExtraModel currentExtraModel];
    }
    return _roleExtraModel;
}

@end
