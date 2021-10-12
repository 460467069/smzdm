//
//  YYBBSDK_Facebook.m
//  YYBBSDK_Facebook
//
//  Created by Killua Liu on 1/23/17.
//  Copyright © 2017 yybbsdk. All rights reserved.
//

#import "YYBBSDK_Facebook.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import "YYBBAlertDialog.h"
#import "YYBBKit.h"

@interface YYBBSDK_Facebook () <FBSDKSharingDelegate, FBSDKGameRequestDialogDelegate>

@property (nonatomic, strong) FBSDKLoginManager *loginManager;

@end

@implementation YYBBSDK_Facebook

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YYBBServerConfig *config = [YYBBServerConfig currentConfig];
    if (config.facebookAppId == nil) {
        return YES;
    }
     
    [FBSDKSettings setAppID:config.facebookAppId];
    [FBSDKSettings setLoggingBehaviors:[NSSet setWithArray:@[FBSDKLoggingBehaviorAccessTokens,
                                                             FBSDKLoggingBehaviorPerformanceCharacteristics,
                                                             FBSDKLoggingBehaviorAppEvents,
                                                             FBSDKLoggingBehaviorInformational,
                                                             FBSDKLoggingBehaviorCacheErrors,
                                                             FBSDKLoggingBehaviorUIControlErrors,
                                                             FBSDKLoggingBehaviorGraphAPIDebugWarning,
                                                             FBSDKLoggingBehaviorGraphAPIDebugInfo,
                                                             FBSDKLoggingBehaviorNetworkRequests,
                                                             FBSDKLoggingBehaviorDeveloperErrors]]];
    [FBSDKSettings setDisplayName:YYBBAppName()];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    self.loginType = YYBBLoginTypeFacebook;
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:[YYBBServerConfig currentConfig].facebookUrlScheme]){
        NSLog(@"FB application openURL options");
        [[FBSDKApplicationDelegate sharedInstance] application:app
                                                       openURL:url
                                             sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSDKAppEvents activateApp];
}


#pragma mark - FaceBook login
- (void)requestAuth {
    [self.loginManager logOut];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self loadCurrentProfile];
    } else {
        [self.loginManager logInWithPermissions:@[@"public_profile"] fromViewController:self.viewController handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
            [self didLogin:result withRrror:error];
        }];
    }
}

- (void)didLogin:(FBSDKLoginManagerLoginResult *)result withRrror:(NSError *)error
{
    if (error) {
        NSLog(@"Facebook login error: %@", error.localizedDescription);
        [self loginOrBindAccountToThirdFailed];
    } else if (result.isCancelled) {
        NSLog(@"Facebook login cancelled");
        [self loginOrBindAccountToThirdCanceled];
    } else {
        self.accessToken   = result.token.tokenString;
        [self loadCurrentProfile];
    }
}

- (void)loadCurrentProfile {
    @weakify(self)
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{ @"fields": @"token_for_business,id,name",}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        @strongify(self)
        if (error) {
            [self loginOrBindAccountToThirdFailed];
        } else {
            self.openID   = result[@"token_for_business"];
            self.openName = result[@"name"];
            [self loginOrBindAccountToOwnServer];
        }
    }];
}

#pragma mark - Logout
- (void)thirdLogout {
    if ([YYBBUser currentUser].loginType == self.loginType) {
        [self.loginManager logOut];
    }
}

#pragma mark - Share
- (NSArray *)supportPlatforms
{
    return @[@"Facebook"];
}

- (void)like
{
    NSLog(@"Start like");
}

- (void)share:(YYBBShareInfo *)params
{
    FBSDKShareLinkContent *content = [FBSDKShareLinkContent new];
    content.contentURL = [NSURL URLWithString:params.url];
    
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.shareContent = content;
    dialog.fromViewController = [YYBBSDK sharedInstance].getViewController;
    dialog.delegate = self;
    dialog.mode = FBSDKShareDialogModeNative;
    [dialog show];
}

- (void)shareTo:(NSString *)platform shareParams:(YYBBShareInfo *)params
{
    [self share:params];
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"Facebook share results: %@", results);
    
    NSString *postId = results[@"postId"];
    FBSDKShareDialog *dialog = (FBSDKShareDialog *)sharer;
    if (dialog.mode == FBSDKShareDialogModeBrowser && postId.length == 0) {
        NSLog(@"Facebook share cancelled by click done");
        return;
    }
    
    YYBBUser *user = [YYBBUser currentUser];
    YYBBRoleExtraModel *roleExtraModel = [YYBBRoleExtraModel currentExtraModel];
    NSDictionary *parameters = @{ @"appID": [YYBBSDK sharedInstance].config.appId,
                                  @"channelID": [YYBBSDK sharedInstance].config.channelId,
                                  @"userID": user.userID,
                                  @"roleID": roleExtraModel.roleID,
                                  @"serverID": roleExtraModel.serverID,
                                  YYBBPlatformKey: YYBBPlatform,
                                  @"type": @(2),
                                  @"receiptId": roleExtraModel.roleID };
    
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_POST:[YYBBServerConfig currentConfig].saveShareInfo parameters:parameters serverSuccessBlcok:^(id  _Nonnull responseObj) {
        NSLog(@"Facebook share successful");
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"Facebook share error: %@", error.description);
    
    FBSDKShareDialog *dialog = (FBSDKShareDialog *)sharer;
    if (error == nil && dialog.mode == FBSDKShareDialogModeNative) {
        dialog.mode = FBSDKShareDialogModeBrowser;
        [dialog show];
    }
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"Facebook share cancelled");
}

#pragma mark - Invite
- (void)invite
{
    FBSDKGameRequestContent *grContent = [FBSDKGameRequestContent new];
    grContent.message = self.params[@"inviteContent"];
    grContent.filters = FBSDKGameRequestFilterAppNonUsers;
    [FBSDKGameRequestDialog showWithContent:grContent delegate:self];
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"Facebook invite results: %@", results);
    
    if ([results[@"completionGesture"] isEqualToString:@"cancel"]) return;
    
    if(results){
        YYBBUser *user = [YYBBUser currentUser];
        YYBBRoleExtraModel *roleExtraModel = [YYBBRoleExtraModel currentExtraModel];
        NSDictionary *parameters = @{ @"appID": [YYBBSDK sharedInstance].config.appId,
                                      @"channelID": [YYBBSDK sharedInstance].config.channelId,
                                      @"userID": user.userID,
                                      @"roleID": roleExtraModel.roleID,
                                      @"serverID": roleExtraModel.serverID,
                                      YYBBPlatformKey: YYBBPlatform,
                                      @"type": @(3),
                                      @"receiptId": [results[@"to"] componentsJoinedByString:@","]};
        [[YYBBAPPDotNetAPIClient sharedClient] YYBB_POST:[YYBBServerConfig currentConfig].saveShareInfo parameters:parameters serverSuccessBlcok:^(id  _Nonnull responseObj) {
            NSLog(@"Facebook share successful");
        } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
            
        } failureBlock:^(NSError * _Nonnull error) {
            
        }];
    }
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didFailWithError:(NSError *)error
{
    NSLog(@"Facebook invite error: %@", error.description);
}

- (void)gameRequestDialogDidCancel:(FBSDKGameRequestDialog *)gameRequestDialog
{
    NSLog(@"Facebook invite cancelled");
}

#pragma mark - getter && setter
- (FBSDKLoginManager *)loginManager
{
    if (!_loginManager) {
        _loginManager = [FBSDKLoginManager new];
    }
    return _loginManager;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
