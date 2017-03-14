//
//  ZZProductModel.m
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZWorthyArticle.h"

@implementation ZZWorthyArticle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows" : [ZZLittleBanner class]};
}

@end



