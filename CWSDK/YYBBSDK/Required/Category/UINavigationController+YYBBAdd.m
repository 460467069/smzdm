//
//  UINavigationController+YYBBAdd.m
//  
//
//  Created by Wang_ruzhou on 2018/4/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "UINavigationController+YYBBAdd.h"
#import "NSArray+YYBBAdd.h"

@implementation UINavigationController (YYBBAdd)

- (void)popToViewController:(Class)viewControllerClass {
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:viewControllerClass]) {
            [self popToViewController:vc animated:YES];
            return;
        }
    }
}

// 返回到指定控制器的前一个控制器
- (void)popToPreviousViewController:(Class)viewControllerClass {
    if (![self isContainViewController:viewControllerClass]) {
        return;
    }
    __block NSInteger index = 0;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:viewControllerClass]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    UIViewController *previousVc = [self.viewControllers objectAtIndexSafe:index - 1];
    if (previousVc) {
        [self popToViewController:previousVc animated:YES];
    }
}

- (BOOL)isContainViewController:(Class)viewControllerClass {
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:viewControllerClass]) {
            return YES;
        }
    }
    return NO;
}

- (void)removeViewController:(Class)viewControllerClass {
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:self.viewControllers];
    BOOL isContain = NO;
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:viewControllerClass]) {
            [tempArrayM removeObject:vc];
            isContain = YES;
        }
    }
    if (isContain) {
        self.viewControllers = [tempArrayM copy];
    }
}

// 移除指定控制器栈以上的控制器
- (void)removeViewControllers:(Class)viewControllerClass {
    BOOL isContains = [self isContainViewController:viewControllerClass];
    if (!isContains) {
        return;
    }
    
    NSMutableArray *tempArrayM = [NSMutableArray array];
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isMemberOfClass:viewControllerClass]) {
            [tempArrayM addObject:vc];
            break;
        } else {
            [tempArrayM addObject:vc];
        }
    }
    self.viewControllers = [tempArrayM copy];
}


@end
