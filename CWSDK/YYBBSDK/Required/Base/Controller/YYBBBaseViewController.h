//
//  YYBBBaseViewController.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/8/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBBProtocol.h"
#import <AFNetworking/UIActivityIndicatorView+AFNetworking.h>

//#import "WRCustomNavigationBar.h"

typedef NS_ENUM(NSUInteger, DDNetWorkStatus) {
    
    DDNetWorkStatusNoInternet,//没有网络
    DDNetWorkStatusFlow,//流量连接
    DDNetWorkStatusWifi //wifi链接
};

//重新加载
typedef void (^DDBaseReloadBlock)(void);

@interface YYBBBaseViewController : UIViewController<YYBBViewControllerDelegate>

//@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (nonatomic, weak) id<YYBBViewControllerDelegate> yybb_delegate;
@property (nonatomic, strong) UIActivityIndicatorView *yybb_activityIndicatorView;

- (void)rightAction:(id)sender;
- (void)backAction:(id)sender;

- (void)setNavLeftImage:(NSString *)imageName;
- (void)setNavRightImage:(NSString *)imageName;

- (void)setNavLeftTitle:(NSString *)leftTitle;
- (void)setNavRightTitle:(NSString *)rightTitle;

@property (nonatomic,assign) DDNetWorkStatus netStatus;
@property (nonatomic, strong) UIView *netTopView;
-(NSAttributedString *)getAttributesWithStr:(NSString *)str;

//无数据 无网络图片
@property (nonatomic, copy) NSString *dataSetImgStr;
@property (nonatomic, strong) NSAttributedString *dataSetAttributeStr;
@property (nonatomic, copy) DDBaseReloadBlock reloadBlock;
-(void)reloadChildVc;
-(DDNetWorkStatus)getRealTimeStatus;

-(void)showOrNotNetTopLb;


@end
