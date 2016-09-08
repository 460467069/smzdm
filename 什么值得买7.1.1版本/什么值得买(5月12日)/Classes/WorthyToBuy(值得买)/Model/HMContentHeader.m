//
//  HMContentArticle.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMContentHeader.h"

@implementation HMContentHeader

+ (NSDictionary *)objectClassInArray{
    return @{@"rows" : [HMHeadLine class], @"little_banner" : [HMLittleBanner class]};
}

@end



