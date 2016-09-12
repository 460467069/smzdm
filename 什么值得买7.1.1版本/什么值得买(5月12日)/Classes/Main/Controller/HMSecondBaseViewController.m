//
//  HMBaseViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMSecondBaseViewController.h"

@interface HMSecondBaseViewController ()

@end

@implementation HMSecondBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kGlobalRedColor];
}

@end
