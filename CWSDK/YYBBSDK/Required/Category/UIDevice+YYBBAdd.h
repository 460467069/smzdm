//
//  UIDevice+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/2.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YYBBAdd)

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModel;
/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModelName;
@property (nonatomic, readonly) BOOL isIPhoneXSeries;

+ (NSString *)yybb_deviceId;
+ (NSString *)yybb_idfa;
+ (NSString *)yybb_getGuestDeviceID;


/// 输入要强制转屏的方向
/// @param interfaceOrientation 转屏的方向
+ (void)deviceMandatoryLandscapeWithNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
