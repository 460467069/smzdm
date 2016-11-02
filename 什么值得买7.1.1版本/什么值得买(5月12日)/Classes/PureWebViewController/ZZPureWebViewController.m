//
//  ZZPureWebViewController.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/2.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZPureWebViewController.h"
#import <WebKit/WebKit.h>

@interface ZZPureWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ZZPureWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.redirectdata.link_title;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.redirectdata.link]];
    
    [self.webView loadRequest:request];
    
}


- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.frame = self.view.bounds;
        [self.view addSubview:_webView];
    }
    
    return _webView;
}

@end
