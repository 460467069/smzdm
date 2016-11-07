//
//  ZZHomeViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeViewController.h"
#import "ZZHomeChannel.h"
#import "ZZHomeCell.h"
#import "ZZContentViewController.h"
#import "ZZTagLabel.h"

@interface ZZHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 头部的ScrollView */
@property (strong, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopConstraint;

/** collectionView数据源 */
@property (nonatomic, strong) NSArray <ZZHomeChannel *> *dataArray;

/** 控制器缓存 key 频道名字  value是控制器 */
@property (nonatomic, strong) NSMutableDictionary *controllerCache;

/** 红色下划线 */
@property (weak, nonatomic) UIImageView *lineView;
/** 标记按钮 */
@property (nonatomic, strong) UIButton *markBtn;
/** 标题按钮数组 */
@property (nonatomic, strong) NSArray<UIButton *> *titleBtnArray;

@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpScrollView];
    [self.navigationController addObserver:self forKeyPath:@"navigationBar.frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self configureCollectionView];
}

- (void)configureCollectionView{
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
}

- (void)setUpScrollView{
    
    _topScrollView = [[UIScrollView alloc] init];
    _topScrollView.frame = CGRectMake(0, 64, kScreenW, 40);
    _topScrollView.contentSize = CGSizeMake(kScreenW, 0);
    [self.view addSubview:_topScrollView];
    
    //创建顶部Label
    CGFloat tagLabelY = 0;
    CGFloat tagLabelW = kScreenW / self.dataArray.count;
    CGFloat tagLabelH = self.topScrollView.mj_h;
    
    NSMutableArray *temArray = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(ZZHomeChannel * _Nonnull channel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn addTarget:self action:@selector(titleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:channel.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:kGlobalRedColor forState:UIControlStateSelected];
        [titleBtn setTitleColor:kGlobalGrayColor forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat tagLabelX = idx * tagLabelW;
        titleBtn.frame = CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH);
        titleBtn.tag = idx;
        if (idx == 0) {
            [self titleBtnDidClick:titleBtn];
        }
    
        [self.topScrollView addSubview:titleBtn];
        [temArray addObject:titleBtn];
    }];
    
    self.titleBtnArray = [temArray copy];
    
    //红色下划线
    UIImage *lineImage = [UIImage imageNamed:@"bkTx"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineImage];
    lineView.mj_x = (tagLabelW - lineView.mj_w) * 0.5;
    lineView.mj_y =  tagLabelH - lineView.mj_h;
    [self.topScrollView addSubview:lineView];
    self.lineView = lineView;

}

- (void)titleBtnDidClick:(UIButton *)btn {
    
    if ([self.markBtn isEqual:btn]) {
        return;
    }
    
    self.markBtn.selected = NO;
    btn.selected = YES;
    self.markBtn = btn;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:btn.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

    [UIView animateWithDuration:0.3 animations:^{

        self.lineView.centerX = btn.centerX;

    }];

}



- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];

    self.flowLayout.itemSize = self.collectionView.bounds.size;

}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZHomeCell" forIndexPath:indexPath];
    
    //防止cell.contentView重复添加控制器的View
//    [cell.contentController.view removeFromSuperview];
    
    ZZHomeChannel *channel = self.dataArray[indexPath.item];
    ZZContentViewController *contentVc = [self controllerWithChannel:channel];
    cell.contentController = contentVc;
    
    return cell;
}



- (ZZContentViewController *)controllerWithChannel:(ZZHomeChannel *)channel{
    
    //先判断缓存中有没有, 没有的话就自己创建
    ZZContentViewController *contentController = [self.controllerCache objectForKey:channel.title];
    
    if (!contentController) {
        contentController = [[UIStoryboard storyboardWithName:@"ZZContentViewController" bundle:nil] instantiateInitialViewController];
        
        contentController.homeChannel = channel;
        [self.controllerCache setObject:contentController forKey:channel.title];
        
        [self addChildViewController:contentController];
    }
    
    return contentController;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.mj_w;
    
    [self titleBtnDidClick:self.titleBtnArray[index]];
    
}

#pragma mark - getter / setter
- (NSArray <ZZHomeChannel *> *)dataArray {
	if(_dataArray == nil) {
        _dataArray = [ZZHomeChannel homeChannels];
	}
	return _dataArray;
}

- (NSMutableDictionary *)controllerCache {
	if(_controllerCache == nil) {
		_controllerCache = [NSMutableDictionary dictionary];
	}
	return _controllerCache;
}

@end
