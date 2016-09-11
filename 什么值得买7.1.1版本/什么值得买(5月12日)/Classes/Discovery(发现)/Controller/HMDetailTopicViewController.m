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


@interface HMDetailTopicViewController ()

@property (nonatomic, strong) HMDetailTopicHeaderLayout *topicHeaderLayout;

@end

@implementation HMDetailTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SM_Detail_BackSecond"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(detailLeftBtnDidClick)];
    self.navigationItem.rightBarButtonItem = nil;
    
    HMChannelID *channel = [HMChannelID channelWithID:_channelID];
    
    NSString *URLStr = [NSString stringWithFormat:@"%@/%@", channel.URLString, _article_id];
    [HMNetworking Get:URLStr parameters:[NSMutableDictionary dictionary] complectionBlock:^(id responseObject, NSError *error) {
        if (error) {
            return;
        }
        HMDetailTopicModel *detailModel = [HMDetailTopicModel modelWithDictionary:responseObject[@"data"]];
        _topicHeaderLayout = [[HMDetailTopicHeaderLayout alloc] initWithHeaderDetailModel:detailModel];
        
        HMDetailTopicHeaderView *headerView = [[HMDetailTopicHeaderView alloc] init];
        headerView.topicHeaderLayout = _topicHeaderLayout;
        
        self.tableView.tableHeaderView = headerView;
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:kGlobalLightGrayColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (void)detailLeftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
