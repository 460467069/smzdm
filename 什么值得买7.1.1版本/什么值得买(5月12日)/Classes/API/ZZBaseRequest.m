//
//  ZZBaseRequest.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/2/24.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZBaseRequest.h"

@implementation ZZBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _f = kZDM_Platform;
        _v = kZDM_Vesion;
        _weixin = @"1";
    }
    return self;
}

@end

@implementation ZZBaseTableRequest

@end
