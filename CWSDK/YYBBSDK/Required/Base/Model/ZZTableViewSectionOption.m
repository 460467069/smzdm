//
//  ZZTableViewSectionOption.m
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 11/1/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "ZZTableViewSectionOption.h"

@implementation ZZTableViewSectionOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rowOptions = [NSMutableArray array];
        _sectionHeaderHeight = CGFLOAT_MIN;
        _sectionFooterHeight = CGFLOAT_MIN;
    }
    return self;
}

+ (NSArray<NSString *> *)modelPropertyBlacklist {
    return @[
        @"titleColor",
        @"subTitleColor"
    ];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rowOptions" : @"YYBBQuotationPurchaseRowModel",
    };
}

@end
