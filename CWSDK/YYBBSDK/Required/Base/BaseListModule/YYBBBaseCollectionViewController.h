//
//  YYBBBaseCollectionViewController.h
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseViewController.h"
#import "YYBBBaseCollectionView.h"
#import "YYBBSectionListModel.h"
#import "YYBBBaseRequest.h"
#import "YYBBBaseResponse.h"
#import "YYBBProtocol.h"
#import "YYBBBaseCollectionView.h"
#import "YYBBRefreshProtocol.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseCollectionViewController : YYBBBaseViewController
<
YYBBViewControllerDelegate,
IGListAdapterDataSource,
YYBBRefreshDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>

@property(nonatomic, strong) IGListAdapter *adapter;
@property(nonatomic, strong, readonly) YYBBBaseCollectionView *collectionView;
@property(nonatomic, strong, readonly) NSMutableArray *listDataArrayM;
@property (nonatomic, strong) YYBBSectionListModel *sectionListModel;

- (YYBBBaseCollectionView *)yybb_customCollectionView;

- (UICollectionViewFlowLayout *)yybb_collectionViewFlowLayout;

@end

NS_ASSUME_NONNULL_END
