//
//  ZZContentViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZContentViewController.h"
#import "SDCycleScrollView.h"
#import "ZZContentHeader.h"
#import "ZZListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ZZDIYHeader.h"
#import "ZZDIYBackFooter.h"
#import "ZZTuiGuangCell.h"
#import "ZZDetailArticleViewController.h"
#import "ZZDetailTopicViewController.h"
#import "ZZPureWebViewController.h"
#import "什么值得买-Swift.h"

static NSString * const kTuiGuangCell = @"ZZTuiGuangCell";
static NSString * const kListCell = @"ZZListCell";

@interface ZZContentViewController ()<SDCycleScrollViewDelegate, ZZActionDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *imageViews;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <ZZWorthyArticle *> *dataArrayM;
//@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) ZZHaoJiaHeaderView *headerView;

/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;

/** 请求参数offset */
@property (nonatomic, assign) NSInteger offset;

@end

@implementation ZZContentViewController

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
    self.tableView.mj_header = [ZZDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.mj_footer = [ZZDIYBackFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    

    
    ZZHaoJiaHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ZZHaoJiaHeaderView" owner:nil options:nil].lastObject;
    headerView.cycleScrollView.delegate = self;
    self.headerView = headerView;
    headerView.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.headerView.height = kScreenW / 320.0 * self.headerView.height;

        self.tableView.tableHeaderView = headerView;

    });
}

/** 请求头部数据 */
- (void)loadHeaderData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"home" forKey:@"type"];
    [parameters setValue:self.homeChannel.type forKey:@"type"];
    [ZZAPPDotNetAPIClient Get:self.homeChannel.headerURLString parameters:parameters completionBlock:^(id responseObject, NSError *error) {
        if (error){
            return;
        }
        //设置轮播图片
        ZZContentHeader *headerModel = [ZZContentHeader modelWithJSON:responseObject];
        self.headerView.contentHeader = headerModel;
        
    }];
}

/** 请求tableView的数据 */
- (void)loadData
{
    self.page = 1;
    self.offset = 0;
    [ZZAPPDotNetAPIClient Get:self.homeChannel.URLString parameters:[self configureParameters] completionBlock:^(id responseObject, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (error) { return;}
        
        NSArray *rows = responseObject[@"rows"];
        
        NSArray *temArray = [NSArray modelArrayWithClass:[ZZWorthyArticle class] json:rows];
        self.dataArrayM = [NSMutableArray arrayWithArray:temArray];
        [self.tableView reloadData];
        
        self.page++;
        self.offset = self.dataArrayM.count;
    }];
}

- (void)loadMoreData
{
//    https://api.smzdm.com/v1/faxian/articles?article_date=2016-11-19%2012%3A01%3A18&f=iphone&imgmode=0&limit=20&offset=20&page=2&v=7.3.3&weixin=1

//    https://api.smzdm.com/v1/faxian/articles?article_date=2016-11-19%2011%3A52%3A41&f=iphone&imgmode=0&limit=20&offset=40&page=3&v=7.3.3&weixin=1
    
//    https://api.smzdm.com/v1/home/articles?f=iphone&have_zhuanti=1&imgmode=0&limit=20&page=2&time_sort=147952645142&v=7.3.3&weixin=1
    NSMutableDictionary *parameters = [self configureParameters];
    ZZWorthyArticle *artcle = self.dataArrayM.lastObject;
    if (![self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        [parameters setValue:artcle.article_date forKey:@"article_date"];
        [parameters setValue:[NSString stringWithFormat:@"%@", @(self.offset)] forKey:@"offset"];
    }else{
        [parameters setValue:artcle.time_sort forKey:@"time_sort"];
    }
    
    [ZZAPPDotNetAPIClient Get:self.homeChannel.URLString parameters:parameters completionBlock:^(id responseObject, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
        if (error) { return;}
        
        NSArray *rows = responseObject[@"rows"];
        NSArray *temArray = [NSArray modelArrayWithClass:[ZZWorthyArticle class] json:rows];
        [self.dataArrayM addObjectsFromArray:temArray];
        [self.tableView reloadData];
        
        self.page++;
        self.offset = self.dataArrayM.count;
    }];
}

- (NSMutableDictionary *)configureParameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        [parameters setValue:@"have_zhuanti"  forKey:@"1"];
    }
    [parameters setValue:@"0"  forKey:@"imgmode"];
    [parameters setValue:[NSString stringWithFormat:@"%@", @(self.page)]  forKey:@"page"];
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
    
    ZZWorthyArticle *article = self.dataArrayM[indexPath.row];
    
    if ([article.promotion_type isEqualToString:@"1"]) {
        
        ZZTuiGuangCell *tuiGuangCell = [tableView dequeueReusableCellWithIdentifier:kTuiGuangCell forIndexPath:indexPath];
        tuiGuangCell.article = article;
        return tuiGuangCell;
    }
    ZZListCell *cell = [tableView dequeueReusableCellWithIdentifier:kListCell forIndexPath:indexPath];
    cell.homeChannel = self.homeChannel;
    cell.article = article;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//https://api.smzdm.com/v2/youhui/articles/6643905?channel_id=5&f=iphone&filtervideo=1&imgmode=0&show_dingyue=1&show_wiki=1&v=7.3.3&weixin=1
    ZZWorthyArticle *article = self.dataArrayM[indexPath.row];
    [self jumpToDetailArticleViewControllerWithArticle:article];
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

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    ZZRedirectData *redirectdata = self.headerView.contentHeader.rows[index].redirectdata;

    [self jumpToDetailArticleViewControllerWithRedirectdata:redirectdata];
    
    
}

#pragma mark - ZZActionDelegate
- (void)itemDidClickWithRedirectData:(ZZRedirectData * _Nonnull)redirectData{
    
    [self jumpToDetailArticleViewControllerWithRedirectdata:redirectData];
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
