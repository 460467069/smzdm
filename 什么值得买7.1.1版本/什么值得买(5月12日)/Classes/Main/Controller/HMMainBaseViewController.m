//
//  HMBaseViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMMainBaseViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface HMMainBaseViewController ()

@end

@implementation HMMainBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SecondHand_Search"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemDidClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dingyueMian"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidClick)];
    
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
