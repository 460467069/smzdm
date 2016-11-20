//
//  ZZBaseViewController.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  (一级界面) 几个主界面的父控制器

#import <UIKit/UIKit.h>
#import "ZZRedirectData.h"

@interface ZZFirstBaseViewController : UIViewController

@property (nonatomic, strong) UILabel *placeHolderLabel;

#pragma mark - 控制器跳转逻辑
- (void)jumpToDetailArticleViewControllerWithRedirectdata:(ZZRedirectData *)redirectdata;

@end
