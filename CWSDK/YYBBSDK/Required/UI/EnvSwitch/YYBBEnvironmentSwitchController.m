//
//  YYBBEnvironmentSwitchController.m
//  YYCardBoard
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBEnvironmentSwitchController.h"
#import "YYBBRuntimeManager.h"
#import "UIColor+YYBBAdd.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation YYBBEnvironmentModel

@end

@implementation YYBBDomainModel : NSObject

@end

static NSString *const kReleaseFactoryDomainsKey     = @"kReleaseFactoryDomainsKey";  // Release二级厂切换
static NSString *const kDebugFactoryDomainsKey       = @"kDebugFactoryDomainsKey";    // Debug二级厂切换
static NSString *const kEnvironmentKey              = @"kEnvironmentNewKey";           // 环境切换

@interface YYBBDomainSwitchManager ()

@end

@implementation YYBBDomainSwitchManager


+ (instancetype)sharedInstance {
    static YYBBDomainSwitchManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)yybb_initialization {
    NSString *jsonStr = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvironmentKey];
    if (jsonStr && [YYBBRuntimeManager sharedInstance].isLatestVersion) {
        self.envModels = [NSArray yy_modelArrayWithClass:[YYBBEnvironmentModel class] json:jsonStr];
    } else {
        self.envModels = [NSArray yy_modelArrayWithClass:[YYBBEnvironmentModel class] json:[YYBBSDK sharedInstance].config.envs];
    }
    for (YYBBEnvironmentModel *model in self.envModels) {
        if (model.isSelected) {
            self.currentEnvironmentModel = model;
            break;
        }
    }
}

- (void)setAllToNotSelected {
    for (YYBBEnvironmentModel *model in self.envModels) {
        model.isSelected = NO;
    }
}

- (void)setCurrentEnvironmentModel:(YYBBEnvironmentModel *)currentEnvironmentModel {
    _currentEnvironmentModel = currentEnvironmentModel;
    [self saveEnvironment];
}

- (void)saveEnvironment {
    NSString *jsonStr = [self.envModels yy_modelToJSONString];
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:kEnvironmentKey];
}

@end

@interface YYBBEnvironmentSwitchController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIAlertAction *confirmAction;

@end

@implementation YYBBEnvironmentSwitchController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initNavBar];
    [self setupDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    
}

#pragma mark - BaseViewControllerDelegate

- (void)initUI {
    self.view.backgroundColor = [UIColor yybb_grayScaleBgColor];
}

- (void)initNavBar {
    self.title = @"环境切换";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(navBarRightButtonAction:)];
    

}

- (void)setupDataSource {
    
}

#pragma mark - View Event

- (void)navBarRightButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 域名切换
- (IBAction)baseUrlBtnDidClick:(UIButton *)sender {
    YYBBDomainSwitchManager *manager = [YYBBDomainSwitchManager sharedInstance];
    NSString *environment = manager.currentEnvironmentModel.title;
    NSString *baseUrlStr = [NSString stringWithFormat:@"当前为:%@环境", environment];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"环境切换"
                                                                             message:baseUrlStr
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (YYBBEnvironmentModel *model in manager.envModels) {
        [alertController addAction:[UIAlertAction actionWithTitle:model.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (model.isSelected) {
                return;
            }
            [manager setAllToNotSelected];
            model.isSelected = YES;
            manager.currentEnvironmentModel = model;
        }]];
    }

    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 检查更新
- (IBAction)checkUpdateBtnDidClick:(UIButton *)sender {
    [SVProgressHUD show];
    [[YYBBSDK sharedInstance] checkUpdateByPGY];
}

#pragma mark - Model Event


#pragma mark- UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.confirmAction.enabled = textField.text.length > 0;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *) textField {
    NSInteger length = textField.text.length;
    self.confirmAction.enabled = length > 0;
}

#pragma mark - Private


#pragma mark - Getter && Setter

@end
