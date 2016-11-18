//
//  ZZContentArticle.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZContentHeader.h"

@implementation ZZContentHeader

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows" : [ZZHeadLine class],
             @"little_banner" : ZZLittleBanner.class};
}

@end



