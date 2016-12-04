//
//  ZZSecondTableViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  二级主界面带tableView的控制器--->ZZSecondBaseViewController

#import "ZZSecondBaseViewController.h"

@interface ZZSecondTableViewController : ZZSecondBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong) UIColor *tableViewColor;

/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;

/** 请求参数offset */
@property (nonatomic, assign) NSInteger offset;
/** 下拉 */
- (void)loadData;
/** 上拉 */
- (void)loadMoreData;

- (instancetype)initWithStyle:(UITableViewStyle)style;

- (NSMutableDictionary *)configureParameters;


@end
