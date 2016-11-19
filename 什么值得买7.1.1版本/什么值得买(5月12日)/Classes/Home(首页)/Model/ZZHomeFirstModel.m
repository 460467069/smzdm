//
//  ZZHomeFirstModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeFirstModel.h"

@implementation ZZHomeFirstModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"floor_multi" : [ZZFloorMulti class],
             @"floor_yuanchuang_master" : [ZZFloorYuanchuangMaster class],
             @"floor_single" : [ZZFloorSingle class]
             };
}

@end
@implementation ZZFloorMulti

@end


@implementation ZZFloorYuanchuangMaster

@end


@implementation ZZFloorSingle

@end


