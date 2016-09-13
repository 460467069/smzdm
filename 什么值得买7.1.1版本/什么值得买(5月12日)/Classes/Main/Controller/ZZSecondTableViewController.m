//
//  ZZSecondTableViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZSecondTableViewController.h"
#import "ZZDIYHeader.h"
#import "ZZDIYBackFooter.h"

@interface ZZSecondTableViewController ()

@end

@implementation ZZSecondTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self tableViewInitial];
    
    [self refreshHeaderAndFooterInitial];
}

/** 初始化tableView */
- (void)tableViewInitial {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollsToTop = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}



/**
 *  上下拉刷新初始化
 */
- (void)refreshHeaderAndFooterInitial {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [ZZDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    
    self.tableView.mj_footer = [ZZDIYBackFooter footerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)loadData {}

- (void)loadMoreData {}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
