//
//  UIDevice+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/2.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import "UIDevice+YYBBAdd.h"
#include <sys/sysctl.h>
#import <AdSupport/AdSupport.h>
#import "MFSIdentifier.h"
#import "YYBBUtilsMacro.h"
#import <YYCategories/NSString+YYAdd.h>
#import "NSString+YYBBAdd.h"

@implementation UIDevice (YYBBAdd)

- (BOOL)isIPhoneXSeries {
    static dispatch_once_t onceToken;
    static BOOL result = NO;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                result = YES;
            }
        }
    });
    return result;
}

- (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

- (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch2,7" : @"Apple Watch Series 1 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch3,1" : @"Apple Watch Series 3 38mm",
                              @"Watch3,2" : @"Apple Watch Series 3 42mm",
                              @"Watch3,3" : @"Apple Watch Series 3 38mm",
                              @"Watch3,4" : @"Apple Watch Series 3 42mm",
                              @"Watch4,1" : @"Apple Watch Series 4 40mm",
                              @"Watch4,2" : @"Apple Watch Series 4 44mm",
                              @"Watch4,3" : @"Apple Watch Series 4 40mm",
                              @"Watch4,4" : @"Apple Watch Series 4 44mm",
                              @"Watch5,1" : @"Apple Watch Series 5 40mm",
                              @"Watch5,2" : @"Apple Watch Series 5 44mm",
                              @"Watch5,3" : @"Apple Watch Series 5 40mm",
                              @"Watch5,4" : @"Apple Watch Series 5 44mm",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              
                              @"iPhone10,1" : @"iPhone 8",
                              @"iPhone10,2" : @"iPhone 8 Plus",
                              @"iPhone10,3" : @"iPhone X",
                              @"iPhone10,4" : @"iPhone 8",
                              @"iPhone10,5" : @"iPhone 8 Plus",
                              @"iPhone10,6" : @"iPhone X",
                              
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,8" : @"iPhone XR",
                              @"iPhone11,6" : @"iPhone XS Max",
                              
                              @"iPhone12,1" : @"iPhone 11",
                              @"iPhone12,3" : @"iPhone 11 Pro",
                              @"iPhone12,5" : @"iPhone 11 Pro Max",
                              
                              @"iPhone12,8" : @"iPhone SE2",
                              
                              @"iPhone13,1" : @"iPhone 12 mini",
                              @"iPhone13,2" : @"iPhone 12",
                              @"iPhone13,3" : @"iPhone 12 Pro",
                              @"iPhone13,4" : @"iPhone 12 Pro Max",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              
                              @"iPad6,11" : @"iPad 5",
                              @"iPad6,12" : @"iPad 5",
                              
                              @"iPad7,1" : @"iPad Pro (12.9-inch, 2)",
                              @"iPad7,2" : @"iPad Pro (12.9-inch, 2)",
                              @"iPad7,3" : @"iPad Pro (10.5-inch)",
                              @"iPad7,4" : @"iPad Pro (10.5-inch)",
                              @"iPad7,5" : @"iPad 6",
                              @"iPad7,6" : @"iPad 6",
                              
                              @"iPad7,11" : @"iPad 7",
                              @"iPad7,12" : @"iPad 7",
                              
                              @"iPad8,1" : @"iPad Pro (11-inch)",
                              @"iPad8,2" : @"iPad Pro (11-inch)",
                              @"iPad8,3" : @"iPad Pro (11-inch)",
                              @"iPad8,4" : @"iPad Pro (11-inch)",
                              @"iPad8,5" : @"iPad Pro (12.9-inch, 3)",
                              @"iPad8,6" : @"iPad Pro (12.9-inch, 3)",
                              @"iPad8,7" : @"iPad Pro (12.9-inch, 3)",
                              @"iPad8,8" : @"iPad Pro (12.9-inch, 3)",
                              @"iPad8,9" : @"iPad Pro (11-inch, 2)",
                              @"iPad8,10" : @"iPad Pro (11-inch, 2)",
                              @"iPad8,11" : @"iPad Pro (12.9-inch, 4)",
                              @"iPad8,12" : @"iPad Pro (12.9-inch, 4)",
                              
                              @"iPad11,1" : @"iPad mini 5",
                              @"iPad11,2" : @"iPad mini 5",
                            
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

+ (NSString *)yybb_idfa {
    // 先拿IDFA
    NSString *idfa = @"";
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    if ([manager isAdvertisingTrackingEnabled]) {
        idfa = [[manager advertisingIdentifier] UUIDString];
    }
    return idfa;
}

+ (NSString *)yybb_deviceId {
    NSString *deviceID = [[NSUserDefaults standardUserDefaults] stringForKey:YYBBDeviceIDKey];
    if (deviceID.length != 0) {
        return deviceID;
    }
    
    // 先拿IDFA
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    if ([manager isAdvertisingTrackingEnabled]) {
        deviceID = [[manager advertisingIdentifier] UUIDString];
        // 拿不到再拿
    } else {
        deviceID = [MFSIdentifier deviceID];
    }
    
    deviceID = [deviceID md5String];
    [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:YYBBDeviceIDKey];
    return deviceID;
}


+ (NSString *)yybb_getGuestDeviceID {
    BOOL isNeedReset = [[NSUserDefaults standardUserDefaults] boolForKey:YYBBIsNeedResetDeviceIDKey];
    NSString *deviceID = [[NSUserDefaults standardUserDefaults] stringForKey:YYBBGuestDeviceIDKey];
    if (deviceID.length == 0) {
        deviceID = [NSString stringWithFormat:@"%@-0", [self yybb_deviceId]];
    }
    
    if (isNeedReset) {
        NSString *lastChar = [deviceID substringFromIndexSafe:deviceID.length - 1];
        NSInteger index = [lastChar integerValue];
        index += 1;
        deviceID = [NSString stringWithFormat:@"%@-%@", [self yybb_deviceId], @(index)];
    }
    [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:YYBBGuestDeviceIDKey];
    return deviceID;
}

/// 输入要强制转屏的方向
/// @param interfaceOrientation 转屏的方向
+ (void)deviceMandatoryLandscapeWithNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];

    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    // 将输入的转屏方向（枚举）转换成Int类型
    int orientation = (int)interfaceOrientation;

    // 对象包装
    NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];

    // 实现横竖屏旋转
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

@end
