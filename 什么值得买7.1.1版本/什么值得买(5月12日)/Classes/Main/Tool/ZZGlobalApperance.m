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
+ (void)configureGlobalApperance{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    [navigationBar setTitleTextAttributes:attributes];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:ZZColor(234, 48, 57)];
    
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    [barButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    
//    [navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    //1  自定义后退按钮
//    UIImage *backButtonImage = [[[UIImage imageNamed:@"SM_Detail_BackSecond"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"SM_Detail_BackSecond"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"SM_Detail_BackSecond"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    
    UITableViewCell *cell = [UITableViewCell appearance];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView *scrollView = [UIScrollView appearance];
    scrollView.scrollsToTop = NO;
    
    //启用网络加载菊花, 网路差时能看到效果(可用networkLinkConditioner模拟)
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)setupNavigation{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SM_Detail_BackSecond"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(detailLeftBtnDidClick)];
    // 后退按钮距离图片距离左边边距
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = -20;
//    self.navigationItem.leftBarButtonItems = @[fixedItem,backItem];

}

@end
