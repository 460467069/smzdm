//
//  UITableView+YYBBRefresh.m
//  DaDongMen
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UIScrollView+YYBBRefresh.h"
#import <objc/runtime.h>
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/YYCategoriesMacro.h>
#import "YYBBDIYHeader.h"
#import "YYBBDIYBackFooter.h"
#import "YYBBRefreshHeader.h"
#import "YYBBRefreshFooter.h"

@implementation UIScrollView (YYBBRefresh)

- (void)setDataSourceM:(NSMutableArray *)dataSourceM {
    objc_setAssociatedObject(self, @selector(dataSourceM), dataSourceM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dataSourceM {
    return objc_getAssociatedObject(self, @selector(dataSourceM));
}

- (void)setPageIndex:(NSInteger)pageIndex {
    objc_setAssociatedObject(self, @selector(setPageIndex:), @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex {
    return [objc_getAssociatedObject(self, @selector(pageIndex)) integerValue];
}

- (void)yybb_setupRefreshWithTableRequest:(YYBBBaseTableRequest *)tableRequest
                     completionBlock:(void (^)(YYBBListCompletionBlock completionBlock))completionBlock
                     endRefreshBlock:(YYBBEndRefreshBlock)endRefreshBlock {
    [self yybb_setupRefreshWithTableRequest:tableRequest
                           addLoadMore:YES
                       completionBlock:completionBlock
                       endRefreshBlock:endRefreshBlock];
}

- (void)yybb_setupRefreshWithTableRequest:(YYBBBaseTableRequest *)tableRequest
                         addLoadMore:(BOOL)addLoadMore
                     completionBlock:(void (^)(YYBBListCompletionBlock completionBlock))completionBlock
                     endRefreshBlock:(YYBBEndRefreshBlock)endRefreshBlock {
    self.dataSourceM = [NSMutableArray array];
    @weakify(self)
    if (!self.mj_header) {
        [self yybb_headerWithRefreshingBlock:^{
            @strongify(self)
            [self updateDataSource:YYBBRefreshTypeHeader tableRequest:tableRequest completionBlock:completionBlock endRefreshBlock:endRefreshBlock];
        }];
    }
    
    if (!self.mj_footer && addLoadMore) {
        [self yybb_footerWithRefreshingBlock:^{
            @strongify(self)
            [self updateDataSource:YYBBRefreshTypeFooter tableRequest:tableRequest completionBlock:completionBlock endRefreshBlock:endRefreshBlock];
        }];
    }
}

- (void)updateDataSource:(YYBBRefreshType)refreshType
            tableRequest:(YYBBBaseTableRequest *)tableRequest
         completionBlock:(void (^)(YYBBListCompletionBlock))completionBlock
         endRefreshBlock:(YYBBEndRefreshBlock)endRefreshBlock {
    if (refreshType == YYBBRefreshTypeHeader) {
        tableRequest.page = 1;
        [self.mj_footer resetNoMoreData];
    }
    @weakify(self)
    YYBBListCompletionBlock completionHandler = ^(YYBBBaseListResponse *listResponse, NSError *error) {
        @strongify(self)
        NSArray *array = listResponse.list;
        if (error) {
            [self yybb_endRefreshing:refreshType];
            return;
        }
        // 如果下拉的时候用户同时上拉
        if (listResponse.pageIndex == 1) {
            [self.dataSourceM removeAllObjects];
            [self yybb_endRefreshing:refreshType];
            self.dataSourceM = [NSMutableArray arrayWithArray:array];
            // 判断是否加载完毕
            if (listResponse.isLastPage) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (refreshType == YYBBRefreshTypeHeader) {  // 下拉
                [self.dataSourceM removeAllObjects];
                // 判断是否加载完毕
                if (listResponse.isLastPage) {
                    [self.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self yybb_endRefreshing:refreshType];
                }
                self.dataSourceM = [NSMutableArray arrayWithArray:array];
            } else {  // 上拉
                // 判断是否加载完毕
                if (listResponse.isLastPage) {
                    [self.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.mj_footer endRefreshing];
                }
                [self.dataSourceM addObjectsFromArray:array];
            }
        }
        
        !endRefreshBlock ?: endRefreshBlock(refreshType, self.dataSourceM.copy);
        tableRequest.page += 1;
        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)self;
            [tableView reloadData];
        } else if ([self isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)self;
            [collectionView reloadData];
        } else {
            
        }
    };
    
    !completionBlock ?: completionBlock(completionHandler);
}

#pragma mark - Private
- (void)yybb_headerWithRefreshingBlock:(void (^)(void))refreshingBlock {
    self.mj_header = [YYBBRefreshHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)yybb_footerWithRefreshingBlock:(void (^)(void))refreshingBlock {
    self.mj_footer = [YYBBRefreshFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)yybb_triggerPullToRefresh {
    [self.mj_header beginRefreshing];
}

- (void)yybb_endRefreshing:(YYBBRefreshType)refreshType {
    if (refreshType == YYBBRefreshTypeHeader) {
        [self.mj_header endRefreshing];
    } else {
        [self.mj_footer endRefreshing];
    }
}

@end

