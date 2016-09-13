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
    
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [navigationBar setTitleTextAttributes:attributes];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:kGlobalRedColor];
    //1  自定义后退按钮
//    UIImage *backButtonImage = [[[UIImage imageNamed:@"SM_Detail_BackSecond"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];


    
    UITableViewCell *cell = [UITableViewCell appearance];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView *scrollView = [UIScrollView appearance];
    scrollView.scrollsToTop = NO;
    
    //启用网络加载菊花, 网路差时能看到效果(可用networkLinkConditioner模拟)
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
