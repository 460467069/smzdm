//
//  YYBBLoginManagerPlugin.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/23.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSDK_LoginManager.h"
#import "YYBBAgreementDialog.h"
#import "YYBBWebViewController.h"
#import "YYBBAlertDialog.h"
#import "YYBBBindingDialog.h"
#import "YYBBLoginViewController.h"
#import "YYBBRoleExtraModel.h"
#import "PopupWebView.h"

NSString *const YYBBLocalAgreementVersionKey = @"YYBB_localAgreementVersion";

@interface YYBBSDK_LoginManager()<YYBBBindingDialogDelegate, YYBBAgreementDialogDelegate, YYBBBindingDialogDelegate>
@property (strong, nonatomic) YYBBAlertDialog *guestWarningDialog;
@property (strong, nonatomic) YYBBLoginViewController *loginVC;
@end

@implementation YYBBSDK_LoginManager

@synthesize agreement, user, roleExtraModel, loginTypes;

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![NSUserDefaults.standardUserDefaults objectForKey:YYBBLocalAgreementVersionKey]) {
            [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:YYBBLocalAgreementVersionKey];
        }
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didUserLogin:) name:YYBBSDKUserLogin object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didUserLogout:) name:YYBBSDKUserLogout object:nil];
    }
    
    NSString *userStr = [[NSUserDefaults standardUserDefaults] valueForKey:YYBBLoginedUserKey];
    if (userStr) {
        self.user = [YYBBUser modelWithJSON:userStr];
    }
    
    YYBBSDK.sharedInstance.loginManagerDelegate = self;
    return self;
}

#pragma mark - YYBBLoginManagerDelegate
- (void)login {
    @weakify(self)
    NSDictionary *parameters = @{ @"appID": YYBBSDK.sharedInstance.appId,
                                  @"channelID": YYBBSDK.sharedInstance.channelId,
                                  YYBBAppBuildKey: YYBBAppBuild(),
                                  YYBBAppVersionKey: YYBBAppVersion() };
    
    [YYBBSessionManager POST:kYYBB_GetIOSLoginType parameters:parameters success:^(id responseData) {
        @strongify(self)
        NSLog(@"Fetch login types successfully!!!");
        self.agreement = [YYBBAgreement modelWithJSON:responseData];
        NSString *loginTypeString = [responseData objectForKey:@"type"];
        self.loginTypes = [loginTypeString componentsSeparatedByString:@"&"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (agreement.serverAgreementVersion != self.localAgreementVersion) {
                [self showAgreementDialog];
            } else {
                [self performLogin];
            }
        });
    } failure:nil];
}

- (void)updateRole:(NSDictionary*) params {
    YYBBRoleExtraModel *roleExtraModel = [YYBBRoleExtraModel modelWithJSON:params];
    self.roleExtraModel = roleExtraModel;
    
    NSString *deviceID = [UIDevice yybb_deviceId];
    YYBBUser *user = [YYBBUser currentUser];
    //Report Login log to Server
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userID"]        = user.userID;
    parameters[@"roleID"]        = roleExtraModel.roleID;
    parameters[@"roleName"]      = roleExtraModel.roleName;
    parameters[@"roleLevel"]     = roleExtraModel.roleLevel;
    parameters[@"serverID"]      = roleExtraModel.serverID;
    parameters[@"serverName"]    = roleExtraModel.serverName;
    parameters[@"society"]       = roleExtraModel.society;
    parameters[@"vip"]           = roleExtraModel.vip;
    parameters[@"power"]         = roleExtraModel.power;
    parameters[@"cpChannelID"]   = roleExtraModel.cpChannelID;
    parameters[@"deviceID"]      = deviceID;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObjectSafe:user.userID];
    [tempArray addObjectSafe:roleExtraModel.roleID];
    [tempArray addObjectSafe:roleExtraModel.serverID];
    [tempArray addObjectSafe:deviceID];
    [tempArray addObjectSafe:roleExtraModel.roleLevel];
    [tempArray addObjectSafe:roleExtraModel.roleName];
    [parameters addEntriesFromDictionary:[tempArray signParameters]];
    
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_Post:kYYBB_UpdateRole parameters:parameters serverSuccessBlcok:nil serverErrorMsgBlcok:nil failureBlock:nil];
    
    [self getSecondNotice];
}

- (void)showLoginErrorDialog {
    YYBBAlertDialog *alertDialog = [YYBBAlertDialog new];
    alertDialog.delegate = self;
    [alertDialog showWithMessage:self.agreement.errorMsg inView:self.view];
}

- (void)showBindingDialog {
    YYBBBindingDialog *bindingDialog = [YYBBBindingDialog new];
    bindingDialog.delegate = self;
    [bindingDialog showWithMessage:self.agreement.bind_msg inView:self.view];
}

#pragma mark - Private
- (void)performLogin
{
    if (self.user) {
        if (self.user.loginType == YYBBLoginTypeGuest) {
            [self showGuestWarningDialog];
        } else {
            [self getToken];
        }
    } else {
        [self showLoginViewController];
    }
}

- (void)getToken
{
    YYBBUser *user = [YYBBUser currentUser];
    YYBBLoginType loginType = user.loginType;
    NSMutableDictionary *extension = [@{ YYBBAppVersionKey: YYBBAppVersion(),
                                         YYBBAppBuildKey: YYBBAppBuild(),
                                         YYBBLoginTypeKey: @(loginType),
                                         YYBBPlatformKey: YYBBPlatform } mutableCopy];
    
    if (loginType == YYBBLoginTypeGameCenter) {
        extension[YYBBDeviceIDKey] = [UIDevice yybb_deviceId];
        [extension addEntriesFromDictionary:user.playerParams];
    } else {
        extension[YYBBOpenNameKey] = user.openName;
        extension[YYBBOpenIDKey] = user.openID;
        if (loginType != YYBBLoginTypeGuest) {
            extension[YYBBAccessTokenKey] = user.token;
        }
    }
    
    [self loginWithExtensionParams:[extension copy] loginType:loginType success:^{
        
    }];
}

- (void)postUserDidLoginNotification:(id)responseData
{
    [NSNotificationCenter.defaultCenter postNotificationName:YYBBSDKUserLogin object:nil userInfo:@{@"extension": responseData}];
}

#pragma mark - YYBBBindingDialogDelegate
- (void)showAgreementDialog
{
    YYBBAgreementDialog *agreementDialog = [YYBBAgreementDialog new];
    agreementDialog.delegate = self;
    [agreementDialog showWithAgreement:self.agreement inView:[UIViewController currentViewController].view];
}

- (void)didTapOkayButtonInAgreementDialog:(YYBBAgreementDialog *)agreementDialog
{
    [[NSUserDefaults standardUserDefaults] setInteger:self.agreement.serverAgreementVersion forKey:YYBBLocalAgreementVersionKey];
    [self performLogin];
}

- (void)agreementDialog:(YYBBAgreementDialog *)agreementDialog didTapDetailButtonWithURLString:(NSString *)urlString
{
    YYBBWebViewController *webVC = [YYBBWebViewController new];
    [[UIViewController currentViewController] presentViewController:webVC animated:YES completion:^{
        [webVC loadURLString:urlString];
    }];
}

#pragma mark - Alert dialog

- (void)showGuestWarningDialog
{
    self.guestWarningDialog = [YYBBAlertDialog new];
    self.guestWarningDialog.delegate = self;
    //"当前使用guest登录，为避免用户丢失，请进入游戏后进行绑定。"
    NSLog(@"-----Show Guest Warning Dialog:%@",self.agreement.bind_msg);
    [self.guestWarningDialog showWithMessage:self.agreement.bind_msg inView:[UIViewController currentViewController].view];
}

#pragma mark - YYBBAlertDialogDelegate
- (void)didTapOkayButtonInAlertDialog:(YYBBAlertDialog *)alertDialog
{
    if (alertDialog == self.guestWarningDialog) {
        [self getToken];
    } else {
        [[[YYBBSDK sharedInstance] pluginByLoginType:YYBBLoginTypeGuest] login];
    }
}

- (void)didTapCancelButtonInAlertDialog:(YYBBAlertDialog *)alertDialog
{
    if (alertDialog == self.guestWarningDialog) {
        [self didUserLogout:nil];
        [self showLoginViewController];
    }
}

#pragma mark - NSNotification
- (void)didUserLogout:(NSNotification *)notification
{
    self.user = nil;
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:YYBBLoginedUserKey];
}

- (void)didUserLogin:(NSNotification *)notification
{
    NSDictionary *extension = [notification.userInfo objectForKey:@"extension"];
    
    [self removeLoginViewController];
    [self showUpdateDialog:extension];
    
    //AppsFlyer登录成功上报
    [YYBBSDK.sharedInstance.analyticsDelegate userLogin];
}

#pragma mark - Binding dialog
- (void)bindingDialog:(YYBBBindingDialog *)bindingDialog didTapLoginButtonWithType:(YYBBLoginType)loginType
{
    [[[YYBBSDK sharedInstance] pluginByLoginType:loginType] bindAccount];
}

- (void)showUserTermsg
{
    YYBBWebViewController *webVC = [YYBBWebViewController new];
    NSString *urlString = self.agreement.agreementUrl1;
    [[UIViewController currentViewController] presentViewController:webVC animated:YES completion:^{
        [webVC loadURLString:urlString];
    }];
}

- (void)showPrivacy
{
    YYBBWebViewController *webVC = [YYBBWebViewController new];
    NSString *urlString = self.agreement.agreementUrl2;
    [[UIViewController currentViewController] presentViewController:webVC animated:YES completion:^{
        [webVC loadURLString:urlString];
    }];
}

- (void)showFirstNotice {
    //Prepare to show first notice
    NSDictionary *parameters = @{ @"appID": YYBBSDK.sharedInstance.appId,
                                  @"channelID": YYBBSDK.sharedInstance.channelId,
                                  YYBBAppBuildKey: YYBBAppBuild(),
                                  YYBBAppVersionKey: YYBBAppVersion() };
    @weakify(self)
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_Post:kYYBB_GetFirstNotice parameters:[parameters signParameters] serverSuccessBlcok:^(id  _Nonnull responseObj) {
        NSLog(@"Get 1st notice successfully!!!");
        @strongify(self)
        NSDictionary *extension = [responseObj objectForKey:@"extension"];
        if (extension) {
            NSInteger state = [extension[@"state"] integerValue];
            NSArray<NSString *> *popupURLStrings = extension[@"urls"];
            if (state == 1) {
                NSLog(@"start 1st popup!!!");
                [self showNoticeWithUrls:popupURLStrings index:0];
            }
        }
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)showNoticeWithUrls:(NSArray *)urls index:(NSUInteger)index
{
    if (urls.count == 0) {
        return;
    }
    NSUInteger newIndex = index + 1;
    UIViewController *presentingVC = [self viewController];
    NSURL *popupURL = [NSURL URLWithString:urls[index]];
    PopupWebView *popupVC = [[PopupWebView alloc] initWithUrl:popupURL];
    popupVC.userCloseHandler = ^{
        if (newIndex >= urls.count) {
            return;
        }
        [self showNoticeWithUrls:urls index:index];
    };
    presentingVC.providesPresentationContextTransitionStyle = YES;
    presentingVC.definesPresentationContext = YES;
    presentingVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [presentingVC presentViewController:popupVC animated:NO completion:nil];
}

#pragma mark - Login or logout
- (void)showLoginViewController
{
    YYBBLoginViewController *loginVC = [YYBBLoginViewController new];
    [self.viewController addChildViewController:loginVC];
    [self.viewController.view addSubview:loginVC.view];
    [loginVC didMoveToParentViewController:self.viewController];
    self.loginVC = loginVC;
}

- (void)removeLoginViewController
{
    [self.loginVC willMoveToParentViewController:[UIViewController currentViewController]];
    [self.loginVC.view removeFromSuperview];
    [self.loginVC removeFromParentViewController];
    self.loginVC = nil;
}

- (void)showUpdateDialog:(NSDictionary *)extension
{
    NSString *title = [extension objectForKey:@"update_msg"];
    if (title.length == 0) {
        [self showFirstNotice];
        return;
    }
    
    UIAlertController *alertController;
    BOOL isForceUpdate = [extension[@"update_force"] boolValue];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:YYBBLocalizedString(@"AlertDialogButtonTitleCancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:YYBBLocalizedString(@"AlertDialogButtonTitleOkay") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *updateURL = [NSURL URLWithString:extension[@"update_link"]];
        [UIApplication.sharedApplication openURL:updateURL];
        if (isForceUpdate) {
            [self showUpdateDialog:extension];
        }
    }];
    
    alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    if (!isForceUpdate) {
        [alertController addAction:cancelAction];
    }
    [alertController addAction:okayAction];
    [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:^{
        [self showFirstNotice];
    }];
}

#pragma mark -

- (void)getSecondNotice {
    //Prepare to show second notice
    YYBBRoleExtraModel *roleExtraModel = self.roleExtraModel;
    YYBBUser *user = [YYBBUser currentUser];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"appID"]         = [YYBBSDK sharedInstance].appId;
    parameters[@"channelID"]     = [YYBBSDK sharedInstance].channelId;
    parameters[@"userID"]        = user.userID;
    parameters[@"roleID"]        = roleExtraModel.roleID;
    parameters[@"roleName"]      = roleExtraModel.roleName;
    parameters[@"roleLevel"]     = roleExtraModel.roleLevel;
    parameters[@"serverID"]      = roleExtraModel.serverID;
    parameters[@"serverName"]    = roleExtraModel.serverName;
    parameters[@"society"]       = roleExtraModel.society;
    parameters[@"vip"]           = roleExtraModel.vip;
    parameters[@"power"]         = roleExtraModel.power;
    parameters[@"cpChannelID"]   = roleExtraModel.cpChannelID;
    
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_Post:kYYBB_GetSecondNotice parameters:[parameters signParameters] serverSuccessBlcok:^(id  _Nonnull responseObj) {
        NSLog(@"Get 2nd notice successfully!!!");
        NSDictionary *extension = [responseObj objectForKey:@"extension"];
        if (extension) {
            NSInteger state = [extension[@"state"] integerValue];
            NSArray<NSString *> *popupURLStrings = extension[@"urls"];
            if (state == 1) {
                NSLog(@"start 2nd popup!!!");
                [self showNoticeWithUrls:popupURLStrings index:0];
            }
        }
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 方法抽取
- (void)loginWithExtensionParams:(NSDictionary *)extensionParams loginType:(YYBBLoginType)loginType success:(void (^)(void))success {
    NSData *extData = [NSJSONSerialization dataWithJSONObject:extensionParams options:kNilOptions error:nil];
    NSDictionary *parameters = @{ @"appID": [YYBBSDK sharedInstance].appId,
                                  @"channelID": [YYBBSDK sharedInstance].channelId,
                                  YYBBDeviceIDKey: [UIDevice yybb_deviceId],
                                  YYBBExtensionKey: [[NSString alloc] initWithData:extData encoding:NSUTF8StringEncoding] };
    
    @weakify(self)
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_Post:kYYBB_GetToken parameters:[parameters signParameters] serverSuccessBlcok:^(NSDictionary *_Nonnull responseObj) {
        @strongify(self)
        if (loginType == YYBBLoginTypeGuest) {
            [NSUserDefaults.standardUserDefaults setBool:YES forKey:YYBBIsGuestLoginedKey];
            // 一旦用户登录成功, 就无须重置deviceID, 这里无视用户是以何种方式登录成功,
            [NSUserDefaults.standardUserDefaults setBool:NO forKey:YYBBIsNeedResetDeviceIDKey];
        }
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        YYBBUser *user = [YYBBUser currentUser];
        if (user) {
            // 保留原有的数据
            NSDictionary *userDict = [user modelToJSONObject];
            [dictM addEntriesFromDictionary:userDict];
        }
        // 更新用户数据
        [dictM addEntriesFromDictionary:responseObj];
        
        YYBBUser *userNew = [YYBBUser modelWithJSON:dictM];
        userNew.loginType = loginType;
        self.user = userNew;
        // 在各登录插件中保存用户数据, 如openID, openName, token -->到内存中
        !success ?: success();
        // 持久化用户数据
        NSString *userStr = [userNew modelToJSONString];
        [[NSUserDefaults standardUserDefaults] setValue:userStr forKey:YYBBLoginedUserKey];
        
        [self postUserDidLoginNotification:responseObj];
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        @strongify(self)
        [self showLoginErrorDialog];
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)bindWithParams:(NSDictionary *)params loginType:(YYBBLoginType)loginType success:(void (^)(void))success {
    @weakify(self)
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_Post:kYYBB_BindAccount parameters:params serverSuccessBlcok:^(id  _Nonnull responseObj) {
        @strongify(self)
        [[YYBBSDK sharedInstance].analyticsDelegate completeRegistration];
#warning TODO
        !success ?: success();
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        @strongify(self)
        [self showBindingErrorDialog];
    } failureBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [self showBindingErrorDialog];
    }];
}


- (void)showBindingErrorDialog {
    YYBBAlertDialog *alertDialog = [YYBBAlertDialog new];
    //账号绑定失败!
    [alertDialog showOkayWithMessage:YYBBLocalizedString(@"YYBBBindFailTip") inView:self.view];
}

#pragma mark - getter && setter
- (NSInteger)localAgreementVersion {
    return [[NSUserDefaults standardUserDefaults] integerForKey:YYBBLocalAgreementVersionKey];
}

@end
