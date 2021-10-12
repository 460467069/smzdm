//
//  UIViewController+YYBBAdd.h
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YYBBAdd)

//  获取当前显示的控制器(做个项目不要使用)
+ (UIViewController*)yybb_currentViewController;
// 根据rootViewController 获取当前显示的控制器
+ (UIViewController*)yybb_findBestViewController:(UIViewController*)vc;
// 从sb中加载控制器
+ (instancetype)instantiateViewControllerFromSB;


@end
