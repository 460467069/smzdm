//
//  HMHomeViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeViewController.h"
#import "ZZHomeHeaderViewController.h"
#import "HMHomeFirstModel.h"
#import "HMHomeFirstLayout.h"
#import "HMHomeFirstCell.h"
#import "HMWorthyArticle.h"
#import "HMListCell.h"
#import "HMYuanChuangCell.h"
#import "ZZDetailViewController.h"

static NSString * const kReuseIdentifierYuanChuangCell = @"HMYuanChuangCell";
static NSString * const kReuseIdentifieFirstCell = @"HMHomeFirstCell";
static NSString * const kReuseIdentiHomeListCell = @"HMListCell";

@interface ZZHomeViewController ()

@property (nonatomic, strong) NSMutableArray<HMWorthyArticle *> *listArrayM;

@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     {{0, 244}, {414, 180}}
    
    self.title = @"发现";
    ZZHomeHeaderViewController *headerVC = [[ZZHomeHeaderViewController alloc] init];
    headerVC.view.backgroundColor = [UIColor redColor];
    headerVC.view.bounds = CGRectMake(0, 0, kScreenW, 360);
    [self addChildViewController:headerVC];
    self.tableView.tableHeaderView = headerVC.view;
    
    [self.tableView registerClass:[HMHomeFirstCell class] forCellReuseIdentifier:kReuseIdentifieFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"HMYuanChuangCell" bundle:nil] forCellReuseIdentifier:kReuseIdentifierYuanChuangCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"HMListCell" bundle:nil] forCellReuseIdentifier:kReuseIdentiHomeListCell];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    LxDBAnyVar(self.tableView.frame);
    
//    LxDBAnyVar(self.tableView.contentOffset);
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    LxDBAnyVar(self.tableView.contentOffset);
//    LxDBAnyVar(self.tableView.contentInset);
}

- (void)loadData{
    
    self.page = 1;
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setValue:@"18" forKey:@"channel_id"];
    [HMNetworking Get:@"v1/util/floor" parameters:dictM complectionBlock:^(id responseObject, NSError *error) {
        if (error) {
            //出错
            [self.tableView.mj_header endRefreshing];
            return;
        }
        NSArray *dataArray = responseObject[@"data"][@"rows"];
        if (dataArray.count == 0) {
            [self.tableView.mj_header endRefreshing];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *temArray = [NSMutableArray array];
            
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                HMHomeFirstModel *firstModel = [HMHomeFirstModel modelWithDictionary:dict];
                HMHomeFirstLayout *firstLayout = nil;
                if (idx == dataArray.count - 1) {
                    firstLayout = [[HMHomeFirstLayout alloc] initWithFirstModel:firstModel isLastOne:YES];
                }else{
                    firstLayout = [[HMHomeFirstLayout alloc] initWithFirstModel:firstModel isLastOne:NO];
                }
                
                [temArray addObject:firstLayout];
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataSource = [temArray copy];
                [self.tableView reloadData];
                
                [self.tableView.mj_header endRefreshing];
            });
        });

    }];


    
    NSMutableDictionary *parameters = [self configureParameters];
    
    [HMNetworking Get:@"v1/util/editors_recommend" parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        
        if (error) {
            //出错
            [self.tableView.mj_header endRefreshing];
            return;
        }
        NSArray *dataArray = [NSArray modelArrayWithClass:[HMWorthyArticle class] json:responseObject[@"data"][@"rows"]];
        if (dataArray.count == 0) {
            [self.tableView.mj_header endRefreshing];
        }
        
        self.listArrayM = [NSMutableArray arrayWithArray:dataArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    }];

    
    
}

- (void)loadMoreData{
    self.page++;
    NSMutableDictionary *parameters = [self configureParameters];
    NSString *timeSort = self.listArrayM.lastObject.time_sort;
    [parameters setValue:timeSort forKey:@"time_sort"];
    
    [HMNetworking Get:@"v1/util/editors_recommend" parameters:parameters complectionBlock:^(id responseObject, NSError *error) {
        NSArray *dataArray = [NSArray modelArrayWithClass:[HMWorthyArticle class] json:responseObject[@"data"][@"rows"]];
        
        if (error) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        
        if (dataArray.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        [self.listArrayM addObjectsFromArray:dataArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSMutableDictionary *)configureParameters{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    [parameters setValue:[NSString stringWithFormat:@"%@", @(self.page)] forKey:@"page"];
    [parameters setValue:@"18" forKey:@"channel_id"];
    [parameters setValue:@"GzmoWix39BJ3ZyoK92%252FGIBxoD0aQU0E3Kz%252Buf8lEciVCB5BAUN91UA%253D%253D" forKey:@"device_id"];
    return parameters;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }else{
        return self.listArrayM.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HMHomeFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifieFirstCell forIndexPath:indexPath];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;   //解决cell选中后内容消失的问题
        HMHomeFirstLayout *layout = self.dataSource[indexPath.row];
        firstCell.layout = layout;
        return firstCell;
    }else{
        
        HMWorthyArticle *article = self.listArrayM[indexPath.row];
        NSInteger channelID = [article.article_channel_id integerValue];
        
        if (channelID == 8 || channelID == 11 || channelID == 14) {
            
            HMYuanChuangCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierYuanChuangCell forIndexPath:indexPath];
            
            cell.article = article;
            return cell;
            
        }
        
        HMListCell *listCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentiHomeListCell forIndexPath:indexPath];
        listCell.type = kHaojiaJingXuan;
        listCell.article = self.listArrayM[indexPath.row];
        return listCell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HMHomeFirstLayout *layout = self.dataSource[indexPath.row];
        return layout.height;
    }else{
        HMWorthyArticle *article = self.listArrayM[indexPath.row];
        NSInteger channelID = [article.article_channel_id integerValue];
        if (channelID == 8 || channelID == 11 || channelID == 14) {
            return 284;
        }
        return kScreenW / 3 + 20 + 2;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        HMWorthyArticle *article = self.listArrayM[indexPath.row];
        
//        https://api.smzdm.com/v2/youhui/articles/6380214?channel_id=1&f=iphone&filtervideo=1&imgmode=0&show_dingyue=1&show_wiki=1&v=7.2&weixin=1
        //国内 v2/youhui/articles
        //海淘 v2/youhui/articles
//        https://api.smzdm.com/v2/youhui/articles/6322999?channel_id=5&f=iphone&filtervideo=1&imgmode=0&show_dingyue=1&show_wiki=1&v=7.2&weixin=1
        //众测 v2/pingce/articles
//        https://api.smzdm.com/v2/pingce/articles/32743?f=iphone&filtervideo=1&imgmode=0&show_dingyue=1&show_wiki=1&v=7.2&weixin=1
        //原创 v2/yuanchuang/articles
//        https://api.smzdm.com/v2/yuanchuang/articles/484134?f=iphone&filtervideo=1&imgmode=0&no_html_series=1&show_dingyue=1&show_share=1&show_wiki=1&v=7.2&weixin=1
        
        
        //话题 v2/wiki/topic_detail(如果为话题, 就不是跳转网页了, 要自己写)
//        http://api.smzdm.com/v2/wiki/topic_detail/687?f=iphone&v=7.2&weixin=1
        
        //资讯 v2/news/articles
//        https://api.smzdm.com/v2/news/articles/28552?f=iphone&filtervideo=1&imgmode=0&show_dingyue=1&show_wiki=1&v=7.2&weixin=1
        ZZDetailViewController *vc = [ZZDetailViewController new];
//        vc.article = article;
        vc.channelID = [article.article_channel_id integerValue];
        vc.article_id = article.article_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - getter && setter
- (NSMutableArray *)listArrayM
{
	if (!_listArrayM){
        _listArrayM = [NSMutableArray array];
	}
	return _listArrayM;
}

@end
