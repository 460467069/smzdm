//
//  YYBBProtocol.h
//  CoCoaPods
//
//  Created by Wang_Ruzhou on 11/5/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#ifndef YYBBProtocol_h
#define YYBBProtocol_h

@protocol YYBBLayoutDelegate <NSObject>

@optional

- (void)initUI;
- (void)updateUI;

@end

@class YYBBBaseViewController;
@protocol YYBBViewControllerDelegate <YYBBLayoutDelegate>

@optional

- (void)initNavBar;
- (void)setupDataSource;
- (void)updateDataSource;
- (void)baseViewControllerBackBtnDidClick:(YYBBBaseViewController *)vc;
- (BOOL)shouldHideNavigationBarLine;
- (UIColor *)navigationBarColor;

@end


@protocol YYBBViewEventDelegate <YYBBLayoutDelegate>

@optional

// 使用以下协议的时候要写注释, 否则就难以阅读了
- (void)didClickSomeBtn1:(id)originalView;
- (void)didClickSomeBtn2:(id)originalView;
- (void)didClickSomeBtn3:(id)originalView;
- (void)didClickSomeBtn4:(id)originalView;
- (void)didClickSomeBtn5:(id)originalView;
- (void)didClickSomeBtn6:(id)originalView;
- (void)didClickSomeBtn7:(id)originalView;
- (void)didClickSomeBtn8:(id)originalView;
- (void)didClickSomeBtn9:(id)originalView;

@end


#endif /* YYBBProtocol_h */
