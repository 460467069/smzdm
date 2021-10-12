//
//  UINavigationController+YYBBAdd.h
//
//
//  Created by Wang_ruzhou on 2018/4/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (YYBBAdd)

// pop到指定控制器
- (void)popToViewController:(Class)viewControllerClass;
// 是否包含某控制器
- (BOOL)isContainViewController:(Class)viewControllerClass;
// 移除指定的控制器
- (void)removeViewController:(Class)viewControllerClass;
// 返回到指定控制器的前一个控制器
- (void)popToPreviousViewController:(Class)viewControllerClass;
// 移除指定控制器栈以上(不包含)的控制器
- (void)removeViewControllers:(Class)viewControllerClass;

@end
