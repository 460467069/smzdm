//
//  YYBBSDK_Adjust.m
//  YYBBSDK_Adjust
//
//  Created by Wang_Ruzhou on 1/23/17.
//  Copyright © 2017 Wang_ruzhou. All rights reserved.
//

#import "YYBBSDK_Adjust.h"
#import "YYBBKit.h"
#import <Adjust/Adjust.h>
#import "YYBBRequestURL.h"

@interface YYBBSDK_Adjust()<AdjustDelegate>

@end

@implementation YYBBSDK_Adjust

#pragma mark - UIApplicationDelegate

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    // 默认生成环境
    NSString *environment = ADJEnvironmentProduction;
    BOOL allowSuppressLogLevel = YES;
    ADJLogLevel logLevel = ADJLogLevelSuppress;
#if 0
    if (YYBBIsDebug()) {
        environment = ADJEnvironmentSandbox;
        allowSuppressLogLevel = NO;
        logLevel = ADJLogLevelVerbose;
    }
#endif
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:@"1ihoqcdvm928"
                                                environment:environment
                               allowSuppressLogLevel:allowSuppressLogLevel];
    adjustConfig.delegate = self;
    adjustConfig.logLevel = logLevel;
    [Adjust appDidLaunch:adjustConfig];
    
    ADJAttribution *attribution = [Adjust attribution];
    if (attribution) {
        [self _sendWithAttribution:attribution];
    }
}

#pragma mark - AdjustDelegate

/**
 * @brief Optional delegate method that gets called when the attribution information changed.
 *
 * @param attribution The attribution information.
 *
 * @note See ADJAttribution for details.
 */
- (void)adjustAttributionChanged:(nullable ADJAttribution *)attribution {
    [self _sendWithAttribution:attribution];
}

- (void)adjustEventTrackingSucceeded:(nullable ADJEventSuccess *)eventSuccessResponseData {
    
}

/**
 * @brief Optional delegate method that gets called when an event is tracked with failure.
 *
 * @param eventFailureResponseData The response information from tracking with failure
 *
 * @note See ADJEventFailure for details.
 */
- (void)adjustEventTrackingFailed:(nullable ADJEventFailure *)eventFailureResponseData {
    
}

/**
 * @brief Optional delegate method that gets called when an session is tracked with success.
 *
 * @param sessionSuccessResponseData The response information from tracking with success
 *
 * @note See ADJSessionSuccess for details.
 */
- (void)adjustSessionTrackingSucceeded:(nullable ADJSessionSuccess *)sessionSuccessResponseData {
    
}

/**
 * @brief Optional delegate method that gets called when an session is tracked with failure.
 *
 * @param sessionFailureResponseData The response information from tracking with failure
 *
 * @note See ADJSessionFailure for details.
 */
- (void)adjustSessionTrackingFailed:(nullable ADJSessionFailure *)sessionFailureResponseData {
    
}

/**
 * @brief Optional delegate method that gets called when a deferred deep link is about to be opened by the adjust SDK.
 *
 * @param deeplink The deep link url that was received by the adjust SDK to be opened.
 *
 * @return Boolean that indicates whether the deep link should be opened by the adjust SDK or not.
 */
- (BOOL)adjustDeeplinkResponse:(nullable NSURL *)deeplink {
    
}

/**
 * @brief Optional delegate method that gets called when Adjust SDK sets conversion value for the user.
 *
 * @param conversionValue Conversion value used by Adjust SDK to invoke updateConversionValue: API.
 */
- (void)adjustConversionValueUpdated:(nullable NSNumber *)conversionValue {
    
}

#pragma mark - Private

- (void)_sendWithAttribution:(ADJAttribution *)attribution {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tt"]               = attribution.trackerToken;
    params[@"tn"]               = attribution.trackerName;
    params[@"net"]              = attribution.network;
    params[@"cam"]              = attribution.campaign;
    params[@"adg"]              = attribution.adgroup;
    params[@"cre"]              = attribution.creative;
    params[@"cl"]               = attribution.clickLabel;
    params[@"adid"]             = attribution.adid;
    params[@"ct"]               = attribution.costType;
    params[@"ca"]               = attribution.costAmount;
    params[@"cc"]               = attribution.costCurrency;
    params[@"cc"]               = attribution.costCurrency;
    params[@"idfa"]             = [UIDevice yybb_idfa];
    NSDictionary *dict = @{@"ad_activate_data" : [params yy_modelToJSONString]};
    
    [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kLogAdjustData parameters:dict onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        if (error) {
            return ;
        }
    }];
    
}

@end
