//
//  YYBBRefreshHeader.m
//  YYBBSDKDemo
//
//  Created by Wang_Ruzhou on 2018/8/19.
//  Copyright © 2018年 Wang_Ruzhou. All rights reserved.
//

#import "YYBBRefreshHeader.h"

@implementation YYBBRefreshHeader
#pragma mark - 重写方法
#pragma mark 基本设置

- (void)prepare
{
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

@end
