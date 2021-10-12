//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by dayong on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYBBProductInfo;
// 统计分析、崩溃采集接口
@protocol YYBBServerAnalytics <NSObject>

// 设备信息上报
- (void)deviceInfoReport;

@end

@protocol YYBBAnalytics <NSObject>

@optional
// 开始关卡的时候，调用
- (void)yybb_startLevel:(NSString*)level;
// 关卡失败时，调用
- (void)yybb_failLevel:(NSString*)level;
// 关卡结束时，调用
- (void)yybb_finishLevel:(NSString*)level;

/*
//开始任务
-(void) startTask:(NSString*)task type:(NSString*)type;
//任务失败
-(void) failTask:(NSString*)task;
//完成任务
-(void) finishTask:(NSString*)task;
*/

// 充值的时候调用
- (void)yybb_pay:(double)money coin:(int)coin source:(int)source;
- (void)yybb_pay:(double)money item:(NSString*)item num:(int)num price:(double)price source:(int)source;
// 游戏中所有虚拟消费，比如用金币购买某个道具都使用 buy 方法
- (void)yybb_buy:(NSString*)item num:(int)num price:(double)price;
// 消耗物品的时候，调用
- (void)yybb_use:(NSString*)item num:(int)num price:(double)price;
// 额外获取虚拟币时，trigger 触发奖励的事件, 取值在 1~10 之间，“1”已经被预先定义为“系统奖励”， 2~10 需要在网站设置含义。
- (void)yybb_bonus:(NSString*)item num:(int)num price:(double)price trigger:(int)trigger;

// 登录的时候调用
- (void)yybb_login:(NSString*)userID;
// 登出的时候调用
- (void)yybb_logout;

/* --------------------------------------- */
// 付款成功(1)
- (void)yybb_paidSuccessWithProdutInfo:(YYBBProductInfo *)productInfo;
// 完成新手引导
- (void)yybb_completeBeginnerGuide;
// 升级
- (void)yybb_levelUp:(NSInteger)level;
// 登录
- (void)yybb_userLogin;
// 加入购物车
- (void)yybb_addToShoppingCartWithProdutInfo:(YYBBProductInfo *)productInfo;
// 花费虚拟货币
- (void)yybb_spendVirtualCurrency;
// 查看购买页面
- (void)yybb_viewPurchasePage;
// 成就解锁
- (void)yybb_unlockArchivement;
// 分享
- (void)yybb_share;
// 提交评价
- (void)yybb_submitComment;
// 完成注册
- (void)yybb_completeRegistration;

@end
