//
//  ZZTableViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  一级主界面带tableView的控制器--->ZZFirstBaseViewController

#import <UIKit/UIKit.h>
#import "ZZFirstBaseViewController.h"

@interface ZZFirstTableViewController : ZZFirstBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;

/** 请求参数offset */
@property (nonatomic, assign) NSInteger offset;

@property (nonatomic, strong) UIColor *tableViewColor;
/** 下拉 */
- (void)loadData;
/** 上拉 */
- (void)loadMoreData;
@end
