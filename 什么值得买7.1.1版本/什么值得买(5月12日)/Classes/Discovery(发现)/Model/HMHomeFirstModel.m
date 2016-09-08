//
//  HMHomeFirstModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMHomeFirstModel.h"

@implementation HMHomeFirstModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"floor_multi" : [HMFloorMulti class],
             @"floor_yuanchuang_master" : [HMFloorYuanchuangMaster class],
             @"floor_single" : [HMFloorSingle class]
             };
}

@end
@implementation HMFloorMulti

@end


@implementation HMFloorYuanchuangMaster

@end


@implementation HMFloorSingle

@end


