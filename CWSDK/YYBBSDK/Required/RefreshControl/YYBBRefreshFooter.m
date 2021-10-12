//
//  YYBBRefreshFooter.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/19.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBRefreshFooter.h"
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/UIColor+YYAdd.h>

@interface YYBBRefreshFooter()

@property (weak, nonatomic) UILabel *label;

@end

@implementation YYBBRefreshFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];

    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.width = kScreenWidth;
    label.height = 20;
    label.centerY = self.height * 0.5;
    label.textColor = [UIColor colorWithHexString:@"999999"];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = YES;
    [self addSubview:label];
    self.label = label;
    self.label.text = @"All loaded";  //初始值
    
    self.stateLabel.hidden = YES;
    self.refreshingTitleHidden = YES;
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    self.label.hidden = YES;
    switch (state) {
            
        case MJRefreshStateIdle: { //普通闲置状态
            break;
        }
        case MJRefreshStatePulling: { //松开就可以进行刷新的状态
            break;
        }
        case MJRefreshStateRefreshing: { //正在刷新中的状态
            
            break;
        }
        case MJRefreshStateWillRefresh:{ //即将刷新的状态
            
            break;
        }
        case MJRefreshStateNoMoreData:{ //所有数据加载完毕，没有更多的数据了
            self.label.hidden = NO;
            break;
        }
            
        default: {
            
            break;
        }
    }
}

@end
