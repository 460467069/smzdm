//
//  ZZTableViewRowOption.m
//
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZTableViewRowOption.h"

@implementation ZZTableViewRowOption


- (instancetype)init {
    self = [super init];
    if (self) {
        _rowHeight = 50;
        _userInteractionEnabled = YES;
    }
    return self;
}

+ (_Nonnull instancetype)optionWithImage:(id _Nullable)image title:(NSString *_Nullable)title {
    ZZTableViewRowOption *option = [[self alloc] init];
    option.image = image;
    option.title = title;
    return option;
}

+ (_Nonnull instancetype)optionWithImage:(id _Nullable)image title:(NSString *_Nullable)title subTitle:(NSString *_Nullable)subTitle {
    ZZTableViewRowOption *option = [self optionWithImage:image title:title];
    option.subTitle = subTitle;
    return option;
}


+ (NSArray<NSString *> *)modelPropertyBlacklist {
    return @[
        @"placeHolderImage",
        @"image",
        @"accessoryView"
    ];
}


@end
