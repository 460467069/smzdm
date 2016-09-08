//
//  HMGlobalApperance.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/24.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMGlobalApperance.h"

@implementation HMGlobalApperance
/** 全局定制 */
+ (void)configureGlobalApperance{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [navigationBar setTitleTextAttributes:attributes];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:kGlobalRedColor];
    
    UITableViewCell *cell = [UITableViewCell appearance];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView *scrollView = [UIScrollView appearance];
    scrollView.scrollsToTop = NO;
    
}

@end
