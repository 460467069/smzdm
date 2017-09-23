//
//  ZZSecondCollectionViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/21.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZSecondBaseViewController.h"

@interface ZZSecondCollectionViewController : ZZSecondBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

/** collectionView须由子类实例化 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *dataSource;
/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;
/** 请求参数offset */
@property (nonatomic, assign) NSInteger offset;
/** 下拉 */
- (void)loadData;
/** 上拉 */
- (void)loadMoreData;

- (NSMutableDictionary *)configureParameters;

/** 初始化collectionView, 注意由子类实例化一个collectionView, 最后才调用super(具体demo可查看"白菜专区控制器") */
- (void)collectionViewInitial;

@end
