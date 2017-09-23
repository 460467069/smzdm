//
//  ZZBaseViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZBaseViewController.h"

@interface ZZBaseViewController ()

@end

@implementation ZZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    [self initUI];
    [self initNavBar];
    [self setupDatasource];
}

- (void)initUI {}
- (void)initNavBar {}
- (void)setupDatasource {}

@end
