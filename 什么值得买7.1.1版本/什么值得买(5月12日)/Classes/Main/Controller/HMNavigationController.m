//
//  HMNavigationController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMNavigationController.h"



@interface HMNavigationController ()

@end

@implementation HMNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}




- (UIStatusBarStyle)preferredStatusBarStyle{
    
    
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSInteger childVcCount = self.childViewControllers.count;

    if (childVcCount >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
