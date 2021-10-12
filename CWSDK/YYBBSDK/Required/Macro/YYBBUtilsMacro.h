//
//  YYBBUtilsMacro.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/8.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#ifndef YYBBUtilsMacro_h
#define YYBBUtilsMacro_h

#if TARGET_IPHONE_SIMULATOR//模拟器
#define JPushSwitch 0
#elif TARGET_OS_IPHONE//真机
#define JPushSwitch 1
#endif

#define PGYSwitch 1

#define kAPPDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

/**全局字体*/
#define YYBBGlobelNormalFont(__VA_ARGS__) ([UIFont systemFontOfSize:YYBB_ScaleFont(__VA_ARGS__)])

/**宽度比例*/
#define YYBB_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**高度比例*/
#define YYBB_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)

/**字体比例*/
#define YYBB_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

#ifndef YYBBLOCK
#define YYBBLOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif


#ifndef YYBBUNLOCK
#define YYBBUNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// image STRETCH
#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import "NSObject+YYBBAdd.h"
#import <YYText/NSAttributedString+YYText.h>
#import <YYCategories/UIColor+YYAdd.h>
#import "UIColor+YYBBAdd.h"
#import "YYBBConfig.h"

// 登录
static NSString * _Nonnull const YYBBPlugin_Guest           = @"Guest";
static NSString * _Nonnull const YYBBPlugin_GameCenter      = @"GameCenter";
static NSString * _Nonnull const YYBBPlugin_Facebook        = @"Facebook";
static NSString * _Nonnull const YYBBPlugin_Kakao           = @"Kakao";
static NSString * _Nonnull const YYBBPlugin_Naver           = @"Naver";
static NSString * _Nonnull const YYBBPlugin_Line            = @"Line";
static NSString * _Nonnull const YYBBPlugin_Twitter         = @"Twitter";
static NSString * _Nonnull const YYBBPlugin_Code            = @"Code";
// 分享
static NSString * _Nonnull const YYBBPlugin_NativeShare     = @"NativeShare";
static NSString * _Nonnull const YYBBPlugin_ShareSDK        = @"ShareSDK";
// 内购
static NSString * _Nonnull const YYBBPlugin_AppStore        = @"AppStore";
// 如果是纯内购, 删除以下5行
static NSString * _Nonnull const YYBBPlugin_H5              = @"H5";
static NSString * _Nonnull const YYBBPlugin_PaymentUI       = @"PaymentUI";
// 客服
static NSString * _Nonnull const YYBBPlugin_CS              = @"CS";
static NSString * _Nonnull const YYBBPlugin_AI              = @"AI";
static NSString * _Nonnull const YYBBService_Tel            = @"4008000873";
// 统计
static NSString * _Nonnull const YYBBPlugin_KuWan           = @"KuWan";
static NSString * _Nonnull const YYBBPlugin_AppsFlyer       = @"AppsFlyer";
static NSString * _Nonnull const YYBBPlugin_Adjust          = @"Adjust";
static NSString * _Nonnull const YYBBPlugin_UMCAnalytics    = @"UMCAnalytics";
// 第三方, 其他
static NSString * _Nonnull const YYBBPlugin_ThirdLib        = @"ThirdLib";
static NSString * _Nonnull const YYBBPlugin_PGY             = @"PGY";
// 直购商城
static NSString * _Nonnull const YYBBPlugin_Prop            = @"Prop";
// 推送
static NSString * _Nonnull const YYBBPlugin_Firebase        = @"Firebase";
static NSString * _Nonnull const YYBBPlugin_JPush           = @"JPush";
// 广告
static NSString * _Nonnull const YYBBPlugin_UP              = @"UP";

// 微信支付
static NSString * _Nonnull const YYBBPlugin_WXPay           = @"WXPay";

static NSString * _Nonnull const YYBBPlatform               = @"iOS";
static NSString * _Nonnull const YYBBLoginedUserKey         = @"YYBB_loginedUser";              //记录用户数据
static NSString * _Nonnull const YYBBIsGuestLoginedKey      = @"YYBB_isGuestLogined";           //记录用户是否以游客身份登录过
static NSString * _Nonnull const YYBBIsNeedResetDeviceIDKey = @"YYBB_isNeedResetDeviceIDKey";   //是否有必要重置deviceID

static NSString * _Nonnull const YYBBLoginTypeKey           = @"loginType";
static NSString * _Nonnull const YYBBAppBuildKey            = @"appBuild";
static NSString * _Nonnull const YYBBAppVersionKey          = @"appVersion";
static NSString * _Nonnull const YYBBPlatformKey            = @"platform";
static NSString * _Nonnull const YYBBExtensionKey           = @"extension";
static NSString * _Nonnull const YYBBDeviceIDKey            = @"deviceID";
static NSString * _Nonnull const YYBBGuestDeviceIDKey       = @"GuestDeviceIDKey";
static NSString * _Nonnull const YYBBOpenIDKey              = @"openID";
static NSString * _Nonnull const YYBBOpenNameKey            = @"openName";
static NSString * _Nonnull const YYBBAccessTokenKey         = @"access_token";
static NSString * _Nonnull const YYBBGameCenterParamsKey    = @"gameCenterParams";

static CGFloat   const YYBBDefaultPadding     = 12.f;

static NSString *const YYBBKeyPathContentSize = @"contentSize";

typedef void (^YYBBErrorCompletionBlock)(NSError * _Nullable error);
typedef void (^YYBBResponseBoolCompletionBlock)(BOOL result, NSError * _Nullable error);
typedef void (^YYBBVoidCompletionBlock)(void);
typedef void (^YYBBStringCompletionBlock)(NSString * _Nullable string);

static NSString * _Nonnull const YYBBAppStoreDetailUrl = @"https://itunes.apple.com/cn/app/id";

static inline NSString * _Nonnull YYBBAppStoreURL(void) {
    NSString *appID = [YYBBConfig currentConfig].appStoreID;
    return [NSString stringWithFormat:@"%@%@", YYBBAppStoreDetailUrl, appID];
}

static inline NSString * _Nonnull YYBBAppBuild(void) {
    return NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"] ?: @"";
}

static inline NSString * _Nonnull YYBBAppVersion(void) {
    return NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] ?: @"";
}

static inline NSString * _Nonnull YYBBAppName(void) {
    return NSBundle.mainBundle.infoDictionary[@"CFBundleDisplayName"] ?: @"";
}

static inline NSBundle * _Nonnull YYBBSDKBundle(void) {
    return [NSBundle bundleForClass:NSClassFromString(@"YYBBSDK")];
}

static inline NSString * _Nonnull YYBBLocalizableString(NSString * _Nonnull key) {
    NSString *string = [YYBBSDKBundle() localizedStringForKey:key value:nil table:nil];
    return string;
}

// 主线程回调
static inline void YYBBRunOnMainThread(void(^ _Nullable completionHandler)(void)) {
    if ([NSThread isMainThread]) {
        if (completionHandler) {
            completionHandler();
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), completionHandler);
    }
}

static inline NSString * _Nonnull YYBBString(id _Nullable stringA) {
    return [stringA yybb_isNotEmpty] ? [NSString stringWithFormat:@"%@", stringA] : @"";
}

static inline NSString * _Nonnull YYBBFormatString(id _Nullable stringA, NSString * _Nullable placeHolderStr) {
    if (![stringA yybb_isNotEmpty]) {
        return YYBBString(placeHolderStr);
    }
    return YYBBString(stringA);
}


/** 直接传入精度丢失有问题的字符串*/
static inline NSString * _Nonnull YYBBDecimalNumberWithDoubleStr(NSString * _Nullable originalDoubleStr, short scale){
    if (originalDoubleStr == nil ||
        ![originalDoubleStr yybb_isNotEmpty] ||
        ![originalDoubleStr isKindOfClass:[NSString class]]) {
        return @"0";
    }
    NSDecimalNumber *originalNumber = [[NSDecimalNumber alloc] initWithString:originalDoubleStr];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                             scale:scale
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *resultNumber = [originalNumber decimalNumberByRoundingAccordingToBehavior:handler];
    return [NSString stringWithFormat:@"%@", resultNumber];
}

// 价格2位小数
static inline NSString * _Nonnull YYBBPriceValueWithDoubleStr(NSString * _Nullable originalDoubleStr){
    NSString *value = YYBBDecimalNumberWithDoubleStr(originalDoubleStr, 2);
    return [NSString stringWithFormat:@"%.2f", [value doubleValue]];
}

// 长度mm制1位小数
static inline NSString * _Nonnull YYBBLengthValueWithDoubleStr(NSString * _Nullable originalDoubleStr){
    NSString *value = YYBBDecimalNumberWithDoubleStr(originalDoubleStr, 1);
    return [NSString stringWithFormat:@"%.1f", [value doubleValue]];
}

static inline NSDecimalNumber * _Nonnull YYBBDecimalNumber(NSString * _Nullable origin, short scale) {
    if (origin == nil ||
        ![origin yybb_isNotEmpty] ||
        ![origin isKindOfClass:[NSString class]]) {
        origin = @"0";
    }
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    NSDecimalNumber *originalNumber = [[NSDecimalNumber alloc] initWithString:origin];
    NSDecimalNumber *outDecimal = [originalNumber decimalNumberByRoundingAccordingToBehavior:handler];
    
    return outDecimal;
};

// 相加
static inline NSString * _Nonnull YYBBDecimalPlusNumber(NSString * _Nullable oneString, NSString * _Nullable twoString, short scale){
    
    NSDecimalNumber *oneDecimal = YYBBDecimalNumber(oneString, scale);
    NSDecimalNumber *twoDecimal = YYBBDecimalNumber(twoString, scale);
    NSDecimalNumber *resultDecimal = [oneDecimal decimalNumberByAdding:twoDecimal];
    return resultDecimal.stringValue;
};

// 相减
static inline NSString * _Nonnull YYBBDecimalSubtractingNumber(NSString * _Nullable oneString, NSString * _Nullable twoString, short scale){
    
    NSDecimalNumber *oneDecimal = YYBBDecimalNumber(oneString, scale);
    NSDecimalNumber *twoDecimal = YYBBDecimalNumber(twoString, scale);
    NSDecimalNumber *resultDecimal = [oneDecimal decimalNumberBySubtracting:twoDecimal];
    return resultDecimal.stringValue;
};

// 相乘
static inline NSString * _Nonnull YYBBDecimalMultiplyNumber(NSString * _Nullable oneString, NSString * _Nullable twoString, short scale){
    
    NSDecimalNumber *oneDecimal = YYBBDecimalNumber(oneString, scale);
    NSDecimalNumber *twoDecimal = YYBBDecimalNumber(twoString, scale);
    NSDecimalNumber *resultDecimal = [oneDecimal decimalNumberByMultiplyingBy:twoDecimal];
    return resultDecimal.stringValue;
};

// 比较两个字符串
static inline NSComparisonResult YYBBCompareDecimalNumbers(NSString * _Nullable oneString, NSString * _Nullable twoString){
    NSDecimalNumber *oneDecimal = [NSDecimalNumber decimalNumberWithString:oneString];
    NSDecimalNumber *twoDecimal = [NSDecimalNumber decimalNumberWithString:twoString];
    NSComparisonResult result = [oneDecimal compare:twoDecimal];
    return result;
};

// 将经纬度写入照片中
static inline NSData * _Nonnull YYBBLocationImageData(NSData * _Nullable originalImageData, CLLocationCoordinate2D coordinate) {
    if (originalImageData == nil) {
        return nil;
    }
    
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    
    CGImageSourceRef imgSource = CGImageSourceCreateWithData((__bridge_retained CFDataRef)originalImageData, NULL);
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imgSource, 0, NULL)];
    NSMutableDictionary *GPSDictionary = [[mediaInfo objectForKey:(NSString *)kCGImagePropertyGPSDictionary] mutableCopy];
    
    if(!GPSDictionary) {
        GPSDictionary = [[NSMutableDictionary dictionary] init];
    }
    [GPSDictionary setValue:[NSNumber numberWithFloat:latitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];
    [GPSDictionary setValue:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
    [GPSDictionary setValue:[NSNumber numberWithFloat:longitude]  forKey:(NSString*)kCGImagePropertyGPSLongitude];
    [GPSDictionary setValue:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
    [GPSDictionary setValue:[NSNumber numberWithFloat:latitude] forKey:(NSString*)kCGImagePropertyGPSDestLatitude];
    [GPSDictionary setValue:@"N" forKey:(NSString*)kCGImagePropertyGPSDestLatitudeRef];
    [GPSDictionary setValue:[NSNumber numberWithFloat:longitude] forKey:(NSString*)kCGImagePropertyGPSDestLongitude];
    [GPSDictionary setValue:@"E" forKey:(NSString*)kCGImagePropertyGPSDestLongitudeRef];
    [mediaInfo setValue:GPSDictionary forKey:(NSString *)kCGImagePropertyGPSDictionary];
    
    CFStringRef UTI = CGImageSourceGetType(imgSource); //this is the type of image (e.g., public.jpeg)
    
    //this will be the data CGImageDestinationRef will write into
    NSMutableData *newImageData = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1, NULL);
    
    if(!destination) {
        NSLog(@"***Could not create image destination ***");
    }
    
    CGImageDestinationAddImageFromSource(destination, imgSource, 0, (__bridge CFDictionaryRef) mediaInfo);
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);
    if (success) {
        return newImageData;
    } else {
        return nil;
    }
}

// OpenURL
static inline void YYBBOpenURL(NSString * _Nonnull urlStr) {
    if (![urlStr yybb_isNotEmpty]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    if (!url) {
        return;
    }
    // 大于等于10.0系统使用此openURL方法
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 打电话
static inline void YYBBMakeATelephoneWithPhoneNum(NSString * _Nonnull phoneNum) {
    if (![phoneNum yybb_isNotEmpty]) {
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    YYBBOpenURL(callPhone);
}

// 客服电话
static inline void YYBBCallServiceTel() {
    YYBBMakeATelephoneWithPhoneNum(YYBBService_Tel);
}

// 必填富文本
static inline NSAttributedString * YYBBRequiredContent(NSString *content, BOOL isRequired, BOOL isPrefix) {
    NSAttributedString * (^block)(void) = ^NSAttributedString * {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"*"];
        one.yy_font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        one.yy_color = UIColorHex(#EA4335);
        return one.copy;
    };
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    if (isRequired && isPrefix) {
        [text appendAttributedString:block()];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:content];
        one.yy_font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        one.yy_color = [UIColor yybb_blackColor];;
        [text appendAttributedString:one.copy];
    }
    if (isRequired && !isPrefix) {
        [text appendAttributedString:block()];
    }
    return text.copy;
}

static inline UIImage * _Nullable YYBBImageNamed(NSString * _Nullable name) {
    UIImage *image = [UIImage imageNamed:[YYBBSDKBundle().resourcePath stringByAppendingPathComponent:name]];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

static inline UIImage * _Nullable YYBBMallImageNamed(NSString * _Nonnull name) {
    NSString *realName = [NSString stringWithFormat:@"Mall/%@", name];
    return YYBBImageNamed(realName);
}

static inline NSBundle * _Nullable YYBBCustomSDKBundle(NSString * _Nonnull bundleName) {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"YYBBSDK")];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    return [NSBundle bundleWithURL:bundleURL];
}

static inline UIImage * _Nullable YYBBBundleImageNamed(NSString * _Nonnull name, NSBundle * _Nullable bundle) {
    UIImage *image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

static CGFloat const kNavgationBarHeight  = 44;
static CGFloat const kTabBarHeight        = 49;
static CGFloat const kIphoneXBottomHeight = 34;

static inline CGFloat YYBBNavBarHeight() {
    return kNavgationBarHeight;
}

static inline CGFloat YYBBStatusBarHeight() {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

static inline CGFloat YYBBNavHeight() {
    return YYBBStatusBarHeight() + YYBBNavBarHeight();
}

static inline CGFloat YYBBBottomHeight() {
    if (isIPhoneXSeries()) {
        return kIphoneXBottomHeight;
    }
    return 0;
}

static inline CGFloat YYBBTabBarHeight() {
    return kTabBarHeight + YYBBBottomHeight();
}

static inline void swizzleMethod(Class _Nonnull class, SEL _Nonnull originalSelector, SEL _Nonnull swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/*
    版本比较
    @param currentVersion 当前版本
    @param newestVersion 最新版本
     If:
        currentVersion < newestVersion   return NSOrderedAscending.
        currentVersion < newestVersion   return NSOrderedDescending
        currentVersion  ==  newestVersion  return NSOrderedSame
 */
static inline NSComparisonResult YYBBCompareVersion(NSString *currentVersion, NSString *newestVersion) {
    NSArray *currentVersions = [currentVersion componentsSeparatedByString:@"."];
    NSArray *newestVersions = [newestVersion componentsSeparatedByString:@"."];
    NSInteger curretnVersionsCount = currentVersions.count;
    NSInteger newestVersionsCount = newestVersions.count;
    NSInteger maxVersionsCount = MAX(curretnVersionsCount, newestVersionsCount);
    for (NSInteger i = 0; i < maxVersionsCount; i++) {
        NSInteger v1 = i < curretnVersionsCount ? [currentVersions[i] integerValue] : 0;
        NSInteger v2 = i < newestVersionsCount ? [newestVersions[i] integerValue] : 0;
        if (v1 < v2) {
            return NSOrderedAscending;
        } else if (v1 > v2) {
            return NSOrderedDescending;
        }
    }
    return NSOrderedSame;
}


#endif /* YYBBUtilsMacro_h */
