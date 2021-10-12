//
//  ZZTabBarViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZTabBarViewController.h"
#import "ZZTabBarModel.h"
#import "YYBBBaseNavigationController.h"

@interface ZZTabBarViewController ()

@end

@implementation ZZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ZZTabBarModel tabBarModels] enumerateObjectsUsingBlock:^(ZZTabBarModel *  _Nonnull tabBarModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YYBBBaseNavigationController *vc = [[UIStoryboard storyboardWithName:tabBarModel.nibName bundle:nil] instantiateInitialViewController];
        vc.tabBarItem.title = tabBarModel.title;
        vc.tabBarItem.image = [[UIImage imageNamed:tabBarModel.normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarModel.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置选中状态下的图片
        NSDictionary *textSelectedAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#F04848"]};
        [vc.tabBarItem setTitleTextAttributes:textSelectedAttributes forState:UIControlStateSelected];
        NSDictionary *textNormalAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"]};
        [vc.tabBarItem setTitleTextAttributes:textNormalAttributes forState:UIControlStateNormal];
        [self addChildViewController:vc];

    }];
    
}


@end
