//
//  ZZMineViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZMineViewController.h"
#import "ZZUserAccount.h"
#import "ZZWeiboTableView.h"
#import "YYKit.h"
#import <WeiboSDK.h>

@interface ZZMineViewController ()<UITabBarDelegate, UITableViewDataSource, UITableViewDelegate>
/** tableView */
@property (nonatomic, strong) ZZWeiboTableView  *tableView;
@property (nonatomic, strong) NSMutableArray *layouts;

@property (assign, readwrite, nonatomic) IBInspectable CGSize contentViewStoryboardID;
/** 菊花指示器 */
@property (weak, nonatomic) UIActivityIndicatorView  *indicatorView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    ZZUserAccount *userAccount = [ZZUserAccount accountUser];
    if (!userAccount) {
        [self SendSSOAuthorize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRequestWeiboData) name:ZZUserAccountDidHandleUserDataNotification object:nil];
    }else{
        [self beginRequestWeiboData];
    }

    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicatorView.mj_size = CGSizeMake(80, 80);
    indicatorView.center = CGPointMake(self.view.mj_w / 2, self.view.mj_h / 2);
    indicatorView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    indicatorView.layer.cornerRadius = 6;
    indicatorView.clipsToBounds = YES;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i <= 7; i++) {
            NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"weibo_%@.json", @(i)]];
            
            
        }
    });

}




/** 进行SSO授权 */
- (void)SendSSOAuthorize
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kShareSinaWeiboRedirectUri;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController"};
    [WeiboSDK sendRequest:request];
}

/** 请求微博数据 */
- (void)beginRequestWeiboData {
    
    
    ZZUserAccount *userAccount = [ZZUserAccount accountUser];
    
    if (userAccount) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        [parameters setValue:userAccount.accessToken forKey:@"access_token"];
        
        [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
    
}

#pragma mark - getter && setter
- (ZZWeiboTableView *)tableView{
    if (!_tableView) {
        _tableView = [ZZWeiboTableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSMutableArray *)layouts{
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}



@end
