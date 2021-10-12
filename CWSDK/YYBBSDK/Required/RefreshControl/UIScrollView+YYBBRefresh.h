//
//  UITableView+YYBBRefresh.h
//  DaDongMen
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBBBaseRequest.h"
#import "YYBBBaseResponse.h"
#import "YYBBRefreshProtocol.h"

typedef void(^YYBBEndRefreshBlock)(BOOL isLoadMore, NSArray *dataSource);

@interface UIScrollView (YYBBRefresh)

@property (strong, nonatomic) NSMutableArray *dataSourceM;
@property (assign, nonatomic) NSInteger pageIndex;

/**
 *  添加上下拉刷新
 *
 *  @param tableRequest    请求request
 *  @param completionBlock 网络请求具体实现
 *  @param endRefreshBlock 结束回调
 */
- (void)yybb_setupRefreshWithTableRequest:(YYBBBaseTableRequest *)tableRequest
                     completionBlock:(void (^)(YYBBListCompletionBlock completionBlock))completionBlock
                     endRefreshBlock:(YYBBEndRefreshBlock)endRefreshBlock;

/**
 *  添加刷新
 *
 *  @param tableRequest    请求request
 *  @param addLoadMore     是否需要添加上拉加载更多
 *  @param completionBlock 网络请求具体实现
 *  @param endRefreshBlock 结束回调
 */
- (void)yybb_setupRefreshWithTableRequest:(YYBBBaseTableRequest *)tableRequest
                         addLoadMore:(BOOL)addLoadMore
                     completionBlock:(void (^)(YYBBListCompletionBlock completionBlock))completionBlock
                     endRefreshBlock:(YYBBEndRefreshBlock)endRefreshBlock;


// 下拉刷新
- (void)yybb_headerWithRefreshingBlock:(void (^)(void))refreshingBlock;

// 上拉加载更多
- (void)yybb_footerWithRefreshingBlock:(void (^)(void))refreshingBlock;

// 开始刷新数据
- (void)yybb_triggerPullToRefresh;

// 结束刷新
- (void)yybb_endRefreshing:(YYBBRefreshType)refreshType;

@end
