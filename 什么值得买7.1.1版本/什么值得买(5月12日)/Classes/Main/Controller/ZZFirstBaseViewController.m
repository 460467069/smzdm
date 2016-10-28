//
//  ZZBaseViewController.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZFirstBaseViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "什么值得买-Swift.h"
#import "UINavigationItem+Margin.h"

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
    
    CGFloat offset = 50.0;
    if (kScreenW > 320) {
        offset = 80.0;
    }
    customSearchBar.size = CGSizeMake(kScreenW - offset * 2, 32);
    customSearchBar.userInteractionEnabled = YES;
    
    UIImageView *scopeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_searchIcon"]];
    [customSearchBar addSubview:scopeView];
    [scopeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15.0);
        make.centerY.offset(0);
    }];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"一样花钱 怎样更值";
    placeHolderLabel.font = [UIFont systemFontOfSize:15];
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [customSearchBar addSubview:placeHolderLabel];
    [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(scopeView.mas_right).offset(15.0);
    }];
    self.placeHolderLabel = placeHolderLabel;
    
    UIButton *scanBtn = [[UIButton alloc] init];
    [customSearchBar addSubview:scanBtn];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"homePage_scan"] forState:UIControlStateNormal];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.size.mas_equalTo(CGSizeMake(15.0, 16.0));
        make.centerY.offset(0);
    }];
    scanBtn.showsTouchWhenHighlighted = NO;
    scanBtn.adjustsImageWhenHighlighted = NO;
    scanBtn.centerY = customSearchBar.centerY;
    
    [scanBtn addTarget:self action:@selector(scanBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = customSearchBar;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarDidClick)];
    [customSearchBar addGestureRecognizer:tap];
    
    
}


#pragma - mark 事件监听

/** 搜索框点击 */
- (void)searchBarDidClick{
    
}

/** 二维码扫描按钮点击 */
- (void)scanBtnDidClick{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        
        ZZQRcodeController *QRcodeController = [[ZZQRcodeController alloc] init];
        
        [self.navigationController pushViewController:QRcodeController animated:YES];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"相机不可用"];
    }
}

/** 筛选按钮点击 */
- (void)leftBarButtonItemDidClick {
	
}

/** 关注按钮点击 */
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
