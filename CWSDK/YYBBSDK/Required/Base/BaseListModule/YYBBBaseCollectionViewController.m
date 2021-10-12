//
//  YYBBBaseCollectionViewController.m
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseCollectionViewController.h"
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/YYCGUtilities.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "YYBBUtilsMacro.h"
#import "UIScrollView+YYBBRefresh.h"
#import "YYBBBaseListSectionController.h"
#import "YYBBNetworkApiClient.h"
#import "NSObject+YYBBAdd.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface YYBBBaseCollectionViewController ()

@property(nonatomic, strong) YYBBBaseCollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *listDataArrayM;

@end

@implementation YYBBBaseCollectionViewController

@synthesize dataSource = _dataSource;
@synthesize tableRequest = _tableRequest;
@synthesize listResponse = _listResponse;
@synthesize isEmptyDataSource = _isEmptyDataSource;
@synthesize allowHeaderRefresh = _allowHeaderRefresh;
@synthesize allowFooterRefresh = _allowFooterRefresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(YYBBNavHeight());
        make.left.right.bottom.offset(0);
    }];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    if (@available(iOS 11.0, *)) {
        
    } else {
        if (self && [self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

#pragma mark - 刷新

- (void)configureHeaderRefresh {
    self.allowHeaderRefresh = YES;
    @weakify(self)
    [self.collectionView yybb_headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataWithRefreshType:YYBBRefreshTypeHeader];
    }];
}

- (void)configureFooterRefresh {
    self.allowFooterRefresh = YES;
    @weakify(self)
    [self.collectionView yybb_footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadDataWithRefreshType:YYBBRefreshTypeFooter];
    }];
}

#pragma mark - Api Request

- (void)loadDataWithRefreshType:(YYBBRefreshType)refreshType {
    // 上下拉互斥
    YYBBBaseTableRequest *tableRequest = self.tableRequest;
    YYAssertNotNil(tableRequest, @"子类须初始化Request");
    YYAssertNotNil(tableRequest.responseClass, @"子类须指定responseClass");
    if (refreshType == YYBBRefreshTypeHeader) { // 下拉
        if ([self.collectionView.mj_footer isRefreshing]) {
            return;
        }
        tableRequest.page = 1;
    } else { // 上拉
        if ([self.collectionView.mj_header isRefreshing]) {
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
        self.listResponse = listResponse;
        NSArray *array = listResponse.list;
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            [self.collectionView yybb_endRefreshing:refreshType];
            return;
        }
        
        if (refreshType == YYBBRefreshTypeHeader) { // 下拉
            [self.listDataArrayM removeAllObjects];
            // 重置
            [self.collectionView.mj_footer resetNoMoreData];
        } else {
            
        }
        // 是否加载完毕
        BOOL isAllLoad = NO;
        if ([array yybb_isNotEmpty]) {
            [self.listDataArrayM addObjectsFromArray:array];
        } else {
            if (refreshType == YYBBRefreshTypeHeader) { // 下拉无数据
                self.isEmptyDataSource = YES;
                // 禁止上拉
                self.collectionView.mj_footer = nil;
            } else {
                isAllLoad = YES;
            }
        }
        // 结束刷新
        [self.collectionView yybb_endRefreshing:refreshType];
        if (isAllLoad) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            self.tableRequest.page += 1;
        }
        
        // 刷新
        [self reloadCollectionViewWithRefreshType:refreshType];
        [self.collectionView reloadData];
    }];
    
    [self.yybb_activityIndicatorView setAnimatingWithStateOfTask:task];
}

#pragma mark - Private

- (void)reloadCollectionViewWithRefreshType:(YYBBRefreshType)refreshType {
    if ([self respondsToSelector:@selector(endRefreshWithRefreshType:)]) {
        [self endRefreshWithRefreshType:refreshType];
    } else {
        [self.collectionView reloadData];
    }
}


#pragma mark - IGListAdapterDataSource

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.dataSource;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(YYBBSectionListModel *)sectionModel {
    IGListSectionController *sectionController = nil;
    if ([sectionModel.sectionController isKindOfClass:[IGListSectionController class]]) {
        sectionController = sectionModel.sectionController;
    } else if ([sectionModel.sectionControllerStr isKindOfClass:[NSString class]]) {
        sectionController = [[NSClassFromString(sectionModel.sectionControllerStr) alloc] init];
    }
    sectionController.inset                   = sectionModel.inset;
    sectionController.minimumInteritemSpacing  = sectionModel.minimumInteritemSpacing;
    sectionController.minimumLineSpacing = sectionModel.minimumLineSpacing;
    return sectionController;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.isEmptyDataSource) {
        return nil;
    }
    return [UIImage imageNamed:@"no_data"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.isEmptyDataSource) {
        return nil;
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    {
        NSString *string = @"NO DATA";
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:string];
        one.yy_font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        one.yy_color = [UIColor yybb_middleGrayColor];
        [text appendAttributedString:one.copy];
    }
    return text;
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


#pragma mark - Getter && Setter
- (IGListAdapter *)adapter {
    if (!_adapter) {
        IGListAdapterUpdater *listAdapterUpdater = [[IGListAdapterUpdater alloc] init];
        _adapter = [[IGListAdapter alloc] initWithUpdater:listAdapterUpdater viewController:self];
    }
    return _adapter;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [self yybb_customCollectionView];
    }
    return _collectionView;
}

- (YYBBBaseCollectionView *)yybb_customCollectionView {
    UICollectionViewFlowLayout *flowLayout = [self yybb_collectionViewFlowLayout];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    YYBBBaseCollectionView *collectionView = [[YYBBBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.scrollsToTop = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.alwaysBounceHorizontal = NO;
    collectionView.emptyDataSetSource = self;
    collectionView.emptyDataSetDelegate = self;
    return collectionView;
}

- (UICollectionViewFlowLayout *)yybb_collectionViewFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return flowLayout;
}

- (NSMutableArray *)listDataArrayM {
    if (!_listDataArrayM) {
        _listDataArrayM = [NSMutableArray array];
    }
    return _listDataArrayM;
}

@end
