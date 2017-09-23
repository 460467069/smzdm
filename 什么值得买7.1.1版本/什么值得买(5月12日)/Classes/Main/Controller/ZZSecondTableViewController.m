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
@property (nonatomic, readwrite) UITableViewStyle style;
@end

@implementation ZZSecondTableViewController

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshHeaderAndFooterInitial];
}


- (NSMutableDictionary *)configureParameters {
    return [NSMutableDictionary dictionary];
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"error_default"];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark - getter && setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setTableViewColor:(UIColor *)tableViewColor {
    _tableViewColor = tableViewColor;
    self.tableView.backgroundColor = tableViewColor;
    self.tableView.mj_footer.backgroundColor = tableViewColor;
    self.tableView.mj_header.backgroundColor = tableViewColor;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
        tableView.top = kZZStatusH + kZZNavH;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        tableView.scrollsToTop = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

@end
