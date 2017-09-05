//
//  ZZHomeHeadModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeHeadModel.h"
#import "ZZTitleBannelOption.h"
#import "ZZHeadLine.h"
#import "ZZLittleBanner.h"

@implementation ZZHomeBannerRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = @"menhu";
        self.urlStr = kZDM_UtilBanner;
    }
    return self;
}
@end

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
