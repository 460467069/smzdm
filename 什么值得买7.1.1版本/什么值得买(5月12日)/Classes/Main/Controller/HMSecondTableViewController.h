//
//  HMSecondTableViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMSecondBaseViewController.h"

@interface HMSecondTableViewController : HMSecondBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;
/** 下拉 */
- (void)loadData;
/** 上拉 */
- (void)loadMoreData;
@end
