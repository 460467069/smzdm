//
//  ZZHomeFirstModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeFirstModel.h"

@implementation ZZHomeFirstRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlStr = kZDM_Home_UtilFloor;
        self.channel_id = @"18";
    }
    return self;
}
@end

@implementation ZZHomeEditorRecommendRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        _limit = @"20";
        _device_id = kDeviceID;
        _smzdm_id = kSMZDMID;
        self.urlStr = kZDM_Home_EditorsRecommend;
    }
    return self;
}
@end

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


