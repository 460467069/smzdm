//
//  ZZNavigationController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZNavigationController.h"
#import "ZZBaseViewController.h"

@interface ZZNavigationController ()
@property (nonatomic, weak) ZZBaseViewController *markViewController;
@end

@implementation ZZNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger childVcCount = self.childViewControllers.count;
    if (childVcCount >= 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"SM_Detail_BackSecond"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    //不一定是基类控制器
    if ([self.markViewController isKindOfClass:[ZZBaseViewController class]]) {
        //子类可能需要返回到指定控制器
        if ([self.markViewController.delegate respondsToSelector:@selector(baseViewControllerBackBtnDidClick:)]) {
            [self.markViewController.delegate baseViewControllerBackBtnDidClick:self.markViewController];
            return;
        }
        [self popViewControllerAnimated:YES];
        return;
    }
    [self popViewControllerAnimated:YES];
}


@end
