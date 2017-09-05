//
//  ZZBaseViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZBaseViewController;
@protocol ZZBaseViewControllerDelegate <NSObject>
@optional
- (void)baseViewControllerBackBtnDidClick:(ZZBaseViewController *)vc;
@end

@interface ZZBaseViewController : UIViewController<ZZBaseViewControllerDelegate>

@property (nonatomic, weak) id<ZZBaseViewControllerDelegate> delegate;

- (void)initUI;
- (void)initNavBar;
- (void)setupDatasource;

@end
