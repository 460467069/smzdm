//
//  ZZSecondCollectionViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/21.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZSecondCollectionViewController.h"
#import "ZZDIYHeader.h"
#import "ZZDIYBackFooter.h"

@interface ZZSecondCollectionViewController ()

@end

@implementation ZZSecondCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self collectionViewInitial];
    [self refreshHeaderAndFooterInitial];
}

/** 初始化collectionView */
- (void)collectionViewInitial {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollsToTop = YES;
    [self.view addSubview:self.collectionView];
}


/**
 *  上下拉刷新初始化
 */
- (void)refreshHeaderAndFooterInitial {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.collectionView.mj_header = [ZZDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [ZZDIYBackFooter footerWithRefreshingTarget:self
                                                               refreshingAction:@selector(loadMoreData)];
    [self.collectionView.mj_header beginRefreshing];
    
}

- (NSMutableDictionary *)configureParameters {
    return [NSMutableDictionary dictionary];
}


- (void)loadData {}

- (void)loadMoreData {}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - getter && setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
