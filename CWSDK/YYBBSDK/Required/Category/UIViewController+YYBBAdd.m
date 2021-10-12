//
//  UIViewController+YYBBAdd.m
//  
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "UIViewController+YYBBAdd.h"
#import "../Macro/YYBBUtilsMacro.h"
#import "../Macro/LxDBAnything.h"

@implementation UIViewController (YYBBAdd)


//获取当前控制器
+ (UIViewController*)yybb_currentViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController yybb_findBestViewController:viewController];
}

+ (UIViewController*)yybb_findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController yybb_findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController yybb_findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController yybb_findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController yybb_findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
}

+ (instancetype)instantiateViewControllerFromSB {
    UIStoryboard *sb = nil;
    @try {
        sb = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
    } @catch (NSException *exception) {
        sb = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:YYBBSDKBundle()];
    } @finally{
        return sb.instantiateInitialViewController;
    }
}

@end
