//
//  YYBBRefreshProtocol.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 12/21/19.
//

#ifndef YYBBRefreshProtocol_h
#define YYBBRefreshProtocol_h


typedef NS_ENUM(NSUInteger, YYBBRefreshType) {
    YYBBRefreshTypeHeader,
    YYBBRefreshTypeFooter
};

@protocol YYBBRefreshDelegate <NSObject>

// 如果要发起请求, 子类实现
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) YYBBBaseTableRequest *tableRequest;
@property (nonatomic, strong) YYBBBaseListResponse *listResponse;
@property (nonatomic, assign) BOOL isEmptyDataSource;
@property (nonatomic, assign, getter=isAllowHeaderRefresh) BOOL allowHeaderRefresh;
@property (nonatomic, assign, getter=isAllowFooterRefresh) BOOL allowFooterRefresh;

@optional;
- (void)configureHeaderRefresh;
- (void)configureFooterRefresh;
- (void)loadDataWithRefreshType:(YYBBRefreshType)refreshType;
- (void)endRefreshWithRefreshType:(YYBBRefreshType)refreshType;
- (void)endRefreshWithRefreshType:(YYBBRefreshType)refreshType response:(NSArray *_Nullable)response;

@end


#endif /* YYBBRefreshProtocol_h */
