//
//  ZZGlobalApperance.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/24.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZGlobalApperance.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation ZZGlobalApperance

/** 全局定制 */
+ (void)configureGlobalApperance {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    [navigationBar setTitleTextAttributes:attributes];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:ZZColor(234, 48, 57)];
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    
    UITableViewCell *cell = [UITableViewCell appearance];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView *scrollView = [UIScrollView appearance];
    scrollView.scrollsToTop = NO;
    BOOL isIphoneX = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
    kZZStatusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (isIphoneX) {
        kZZTabBarH = 83;
    }
    //启用网络加载菊花, 网路差时能看到效果(可用networkLinkConditioner模拟)
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
