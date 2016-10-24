//
//  ZZBaseViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZFirstBaseViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface ZZFirstBaseViewController ()

@end

@implementation ZZFirstBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemDidClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关注" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidClick)];
    
    [self configureSearchBar];
}

- (void)configureSearchBar{
    
    
    UIImageView *customSearchBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_searchBG"]];
    customSearchBar.size = CGSizeMake(kScreenW - 80 * 2, 32);
    customSearchBar.userInteractionEnabled = YES;
    
    
    UIImageView *scopeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_searchIcon"]];
    [customSearchBar addSubview:scopeView];
    scopeView.left = 15.0;
    scopeView.centerY = customSearchBar.centerY;
    
    UILabel *placeHolder = [[UILabel alloc] init];
    placeHolder.text = @"一样花钱 怎样更值";
    placeHolder.font = [UIFont systemFontOfSize:15];
    placeHolder.textColor = [UIColor lightGrayColor];
    [placeHolder sizeToFit];
    [customSearchBar addSubview:placeHolder];
    placeHolder.centerY = customSearchBar.centerY;
    placeHolder.left = scopeView.right + 15.0;
    
    UIButton *scanBtn = [[UIButton alloc] init];
    [scanBtn setImage:[UIImage imageNamed:@"homePage_scan"] forState:UIControlStateNormal];
    [scanBtn sizeToFit];
    scanBtn.right = customSearchBar.width - 10.0;
    scanBtn.centerY = customSearchBar.centerY;
    [customSearchBar addSubview:scanBtn];
    
    
    self.navigationItem.titleView = customSearchBar;
    
}

- (void)leftBarButtonItemDidClick {
	
}

- (void)rightBarButtonItemDidClick {
//    //新建一个聊天会话View Controller对象
//    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
//    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
//    chat.conversationType = ConversationType_CUSTOMERSERVICE;
//    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
//    chat.targetId = @"targetIdYouWillChatIn";
//    //设置聊天会话界面要显示的标题
//    chat.title = @"色魔张大妈";
//    //显示聊天会话界面
//    [self.navigationController pushViewController:chat animated:YES];
    RCPublicServiceChatViewController *conversationVC = [[RCPublicServiceChatViewController alloc] initWithConversationType:ConversationType_CUSTOMERSERVICE targetId:@"KEFU146920780830124"];
    conversationVC.title = @"色魔张大妈";
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}





@end
