//
//  YYBBRefreshFooter2.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/19.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBNewsRefreshFooter.h"
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface YYBBNewsRefreshFooter()

@end

@implementation YYBBNewsRefreshFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    [self setTitle:@"上拉加载最新消息" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载最新消息" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载最新消息" forState:MJRefreshStateRefreshing];
    [self setTitle:@"已经加载全部消息" forState:MJRefreshStateNoMoreData];
    self.arrowView.alpha = 0;
}

@end
