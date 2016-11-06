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

@interface ZZContentViewController ()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *imageViews;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <ZZWorthyArticle *> *dataArrayM;
//@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) ZZHaoJiaHeaderView *headerView;

/** 请求参数页码 */
@property (nonatomic, assign) NSInteger page;

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
    self.headerView = headerView;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        LxDBAnyVar(self.headerView.height);
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
    [ZZNetworking Get:self.homeChannel.headerURLString parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        if (error){
            return;
        }
        //设置轮播图片
        ZZContentHeader *headerModel = [ZZContentHeader mj_objectWithKeyValues:responseObject];
        self.headerView.contentHeader = headerModel;
        
    }];
}

/** 请求tableView的数据 */
- (void)loadData
{
    self.page = 1;

    [ZZNetworking Get:self.homeChannel.URLString parameters:[self configureParameters] complectionBlock:^(id responseObject, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (error) { return;}
        
        NSArray *rows = responseObject[@"rows"];
        
        NSArray *temArray = [NSArray modelArrayWithClass:[ZZWorthyArticle class] json:rows];
        self.dataArrayM = [NSMutableArray arrayWithArray:temArray];
        [self.tableView reloadData];
        
        self.page++;
    }];
}

- (void)loadMoreData
{
    
    NSMutableDictionary *parameters = [self configureParameters];
    ZZWorthyArticle *artcle = self.dataArrayM.lastObject;
    if (![self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        //需百分号转义
        NSString *article_date = [artcle.article_date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [parameters setValue:article_date forKey:@"article_date"];
    }else{
        [parameters setValue:artcle.time_sort forKey:@"time_sort"];
    }
    
    [ZZNetworking Get:self.homeChannel.URLString parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
        if (error) { return;}
        
        NSArray *rows = responseObject[@"rows"];
        NSArray *temArray = [NSArray modelArrayWithClass:[ZZWorthyArticle class] json:rows];
        [self.dataArrayM addObjectsFromArray:temArray];
        [self.tableView reloadData];
        
        self.page++;
    }];
}

- (NSMutableDictionary *)configureParameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if ([self.homeChannel.type isEqualToString:kHaojiaJingXuan]) {
        [parameters setValue:@"have_zhuanti"  forKey:@"1"];
    }
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

    ZZWorthyArticle *article = self.dataArrayM[indexPath.row];
    NSInteger channelID = [article.article_channel_id integerValue];
    
    if (channelID == 14) {
        ZZDetailTopicViewController *detailTopicVc = [[ZZDetailTopicViewController alloc] init];
        detailTopicVc.channelID = channelID;
        [self.navigationController pushViewController:detailTopicVc animated:YES];
        return;
    }
    
    if ([article.tag isEqualToString:@"广告"]) {
        ZZPureWebViewController *webViewController = [[ZZPureWebViewController alloc] init];
        webViewController.redirectdata = article.redirect_data;
        [self.navigationController pushViewController:webViewController animated:YES];
        
        return;
    }
    
    ZZDetailArticleViewController *vc = [[ZZDetailArticleViewController alloc] init];
    vc.channelID = channelID;
    vc.article_id = article.article_id;
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
