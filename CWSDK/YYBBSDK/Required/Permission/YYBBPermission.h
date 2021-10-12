//
//  YYBBPermission.h
//  DaDongMen
//
//  Created by WangRuzhou on 3/28/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//


#import <JLPermissions/JLPermissionsCore.h>
#import <JLPermissions/JLPhotosPermission.h>
#import <JLPermissions/JLCameraPermission.h>
#import <JLPermissions/JLLocationPermission.h>
#import <JLPermissions/JLContactsPermission.h>
#import <JLPermissions/JLNotificationPermission.h>

typedef void (^YYBBPermissionAuthorizationHandler)(BOOL granted, NSError *error);

@interface YYBBPermission : NSObject

+ (void)authorizeWithPermission:(JLPermissionsCore *)permission completion:(YYBBPermissionAuthorizationHandler)completion;


@end
