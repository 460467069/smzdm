//
//  YYBBBaseViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseViewController.h"
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYBBSDK/YYBBReachability.h>
#import <HBDNavigationBar/UIViewController+HBD.h>
#import "YYBBSDK.h"
#import <Masonry/Masonry.h>
#import "UIColor+YYBBAdd.h"
#import "LxDBAnything.h"
#import "NSObject+YYBBAdd.h"
#import "UIImage+YYBBAdd.h"
#import "YYBBUtilities.h"

@interface YYBBBaseViewController ()

@end

@implementation YYBBBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yybb_delegate = self;
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    [self configureCommonUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LxPrintf(@"----Enter: %@", NSStringFromClass([self class]));
    if ([self isKindOfClass:[YYBBBaseViewController class]]) {
        if ([self.navigationItem.title yybb_isNotEmpty]) {
            [[YYBBSDK sharedInstance].delegate yybb_um_beginLogPageView:self.navigationItem.title];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isKindOfClass:[YYBBBaseViewController class]]) {
        if ([self.navigationItem.title yybb_isNotEmpty]) {
            [[YYBBSDK sharedInstance].delegate yybb_um_endLogPageView:self.navigationItem.title];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)configureCommonUI {
    self.view.backgroundColor =[UIColor yybb_grayScaleBgColor];
    
    // 导航栏
    UIColor *barColor = [self navigationBarColor];
    UIImage *navBgImage = nil;
    if (barColor == nil) {
        // 导航栏
        navBgImage = YYBBNavigationBgImage();
    } else {
        navBgImage = [UIImage imageWithColor:barColor];
    }
    
    NSMutableDictionary *titleTextnormalAttributes            = [NSMutableDictionary dictionary];
    titleTextnormalAttributes[NSFontAttributeName]            = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
    titleTextnormalAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    self.hbd_barImage = navBgImage;
    self.hbd_barAlpha = 1.0;
    self.hbd_barStyle = UIBarStyleDefault;
    self.hbd_tintColor = UIColor.whiteColor;
    self.hbd_titleTextAttributes = titleTextnormalAttributes;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navigationBar.tintColor = [UIColor whiteColor];
}

// 依赖KMNavigationBarTransition解决导航条颜色背景问题
- (void)configureNavigationBarWithBarColr:(UIColor *)barColor {
    NSMutableDictionary *titleTextnormalAttributes            = [NSMutableDictionary dictionary];
    titleTextnormalAttributes[NSFontAttributeName]            = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
    titleTextnormalAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    UINavigationBar *navigationBar                           = self.navigationController.navigationBar;
    navigationBar.translucent                                = YES;
    NSMutableDictionary *normalAttributes                     = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName]                     = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    normalAttributes[NSForegroundColorAttributeName]          = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    [leftBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [leftBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateSelected];
    [leftBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateHighlighted];
    
    UIBarButtonItem *rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    [rightBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [rightBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateSelected];
    [rightBarButtonItem setTitleTextAttributes:normalAttributes forState:UIControlStateHighlighted];
    
    // 导航栏按钮、文字颜色a
    navigationBar.tintColor = [UIColor colorWithHexString:@"2F87FA"];
    // 导航栏
    UIImage *navBgImage = nil;
    if (barColor == nil) {
        // 导航栏
        navBgImage = YYBBNavigationBgImage();
    } else {
        navBgImage = [UIImage imageWithColor:barColor];
    }
    
    navigationBar.titleTextAttributes = titleTextnormalAttributes;
    [navigationBar setBackgroundImage: navBgImage
                        forBarMetrics: UIBarMetricsDefault];
    BOOL shouldHide = NO;
    if ([self respondsToSelector:@selector(shouldHideNavigationBarLine)]) {
        shouldHide = [self shouldHideNavigationBarLine];
    }
    //    navigationBar.shadowImage = shouldHide ? [UIImage new] : [UIImage imageWithColor:[UIColor yybb_lineColor]];
    navigationBar.shadowImage = [UIImage new];
}

- (void)setNavLeftImage:(NSString *)imageName
{
    UIImage *backImage = [UIImage imageNamed:imageName];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backAction:)];
}

- (void)setNavRightImage:(NSString *)imageName
{
    UIImage *rightImage = [UIImage imageNamed:imageName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightAction:)];
}

- (void)setNavLeftTitle:(NSString *)leftTitle
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backAction:)];
}

- (void)setNavRightTitle:(NSString *)rightTitle
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightAction:)];
}


- (void)rightAction:(id)sender
{
    
}

-(void)backAction:(id)sender
{
    
}

- (UIColor *)navigationBarColor {
    return nil;
}

#pragma mark - YYBBViewControllerDelegate

- (void)initNavBar {}
- (void)setupDataSource {}
- (void)updateDataSource {}

#pragma mark - Getter && Setter

- (UIActivityIndicatorView *)yybb_activityIndicatorView {
    if (!_yybb_activityIndicatorView) {
        _yybb_activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        [self.view addSubview:_yybb_activityIndicatorView];
        [_yybb_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    [self.view bringSubviewToFront:_yybb_activityIndicatorView];
    return _yybb_activityIndicatorView;
}

#if 0
- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
        // 设置自定义导航栏背景图片
        UIColor *barColor = [self navigationBarColor];
        UIImage *navBgImage = nil;
        if (barColor == nil) {
            // 导航栏
            navBgImage = YYBBNavigationBgImage();
        } else {
            navBgImage = [UIImage imageWithColor:barColor];
        }
        
        _customNavBar.barBackgroundImage = navBgImage;
        [_customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_back"]];
        // 设置自定义导航栏标题颜色
        _customNavBar.titleLabelColor = [UIColor whiteColor];
        [_customNavBar wr_setBottomLineHidden:YES];
    }
    return _customNavBar;
}
#endif


@end
