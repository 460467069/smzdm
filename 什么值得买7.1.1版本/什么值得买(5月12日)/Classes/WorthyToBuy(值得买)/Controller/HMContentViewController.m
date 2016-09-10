//
//  HMContentViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMContentViewController.h"
#import "SDCycleScrollView.h"
#import "HMContentHeader.h"
#import "HMListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HMDIYHeader.h"
#import "HMDIYBackFooter.h"
#import "HMTuiGuangCell.h"
#import "ZZDetailViewController.h"


static NSString * const kTuiGuangCell = @"HMTuiGuangCell";
static NSString * const kListCell = @"HMListCell";

@interface HMContentViewController ()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *imageViews;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <HMWorthyArticle *> *dataArrayM;

/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation HMContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.scrollsToTop = YES;
    [self.tableView registerNib:[UINib nibWithNibName:kTuiGuangCell bundle:nil] forCellReuseIdentifier:kTuiGuangCell];
    [self.tableView registerNib:[UINib nibWithNibName:kListCell bundle:nil] forCellReuseIdentifier:kListCell];
    
    self.tableView.rowHeight = kScreenW / 3 + 20 + 2;
    //请求头部数据
    [self loadHeaderData];

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [HMDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.mj_footer = [HMDIYBackFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

/** 请求头部数据 */
- (void)loadHeaderData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"home" forKey:@"type"];
    [parameters setValue:self.homeChannel.type forKey:@"type"];
    [HMNetworking Get:self.homeChannel.headerURLString parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        if (error){
            return;
        }
        
        //设置轮播图片
        NSDictionary *dataDict = responseObject[@"data"];
        HMContentHeader *headerModel = [HMContentHeader mj_objectWithKeyValues:dataDict];
        NSMutableArray *picArray = [NSMutableArray array];
        [headerModel.rows enumerateObjectsUsingBlock:^(HMHeadLine *_Nonnull headLine, NSUInteger idx, BOOL *_Nonnull stop) {
            [picArray addObject:headLine.img];
        }];
        self.cycleScrollView.imageURLStringsGroup = picArray;
        
        //轮播下面的4张小图片
        
        [headerModel.little_banner enumerateObjectsUsingBlock:^(HMLittleBanner *_Nonnull littleBanner, NSUInteger idx1, BOOL *_Nonnull stop) {
            [self.imageViews
             enumerateObjectsUsingBlock:^(UIImageView *_Nonnull imageView, NSUInteger idx2, BOOL *_Nonnull stop) {
                 if (idx1 == idx2)
                 {
                     [imageView sd_setImageWithURL:[NSURL URLWithString:littleBanner.img]];
                 }
             }];
        }];
    }];
}

/** 请求tableView的数据 */
- (void)loadData
{
    self.page = 1;

    [HMNetworking Get:self.homeChannel.URLString parameters:[self configureParameters] complectionBlock:^(id responseObject, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        if (error)
        {
            return;
        }
        
        NSArray *rows = responseObject[@"data"][@"rows"];
        
        self.dataArrayM = [HMWorthyArticle mj_objectArrayWithKeyValuesArray:rows];
        
        [self.tableView reloadData];
        
    }];
}

- (void)loadMoreData
{
    self.page++;
    NSMutableDictionary *parameters = [self configureParameters];
    HMWorthyArticle *artcle = self.dataArrayM.lastObject;
    if (![self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        //需百分号转义
        NSString *article_date = [artcle.article_date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [parameters setValue:article_date forKey:@"article_date"];
    }else{
        [parameters setValue:artcle.time_sort forKey:@"time_sort"];
    }
    
    [HMNetworking Get:self.homeChannel.URLString parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error)
        {
            return;
        }
        
        NSArray *rows = responseObject[@"data"][@"rows"];
        
        NSArray *temArray = [HMWorthyArticle mj_objectArrayWithKeyValuesArray:rows];
        
        [self.dataArrayM addObjectsFromArray:temArray];
        
        [self.tableView reloadData];
    }];
}

- (NSMutableDictionary *)configureParameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        [parameters setValue:@"have_zhuanti"  forKey:@"1"];
    }
    [parameters setValue:[NSString stringWithFormat:@"%@", @(self.page)]
                  forKey:@"page"];
    [parameters setObject:@"20" forKey:@"limit"];
    return parameters;
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWorthyArticle *article = self.dataArrayM[indexPath.row];
    
    if ([article.promotion_type isEqualToString:@"1"]) {
        
        HMTuiGuangCell *tuiGuangCell = [tableView dequeueReusableCellWithIdentifier:kTuiGuangCell forIndexPath:indexPath];
        tuiGuangCell.article = article;
        return tuiGuangCell;
    }
    HMListCell *cell = [tableView dequeueReusableCellWithIdentifier:kListCell forIndexPath:indexPath];
    cell.homeChannel = self.homeChannel;
    cell.article = article;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HMWorthyArticle *article = self.dataArrayM[indexPath.row];
    ZZDetailViewController *vc = [ZZDetailViewController new];
    vc.article = article;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress{
    
    if (self.offsetBlock) {
        self.offsetBlock(progress);
    }
}



#pragma mark - getter / setter
- (NSMutableArray *)dataArrayM
{
    if (_dataArrayM == nil)
    {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

@end
