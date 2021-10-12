//
//  YYBBTabBarViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBTabBarViewController.h"
#import "YYBBTabBarModel.h"
#import "YYBBBaseNavigationController.h"
#import <YYCategories/UIColor+YYAdd.h>

@interface YYBBTabBarViewController ()

@end

@implementation YYBBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray<YYBBTabBarModel *> *models = [NSMutableArray arrayWithArray:[YYBBTabBarModel tabBarModels]];
    [models enumerateObjectsUsingBlock:^(YYBBTabBarModel *  _Nonnull tabBarModel, NSUInteger idx, BOOL * _Nonnull stop) {

        UIViewController *vc = [[NSClassFromString(tabBarModel.nibName) alloc] init];
        YYBBBaseNavigationController *nav = [[YYBBBaseNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = tabBarModel.title;
        nav.tabBarItem.image = [[UIImage imageNamed:tabBarModel.normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarModel.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置选中状态下的图片
        UIColor *normalColor = [UIColor colorWithHexString:@"C1C1C1"];
        UIColor *selectedColor = [UIColor colorWithHexString:@"333333"];

        if (@available(iOS 13.0, *)) {
            UITabBar *tabBar = [UITabBar appearance];
            [tabBar setTintColor:selectedColor];
            [tabBar setUnselectedItemTintColor:normalColor];
        } else {
            NSDictionary *textSelectedAttributes = @{NSForegroundColorAttributeName : selectedColor};
            [nav.tabBarItem setTitleTextAttributes:textSelectedAttributes forState:UIControlStateSelected];
            NSDictionary *textNormalAttributes = @{NSForegroundColorAttributeName : normalColor};
            [nav.tabBarItem setTitleTextAttributes:textNormalAttributes forState:UIControlStateNormal];
        }
        [self addChildViewController:nav];
    }];
}


@end
