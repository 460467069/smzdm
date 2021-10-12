//
//  YYBBBaseNavigationController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseNavigationController.h"
#import "YYBBBaseViewController.h"
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIImage+YYAdd.h>

@interface YYBBBaseNavigationController ()

@end

@implementation YYBBBaseNavigationController

+ (void)setNavigationBar {
    
}

#if 0
+ (void)initialize {
    NSMutableDictionary *titleTextnormalAttributes            = [NSMutableDictionary dictionary];
    titleTextnormalAttributes[NSFontAttributeName]            = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    titleTextnormalAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    UINavigationBar *navigationBar                            = [UINavigationBar appearance];
    navigationBar.translucent                                 = NO;

    NSMutableDictionary *normalAttributes                     = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName]                     = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    normalAttributes[NSForegroundColorAttributeName]          = [UIColor colorWithHexString:@"333333"];
    if (@available(iOS 13.0, *)) {
        // 导航栏
        UINavigationBarAppearance *navigationBarAppearance = UINavigationBarAppearance.new;
        navigationBarAppearance.backgroundColor = [UIColor whiteColor];
        navigationBarAppearance.shadowColor = [UIColor clearColor];
        navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = normalAttributes;
        navigationBarAppearance.buttonAppearance.focused.titleTextAttributes = normalAttributes;
        navigationBarAppearance.buttonAppearance.highlighted.titleTextAttributes = normalAttributes;

        navigationBar.standardAppearance = navigationBarAppearance;
    } else {
        UIBarButtonItem *barButtonItemItem                        = [UIBarButtonItem appearance];
        [barButtonItemItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
        [barButtonItemItem setTitleTextAttributes:normalAttributes forState:UIControlStateSelected];
        [barButtonItemItem setTitleTextAttributes:normalAttributes forState:UIControlStateHighlighted];

        // 导航栏按钮、文字颜色
        navigationBar.tintColor           = [UIColor colorWithHexString:@"333333"];
        // 导航栏
        navigationBar.titleTextAttributes = titleTextnormalAttributes;
        [navigationBar setBackgroundImage: [UIImage imageWithColor:[UIColor whiteColor]]
                                           forBarMetrics: UIBarMetricsDefault];
        navigationBar.shadowImage = [UIImage new];
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.topViewController;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger childVcCount = self.childViewControllers.count;
    if (childVcCount >= 1) {
        [self configureCustomNavButton:viewController];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)configureCustomNavButton:(UIViewController *)viewController {
    YYBBNavBackButtton *btn = [YYBBNavBackButtton new];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    viewController.hidesBottomBarWhenPushed = YES;
}

- (void)back {
    UIViewController *topVc = [self topViewController];
    if ([topVc isKindOfClass:[YYBBBaseViewController class]]) {
        YYBBBaseViewController *baseViewController = (YYBBBaseViewController *)topVc;
        //子类可能需要返回到指定控制器
        if (baseViewController.yybb_delegate &&  [baseViewController.yybb_delegate respondsToSelector:@selector(baseViewControllerBackBtnDidClick:)]) {
            [baseViewController.yybb_delegate baseViewControllerBackBtnDidClick:baseViewController];
            return;
        }
        [self popViewControllerAnimated:YES];
        return;
    }
    [self popViewControllerAnimated:YES];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    for (NSInteger i = 0; i < viewControllers.count; i++) {
        if (i > 0) {
            [self configureCustomNavButton:viewControllers[i]];
        }
    }
}

@end


@implementation YYBBNavBackButtton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    [self setImage:[UIImage imageNamed:@"SM_Detail_BackSecond"] forState:UIControlStateNormal];
    self.frame = CGRectMake(0, 0, 40, 40);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
}


@end
