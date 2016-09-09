//
//  ZZDetailViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/30.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailViewController.h"
#import <WebKit/WebKit.h>
#import "HMChannelID.h"
#import "ZZCircleView.h"

#define kBottomBarHeight 44
#define NAVBAR_CHANGE_POINT 50

@interface ZZDetailViewController ()<WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) HMChannelID *channel;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) ZZCircleView *circleView;
@property (nonatomic, strong) UIView *bottomToolBar;
@end

@implementation ZZDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    self.navigationController.navigationBar.barTintColor = ZZColor(214, 214, 214);
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];


    
    //初始化底部工具栏
    [self initialBottomToolBar];
    //初始化webView
    [self initialWebView];

    //加载数据
    [self loadWebViewData];
    //初始化预加载动画, 有顺序要求
    [self initialCustomIndicatorView];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"loading"];
    self.webView.scrollView.delegate = nil;
}


#pragma mark - 初始化控件
- (void)initialBottomToolBar{

    UIView *bottomToolBar = [[UIView alloc] init];
    bottomToolBar.backgroundColor = [UIColor randomColor];
    [self.view addSubview:bottomToolBar];
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(kBottomBarHeight);
    }];
    self.bottomToolBar = bottomToolBar;
}

- (void)initialWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [[WKPreferences alloc] init];
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    webView.scrollView.scrollsToTop = YES;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    self.webView = webView;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(20);
        make.bottom.mas_equalTo(self.bottomToolBar.mas_top).offset(0);
    }];
    webView.scrollView.delegate = self;
}

- (void)initialCustomIndicatorView{
    ZZCircleView *circleView = [[ZZCircleView alloc] init];
    circleView.center = self.view.center;
    circleView.width = 30;
    circleView.height = 30;
    [circleView startAnimating];
    [self.view addSubview:circleView];
    self.circleView = circleView;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (void)configureLeftBarButtonItemWithImage:(UIImage *)leftImage rightBarButtonItemWithImage:(UIImage *)rightImage{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(detailLeftBtnDidClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(detailRightBtnDidClick)];
}

#pragma mark - loadData
- (void)loadWebViewData{
    NSInteger channelID = [self.article.article_channel_id integerValue];
    
    HMChannelID *channel = [HMChannelID channelWithID:channelID];
    self.channel = channel;
    NSString *URLStr = [NSString stringWithFormat:@"%@/%@", channel.URLString, self.article.article_id];
    [HMNetworking Get:URLStr parameters:[self configureParameters] complectionBlock:^(NSDictionary *responseObject, NSError *error) {
        
        if (error) {
            return;
        }
        NSString *html5Content = nil;
        if (channelID == 6) {
            html5Content = responseObject[@"data"][@"article_filter_content"];
        }else{
            html5Content = responseObject[@"data"][@"html5_content"];
        }
        if (html5Content.length > 0) {
            
            
            [self.circleView stopAnimating];
            [self.circleView removeFromSuperview];
            
            WKWebView *webView = self.webView;
            
            [webView loadHTMLString:html5Content baseURL:nil];
//            [self scrollViewDidScroll:webView.scrollView];
        }
        
    }];
}


- (NSMutableDictionary *)configureParameters{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSInteger channelID = [self.article.article_channel_id integerValue];
    
    if (channelID != 14) {
        [parameters setValue:@"0" forKey:@"imgmode"];
        [parameters setValue:@"1" forKey:@"filtervideo"];
        [parameters setValue:@"1" forKey:@"show_dingyue"];
        [parameters setValue:@"1" forKey:@"show_wiki"];
        
    }
    
    switch (channelID) {
        case 1:
        case 5:
            [parameters setValue:self.article.article_channel_id forKey:@"channel_id"];
            break;
        case 6:
        case 8:
            break;
        case 11:
            [parameters setValue:@"1" forKey:@"no_html_series"];
            [parameters setValue:@"1" forKey:@"show_share"];
            break;
        case 14:
            
            break;
            
        default:
            break;
    }
    
    return parameters;
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"loading"]) {
//        LxDBAnyVar(@"正在加载");
    }
    
}

#pragma mark - 事件监听
- (void)detailLeftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)detailRightBtnDidClick {
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self configureLeftBarButtonItemWithImage:[UIImage imageNamed:@"SM_Detail_Back"] rightBarButtonItemWithImage:[UIImage imageNamed:@"SM_Detail_Right"]];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    UIColor *color = ZZColor(214, 214, 214);
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - (NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        if (alpha == 1) {
            [self configureLeftBarButtonItemWithImage:[UIImage imageNamed:@"SM_Detail_BackSecond"] rightBarButtonItemWithImage:[UIImage imageNamed:@"SM_Detail_RightSecond"]];
        }

    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
}


#pragma mark - WKNavigationDelegate

/** 页面开始加载时调用 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    

    
//    LxDBAnyVar(@"页面开始加载时调用");
}

/** 当内容开始返回时调用 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    LxDBAnyVar(@"当内容开始返回时调用");
    
}

/** 页面加载完成时调用 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    LxDBAnyVar(@"页面加载完成时调用");

}

/** 页面加载失败时调用 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    LxDBAnyVar(@"页面加载失败时调用");
}

/** 接收到服务器跳转请求之后调用 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    LxDBAnyVar(@"接收到服务器跳转请求之后调用");
}

/** 在发送请求之前决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    LxDBAnyVar(@"Decides whether to allow or cancel a navigation.");
    
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    //详情: "about"
    
    LxDBAnyVar(scheme);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

/** 在收到响应之后决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    LxDBAnyVar(@"Decides whether to allow or cancel a navigation after its response is known.");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - WKUIDelegate
/**
 *  页面可以正常显示,但是里面的按钮全部失效了
 
    解决办法:
    只要在原来的基础上实现一个代理方法就可以了,设置WKWebView的UIDelegate,实现下面的方法就好了:
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (navigationAction.targetFrame.isMainFrame) {
        
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

@end
