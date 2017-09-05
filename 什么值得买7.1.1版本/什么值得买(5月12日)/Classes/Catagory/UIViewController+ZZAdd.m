//
//  UIViewController+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/13.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UIViewController+ZZAdd.h"

@implementation UIViewController (ZZAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(viewWillAppear:), @selector(zz_swizzled_viewWillAppear:));
        swizzleMethod([self class], @selector(viewWillDisappear:), @selector(zz_swizzled_viewWillDisappear:));
    });
}

- (void)zz_swizzled_viewWillAppear:(BOOL)animated {
    [self zz_swizzled_viewWillAppear:animated];
    NSString *className = NSStringFromClass([self class]);
    LxPrintf(@"----Enter: %@", className);
}

- (void)zz_swizzled_viewWillDisappear:(BOOL)animated {
    [self zz_swizzled_viewWillDisappear:animated];
    NSString *className = NSStringFromClass([self class]);
    LxPrintf(@"----Leave: %@", className);
}


@end
