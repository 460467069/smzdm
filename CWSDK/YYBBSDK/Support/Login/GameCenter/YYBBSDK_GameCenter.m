//
//  YYBBSDK_GameCenter.m
//  YYBBSDK_GameCenter
//
//  Created by Killua Liu on 1/22/17.
//  Copyright © 2017 yybbsdk. All rights reserved.
//

#import "YYBBSDK_GameCenter.h"
#import "YYBBAlertDialog.h"
#import "YYBBReachability.h"
#import "YYBBKit.h"

@import GameKit;

@interface YYBBSDK_GameCenter () <YYBBAlertDialogDelegate>

@property (nonatomic, assign) BOOL isCheckGameCenter;    //是否检测过GameCenter 和gameCenterEnabled 一起判断是否需要提示玩家去GameCenter登录后再重新打开游戏
@property (nonatomic, assign) BOOL gameCenterEnabled;

@end

@implementation YYBBSDK_GameCenter

#pragma mark - UIApplicationDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {
    self.loginType = YYBBLoginTypeGameCenter;
}

#pragma mark - Login view controller

- (void)requestAuth
{
    if (self.isCheckGameCenter && self.gameCenterEnabled == NO) {
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:[YYBBLanguage currentLanguage].alert_dialog_button_title_okay
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
            [self loginOrBindAccountToThirdCanceled];
        }];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[YYBBLanguage currentLanguage].game_center_login_failed
                                                                                 message:[YYBBLanguage currentLanguage].game_center_login_failed_tip
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:okayAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    BOOL isInternetAvailable = [self isInternetAvailable];
    if (!isInternetAvailable) {
        YYBBAlertDialog *alertDialog = [YYBBAlertDialog new];
        [alertDialog showOkayWithMessage:[YYBBLanguage currentLanguage].network_error inView:self.view];
        return;
    }
    BOOL isAuthenticated = GKLocalPlayer.localPlayer.isAuthenticated;
    if (isAuthenticated) {
        [self generateIdentityVerificationSignature];
        return;
    }
    @weakify(self)
    GKLocalPlayer.localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        @strongify(self)
        if (self.isLoggingAccount == NO) {
            return ;
        }
        [self.class cancelPreviousPerformRequestsWithTarget:self];
        if (viewController) {
            [self.viewController presentViewController:viewController animated:YES completion:nil];
        } else {
            self.isCheckGameCenter = YES;
            if (error) {
                if (error.code == GKErrorCancelled || error.code == GKErrorNotAuthenticated) {
                    [self resetPlayerAuthenticateHandler];
                    [self loginOrBindAccountToThirdCanceled];
                } else {
                    [self handleLoginError];
                }
                self.gameCenterEnabled = NO;
            } else if (GKLocalPlayer.localPlayer.isAuthenticated) {
                NSLog(@"GameCenter player is authenticated");
                [self generateIdentityVerificationSignature];
                self.gameCenterEnabled = YES;
            }
        }
    };
    
    // Set timer to avoid game center is hang
//    [self performSelector:@selector(handleLoginError) withObject:nil afterDelay:60];
}

- (void)thirdLogout {
    if ([YYBBUser currentUser].loginType == self.loginType) {
        [self resetPlayerAuthenticateHandler];
    }
}

- (void)generateIdentityVerificationSignature {
    @weakify(self)
    [GKLocalPlayer.localPlayer generateIdentityVerificationSignatureWithCompletionHandler:^(NSURL * _Nullable publicKeyUrl, NSData * _Nullable signature, NSData * _Nullable salt, uint64_t timestamp, NSError * _Nullable error) {
        @strongify(self)
        if (self.isLoggingAccount == NO) {
            return ;
        }
        if (error) {
            NSLog(@"Generate Signature Error: %@", error.debugDescription);
            [self handleLoginError];
        } else {
            self.playerParams = @{ @"publicKeyUrl": AFPercentEscapedStringFromString(publicKeyUrl.absoluteString),
                                   @"playerID": GKLocalPlayer.localPlayer.playerID,
                                   @"bundleID": NSBundle.mainBundle.bundleIdentifier,
                                   @"timestamp": @(timestamp),
                                   @"signature": [signature base64EncodedStringWithOptions:kNilOptions],
                                   @"salt": [salt base64EncodedStringWithOptions:kNilOptions] };
            self.openID        = GKLocalPlayer.localPlayer.playerID;
            self.openName      = GKLocalPlayer.localPlayer.displayName;
            [self loginOrBindAccountToOwnServer];
        }
    }];
}

// Avoid GC invoked multiple time
- (void)resetPlayerAuthenticateHandler
{
    GKLocalPlayer.localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) { };
}

- (void)handleLoginError
{
    [self resetPlayerAuthenticateHandler];
    [self loginOrBindAccountToThirdFailed];
}

- (void)loginWithSocialAccount
{
    [self.class cancelPreviousPerformRequestsWithTarget:self];
    
    @synchronized (self) {
        [super loginWithSocialAccount];
    }
}

#pragma mark - Bind account
// 登录或绑定成功后逻辑处理
- (void)loginOrBindAccountToOwnServerSuccessHandler {
    [super loginOrBindAccountToOwnServerSuccessHandler];
    [self resetPlayerAuthenticateHandler];
}

// Check for internet with Reachability
- (BOOL)isInternetAvailable {
    YYBBReachability *reachability = [YYBBReachability reachabilityForInternetConnection];
    YYBBNetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

@end
