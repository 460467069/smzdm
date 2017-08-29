//
//  ZZBaseViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  (二级界面) 几个主界面的父控制器--->UIViewController

#import <UIKit/UIKit.h>

@class ZZSecondBaseViewController;
@protocol ZDBaseViewControllerDelegate <NSObject>
@optional
- (void)baseViewControllerBackBtnDidClick:(ZZSecondBaseViewController *)vc;
@end

@interface ZZSecondBaseViewController : UIViewController<ZDBaseViewControllerDelegate>

@property (nonatomic, weak) id<ZDBaseViewControllerDelegate> delegate;

- (void)initUI;
- (void)initNavBar;
- (void)setupDatasource;

@end
