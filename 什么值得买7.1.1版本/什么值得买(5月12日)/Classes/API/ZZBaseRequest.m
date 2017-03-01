//
//  ZZBaseRequest.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/2/24.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZBaseRequest.h"

//[parameters setValue:@"iphone" forKey:@"f"];
//[parameters setValue:@"7.1.1" forKey:@"v"];
//[parameters setValue:@"1" forKey:@"weixin"];
@implementation ZZBaseRequest

- (instancetype)init
{
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
