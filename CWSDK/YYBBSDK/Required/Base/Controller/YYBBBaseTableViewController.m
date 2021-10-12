//
//  YYBBBaseTableViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseTableViewController.h"
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "UIScrollView+YYBBRefresh.h"
#import "YYBBUtilsMacro.h"
#import "YYBBNetworkApiClient.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSObject+YYBBAdd.h"

@interface YYBBBaseTableViewController ()

@property (nonatomic, readwrite) UITableViewStyle style;
@property (nonatomic, strong) NSArray *tableViewConstraints;

@end

@implementation YYBBBaseTableViewController

@synthesize dataSource = _dataSource;
@synthesize tableRequest = _tableRequest;
@synthesize listResponse = _listResponse;
@synthesize isEmptyDataSource = _isEmptyDataSource;
@synthesize allowHeaderRefresh = _allowHeaderRefresh;
@synthesize allowFooterRefresh = _allowFooterRefresh;

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
}

- (NSMutableDictionary *)configureParameters {
    return [NSMutableDictionary dictionary];
}

- (void)configureHeaderRefresh {
    self.allowHeaderRefresh = YES;
    @weakify(self)
    [self.tableView yybb_headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataWithRefreshType:YYBBRefreshTypeHeader];
    }];
}

- (void)configureFooterRefresh {
    self.allowFooterRefresh = YES;
    @weakify(self)
    [self.tableView yybb_footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataWithRefreshType:YYBBRefreshTypeFooter];
    }];
}

- (void)loadDataWithRefreshType:(YYBBRefreshType)refreshType {
    // 上下拉互斥
    YYBBBaseTableRequest *tableRequest = self.tableRequest;
    YYAssertNotNil(tableRequest, @"子类须初始化Request");
    YYAssertNotNil(tableRequest.responseClass, @"子类须指定responseClass");
    if (refreshType == YYBBRefreshTypeHeader) { // 下拉
        if ([self.tableView.mj_footer isRefreshing]) {
            return;
        }
        tableRequest.page = 1;
    } else { // 上拉
        if ([self.tableView.mj_header isRefreshing]) {
            return;
        }
    }
    YYBBRequestCache cache = nil;
    if (tableRequest.isShouldCache) {
        cache = ^(id responseCache) {
            
        };
    }
    @weakify(self)
    NSURLSessionDataTask *task = [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithRequest:self.tableRequest responseCache:cache onFinished:^(YYBBBaseListResponse *_Nullable listResponse, NSError * _Nullable error) {
        @strongify(self)
        NSArray *array = listResponse.list;
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            [self.tableView yybb_endRefreshing:refreshType];
            return;
        }
        
        if (refreshType == YYBBRefreshTypeHeader) { // 下拉
            [self.dataSource removeAllObjects];
            // 重置
            [self.tableView.mj_footer resetNoMoreData];
        } else {
            
        }
        // 是否加载完毕
        BOOL isAllLoad = NO;
        if ([array yybb_isNotEmpty]) {
            self.isEmptyDataSource = NO;
            [self.dataSource addObjectsFromArray:array];
        } else {
            if (refreshType == YYBBRefreshTypeHeader) { // 下拉无数据
                self.isEmptyDataSource = YES;
                // 禁止上拉
                self.tableView.mj_footer = nil;
            } else {
                isAllLoad = YES;
            }
        }
        // 结束刷新
        [self.tableView yybb_endRefreshing:refreshType];
        if (isAllLoad) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            self.tableRequest.page += 1;
        }
        
        listResponse.list = self.dataSource.copy;
        self.listResponse = listResponse;
        // 刷新
        [self reloadTableViewWithRefreshType:refreshType];
        [self reloadTableViewWithRefreshType:refreshType response:array];
        [self.tableView reloadData];
    }];
    
    [self.yybb_activityIndicatorView setAnimatingWithStateOfTask:task];
}

#pragma mark - Private

- (void)reloadTableViewWithRefreshType:(YYBBRefreshType)refreshType {
    if ([self respondsToSelector:@selector(endRefreshWithRefreshType:)]) {
        [self endRefreshWithRefreshType:refreshType];
    }
}

- (void)reloadTableViewWithRefreshType:(YYBBRefreshType)refreshType response:(NSArray *_Nullable)response {
    if ([self respondsToSelector:@selector(endRefreshWithRefreshType:response:)]) {
        [self endRefreshWithRefreshType:refreshType response:response];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.isEmptyDataSource) {
        return nil;
    }
    return [UIImage imageNamed:@"group_buy_no_data"];
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

- (YYBBBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [self yybb_customTableView];
        _tableView.directionalLockEnabled = YES;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(0);
            make.top.offset(YYBBNavHeight());
        }];
    }
    return _tableView;
}

- (YYBBBaseTableView *)yybb_customTableView {
    YYBBBaseTableView *tableView = [[YYBBBaseTableView alloc] initWithFrame:self.view.bounds style:self.style];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, YYBBBottomHeight(), 0);
    tableView.backgroundColor = [UIColor yybb_grayScaleBgColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [UIView new];
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.scrollsToTop = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.alwaysBounceHorizontal = NO;
    return tableView;
}

@end
