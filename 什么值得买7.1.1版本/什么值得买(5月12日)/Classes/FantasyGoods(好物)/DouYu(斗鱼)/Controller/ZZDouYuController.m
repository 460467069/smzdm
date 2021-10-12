//
//  ZZFantasticGoodsController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDouYuController.h"
#import "SDCycleScrollView.h"
#import "ZZDouYUBannerModel.h"
#import "ZZDouYuHomeModel.h"
#import "ZZDouYuBannerCell.h"
#import "ZZDouYuHomeTableViewCell.h"
#import "ZZDouYuHomeCollectionViewCell.h"
#import "YYFPSLabel.h"
#import "UIView+YYAdd.h"


#define kWBCellPadding 12


#define KHMDouYUBannerModelFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"KHMDouYUBannerModelData.plist"]

#define KHMDouYUHomeDataFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"KHMDouYUHomeDataFilePath.plist"]

@interface ZZDouYuController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *bannerLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
/** 主页列表数据 */
@property (nonatomic, strong) NSMutableArray *roomListArrayM;
@property (weak, nonatomic) IBOutlet UIView *customHeaderView;

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
/** <##> */
@property (nonatomic, assign)CGFloat height;
@end

@implementation ZZDouYuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"斗鱼";
    // Do any additional setup after loading the view.
    [self configureCycleScrollView];
    [self loadDouYuHomeListOfflineData];
    [self.tableView registerClass:[ZZDouYuHomeTableViewCell class] forCellReuseIdentifier:kHMDouYuHomeTableViewCell];
    self.fpsLabel = [[YYFPSLabel alloc] init];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = self.view.height - 60;
    _fpsLabel.left = kWBCellPadding;
    _fpsLabel.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_fpsLabel];
    
    self.customHeaderView.mj_h = 0.45 * kScreenHeight;  //0.45粗略给的比例
    self.tableView.tableHeaderView = self.customHeaderView;

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self configureBannerLayout];
    });
}

- (void)configureBannerLayout {
    CGFloat height = self.bannerCollectionView.mj_h - self.bannerCollectionView.contentInset.top - self.bannerCollectionView.contentInset.bottom - 1;
    self.bannerLayout.itemSize = CGSizeMake(height, height);

}

#pragma mark - 轮播

/** 配置轮播视图 */
- (void)configureCycleScrollView {
    self.cycleScrollView.delegate = self;
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [self loadBannerOfflineData];
    
    
    
}


/** 优先加载头部轮播视图离线数据 */
- (void)loadBannerOfflineData {

    NSArray *dataArray = [NSArray arrayWithContentsOfFile:KHMDouYUBannerModelFilePath];

    if (dataArray) {
        [self handelDouYuBannelData:dataArray];
        return;
    }
    
    [self requestDouYuBannelData];
    
}

/** 请求轮播数据 */
- (void)requestDouYuBannelData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://www.douyutv.com/api/v1/slide/6" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        [self handelDouYuBannelData:dataArray];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //存储请求到的数据
            [dataArray writeToFile:KHMDouYUBannerModelFilePath atomically:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/** 处理数据 */
- (void)handelDouYuBannelData:(NSArray *)dataArray {
    
    NSArray *modelArray = [ZZDouYUBannerModel mj_objectArrayWithKeyValuesArray:dataArray];
    NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
    NSMutableArray *titlesGroup = [NSMutableArray array];
    
    for (ZZDouYUBannerModel *model in modelArray) {
        [imageURLStringsGroup addObject:model.pic_url];
        [titlesGroup addObject:model.title];
    }
    
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroup;
    self.cycleScrollView.titlesGroup = titlesGroup;
}




#pragma mark - 首页列表
/** 请求首页列表数据 */
- (void)requestDouYuHomeListData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1468225740&token=55360132_864bfe31ed07ac49&auth=063032102391e4e305555bab99e2d45c" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        [self handelDouYuHomeData:dataArray];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //存储请求到的数据
            [dataArray writeToFile:KHMDouYUHomeDataFilePath atomically:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/** 优先加载头首页列表离线数据 */
- (void)loadDouYuHomeListOfflineData {
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:KHMDouYUHomeDataFilePath];
    
    if (dataArray) {
        [self handelDouYuHomeData:dataArray];
        return;
    }
    
    [self requestDouYuHomeListData];
    
    
    
    
}

/** 处理数据 */
- (void)handelDouYuHomeData:(NSArray *)dataArray{
    
    self.roomListArrayM = [ZZDouYuHomeModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    [self.tableView reloadData];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([collectionView isEqual:self.bannerCollectionView]) {
        return self.roomListArrayM.count;
    }else if ([collectionView isMemberOfClass:[AFIndexedCollectionView class]]){
        ZZDouYuHomeModel *bannelModel = self.roomListArrayM[[(AFIndexedCollectionView *)collectionView indexPath].row];
        
        return bannelModel.room_list.count;
    }
    
    return 0;
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.bannerCollectionView]) {
        ZZDouYuBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZDouYuBannerCell" forIndexPath:indexPath];
        
        cell.bannelModel = self.roomListArrayM[indexPath.item];
        
        return cell;
    }else if ([collectionView isMemberOfClass:[AFIndexedCollectionView class]]){
        
        ZZDouYuHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
        
        ZZDouYuHomeModel *bannelModel = self.roomListArrayM[[(AFIndexedCollectionView *)collectionView indexPath].row];

        ZZDouYURoom_List *listModel = bannelModel.room_list[indexPath.item];
        
        cell.listModel = listModel;
        return cell;
    }
    
    return nil;

}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.roomListArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZDouYuHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMDouYuHomeTableViewCell forIndexPath:indexPath];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ZZDouYuHomeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZDouYuHomeModel *bannelModel = self.roomListArrayM[indexPath.row];
    
//    LxDBAnyVar(bannelModel.room_list.count);
    
    return kHMDouYuTitileViewHeight + bannelModel.room_list.count * 0.5 * kHMDouYuHomeCollectionViewCellHeight;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - getter & setter
- (NSMutableArray *)roomListArrayM {
	if(_roomListArrayM == nil) {
		_roomListArrayM = [NSMutableArray array];
	}
	return _roomListArrayM;
}

- (NSMutableDictionary *)contentOffsetDictionary {
	if(_contentOffsetDictionary == nil) {
		_contentOffsetDictionary = [NSMutableDictionary dictionary];
	}
	return _contentOffsetDictionary;
}

@end
