//
//  ZZTableViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFirstBaseViewController.h"

@interface ZZFirstTableViewController : ZZFirstBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UIColor *tableViewColor;
/** 下拉 */
- (void)loadData;
/** 上拉 */
- (void)loadMoreData;
@end
