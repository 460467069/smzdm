//
//  YYBBSDK_Phone.m
//  YYBBSDK_Phone
//
//  Created by Kris Liu on 8/13/17.
//  Copyright © 2017 yybbsdk. All rights reserved.
//

#import "YYBBSDK_Phone.h"
#import "YYBBKit.h"

static NSString *const YYBBCodeUserKey = @"YYBBCodeUserKey";              // 记录Code用户数据
static NSInteger const YYBBCodeLength  = 4;

@interface YYBBSDK_Phone ()<UITextFieldDelegate>

@property (nonatomic, strong) UIAlertAction *confirmAction;

@end

@implementation YYBBSDK_Phone

- (void)login
{
    [self preLogin];
}

- (void)preLogin {
    YYBBLanguage *language = [YYBBLanguage currentLanguage];
    
    NSString *message = @"\
    Thank you for choosing Link Account login.\n\
    1. Please enter Link Code in the box for the first time login(open AOS or DB to get the code);\n\
    2. Non-first-time login, please directly tap \"Confirm\" to get in;\n\
    3. After accessing the game, you can:\n\
    a. Bind account to FB(for changing devices). You can login with both Link Account and FB in the future;\n\
    b. Still use Link Account login(don't need Code anymore);\n\
    4. Please keep code safe and private to prevent unauthorized access;\n\
    5. Any questions, please feel free to contact CS.";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Instructions"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *contactAction = [UIAlertAction actionWithTitle:language.contact_service style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self eventUserLoginResult:nil];
        [[YYBBSDK sharedInstance] showCustomerSupport];
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:language.dialog_confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self eventUserLoginResult:nil];
        [self actuallyLogin];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:language.dialog_cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self eventUserLoginResult:nil];
    }];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:message attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:12.0]}];
    [alertController setValue:atrStr forKey:@"attributedMessage"];
    
    [alertController addAction:contactAction];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    UIViewController *viewController = [UIViewController currentViewController];
    UIView *codeLoginView = [viewController.view viewWithTag:YYBBLoginTypeCode];
    
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        popoverPresentationController.sourceRect = codeLoginView.frame;
        popoverPresentationController.sourceView = codeLoginView;
        alertController.modalPresentationStyle   = UIModalPresentationPopover;
    }
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)actuallyLogin {
    // 通过玩家缓存登录游戏
    NSString *userStr = [[NSUserDefaults standardUserDefaults] valueForKey:YYBBCodeUserKey];
    if (userStr) {
        YYBBUser *user = [YYBBUser modelWithJSON:userStr];
        self.loginType   = user.loginType;
        self.openID      = user.openID;
        self.openName    = user.openName;
        self.accessToken = user.accessToken;
        
        [self loginWithSocialAccount];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Link Account Login"
                                                                             message:@"Please enter Link Code below."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate = self;
        textField.placeholder = @"Link Code";
        textField.textAlignment = NSTextAlignmentCenter;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self eventUserLoginResult:nil];
        [self loginWithCode:alertController.textFields.firstObject.text];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self eventUserLoginResult:nil];
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    confirmAction.enabled = NO;
    self.confirmAction = confirmAction;
    [self.viewController presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)loginWithCode:(NSString *)code {
    @weakify(self)
    NSDictionary *parameters = @{ @"code": code};
    
    [SVProgressHUD show];
    [[YYBBAPPDotNetAPIClient sharedClient] YYBB_POST:@"user/verifyCode" parameters:parameters serverSuccessBlcok:^(id  _Nonnull responseData) {
        @strongify(self)
        [SVProgressHUD dismiss];
        self.loginType   = [responseData[@"userType"] integerValue];
        self.openID      = responseData[@"openID"];
        self.openName    = responseData[@"openName"] ?: @"";
        self.accessToken = responseData[@"token"];
        
        [self loginWithSocialAccount];
    } serverErrorMsgBlcok:^(NSString * _Nonnull errorMsg) {
        // 登录错误提示
        [SVProgressHUD showInfoWithStatus:errorMsg];
    } failureBlock:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loginOrBindAccountToOwnServerSuccessHandler {
    [super loginOrBindAccountToOwnServerSuccessHandler];
    
    // 持久化用户数据
    YYBBUser *user = [YYBBUser currentUser];
    NSString *userStr = [user modelToJSONString];
    [[NSUserDefaults standardUserDefaults] setValue:userStr forKey:YYBBCodeUserKey];
}



@end
