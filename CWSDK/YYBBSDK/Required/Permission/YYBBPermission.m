//
//  YYBBPermission.m
//  DaDongMen
//
//  Created by WangRuzhou on 3/28/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//

#import "YYBBPermission.h"
#import "YYBBUtilsMacro.h"

@implementation YYBBPermission

+ (void)authorizeWithPermission:(JLPermissionsCore *)permission completion:(YYBBPermissionAuthorizationHandler)completion {
    JLAuthorizationStatus authorizationStatus = [permission authorizationStatus];
    
    NSString *className = NSStringFromClass([permission class]);
    
    if (JLPermissionDenied == authorizationStatus) {
        NSString *alertTitleKey = [NSString stringWithFormat:@"%@.deny.title", className];
        NSString *messageKey = [NSString stringWithFormat:@"%@.deny.message", className];
        NSString *openSettingsTitleKey = [NSString stringWithFormat:@"%@.deny.openSettingsApp", className];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:YYBBLocalizableString(alertTitleKey)
                                                                                 message:YYBBLocalizableString(messageKey)
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:YYBBLocalizableString(openSettingsTitleKey) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *settingsAppURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:settingsAppURL];
        }]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    }
    else {
        NSString *authorizeTitleKey = [NSString stringWithFormat:@"%@.title", className];
        NSString *authorizeMessageKey = [NSString stringWithFormat:@"%@.message", className];
        NSString *cancelTitleKey = [NSString stringWithFormat:@"拒绝"];
        NSString *grantTitleKey = [NSString stringWithFormat:@"允许"];
        
        NSString *authorizeTitle = YYBBLocalizableString(authorizeTitleKey);
        NSString *authorizeMessage = YYBBLocalizableString(authorizeMessageKey);
        NSString *cancelTitle = YYBBLocalizableString(cancelTitleKey);
        NSString *grantTitle = YYBBLocalizableString(grantTitleKey);
        
        [(id)permission authorizeWithTitle:authorizeTitle
                                   message:authorizeMessage
                               cancelTitle:cancelTitle
                                grantTitle:grantTitle
                                completion:^(BOOL granted, NSError *error) {
            YYBBRunOnMainThread(^{
                !completion ?: completion(granted, error);
            });
        }];
    }
}

@end
