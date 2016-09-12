//
//  HMDetailTopicViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailTopicViewController.h"
#import "HMChannelID.h"
#import "HMDetailTopicHeaderView.h"
#import "HMDetailTopicModel.h"


@interface HMDetailTopicViewController ()

@property (nonatomic, strong) HMDetailTopicHeaderLayout *topicHeaderLayout;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, copy) NSString *order;

@end

@implementation HMDetailTopicViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SM_Detail_BackSecond"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(detailLeftBtnDidClick)];
    self.navigationItem.rightBarButtonItem = nil;
    
    self.order = @"按热度";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:kGlobalLightGrayColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    
}

#pragma mark - 请求数据

- (void)loadData{
    HMChannelID *channel = [HMChannelID channelWithID:_channelID];
    
    NSString *URLStr = [NSString stringWithFormat:@"%@/%@", channel.URLString, _article_id];
    [HMNetworking Get:URLStr parameters:[NSMutableDictionary dictionary] complectionBlock:^(id responseObject, NSError *error) {
        if (error) { return;}
        
        HMDetailTopicHeaderModel *detailModel = [HMDetailTopicHeaderModel modelWithDictionary:responseObject];
        _topicHeaderLayout = [[HMDetailTopicHeaderLayout alloc] initWithHeaderDetailModel:detailModel];
        
        HMDetailTopicHeaderView *headerView = [[HMDetailTopicHeaderView alloc] init];
        headerView.topicHeaderLayout = _topicHeaderLayout;
        self.tableView.tableHeaderView = headerView;
        
    }];
    // v2/wiki/comments
    
    [HMNetworking Get:@"v2/wiki/comments" parameters:[self configureParameters] complectionBlock:^(id responseObject, NSError *error) {
        
        NSArray *dataArray = responseObject[@"comment_list"];
        if (error || dataArray.count == 0) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        NSArray *temArray = [NSArray modelArrayWithClass:[HMDetailTopicModel class] json:dataArray];
        self.dataSource = [NSMutableArray arrayWithArray:temArray];
        
//        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}

- (NSMutableDictionary *)configureParameters{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:[NSString stringWithFormat:@"%@", @(self.offset)] forKey:@"offset"];
    [parameters setValue:_article_id forKey:@"topic_id"];
    [parameters setValue:_article_id forKey:@"order"];
    return parameters;
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (void)detailLeftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
