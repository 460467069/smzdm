//
//  ZZHomeHeadModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeHeadModel.h"


@implementation ZZHomeHeadModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows" : [ZZHeadLine class],
             @"headlines" : ZZHeadLine.class,
             @"littleBanner" : [ZZLittleBanner class] };
}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"littleBanner"  : @"little_banner",
             @"littleBannerOptions"  : @"little_banner_options" };
}


@end
