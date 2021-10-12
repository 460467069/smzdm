//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/NSObject+YYModel.h>
#import "YYBBUtilsMacro.h"

typedef NS_ENUM(NSUInteger, YYBBThirdPaymentWay) {
    YYBBThirdPaymentWayH5     = 1,  // h5
    YYBBThirdPaymentWayNative = 2,  //
};

typedef NS_ENUM(NSUInteger, YYBBPaymentFrom) {
    YYBBPaymentFromIAP          = 0,  // 来自内购
    YYBBPaymentFromMallProp     = 1,  // 来自直购商城
};

typedef NS_ENUM(NSUInteger, YYBBPaymentType) {
    YYBBPaymentTypeIAP                        = 2,
};

typedef NS_ENUM(NSUInteger, YYBBOrderWay) {
    YYBBOrderWayGameServer  = 1,   // 通过游戏下单
    YYBBOrderWayYYBBServer = 2,   // 从自己后台下单(测试用)
};

// H5 Way
NS_INLINE NSString *YYBBPaymentNameByType(YYBBPaymentType type) {
    switch (type) {
        case YYBBPaymentTypeIAP:
            return YYBBPlugin_AppStore;
        default:
            return YYBBPlugin_AppStore;
    }
}

// Native Way
NS_INLINE NSString *YYBBPaymentNameByType2(YYBBPaymentType type) {
    switch (type) {
        case YYBBPaymentTypeIAP:
            return YYBBPlugin_AppStore;
        default:
            return YYBBPlugin_AppStore;
    }
}

@interface YYBBPaymentItem : NSObject<YYModel>
@property (nonatomic, assign) YYBBPaymentType paymentType;
@property (nonatomic,   copy) NSString *icon;
@property (nonatomic,   copy) NSString *placeHolderIcon;
@property (nonatomic,   copy) NSString *shortCode;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *productId;
@end

@interface YYBBPaymentModel : NSObject<YYModel>
@property (strong, nonatomic) NSArray<YYBBPaymentItem *> *list;
@property (nonatomic,   copy) NSString *payNoticeMsg;
@property (nonatomic,   copy) NSString *level;
@property (nonatomic, assign) BOOL show;
@property (nonatomic,   copy) NSString *productId;      // 内购上配置的商品id
@end

@interface YYBBProductInfo : NSObject

@property (strong, nonatomic) NSDictionary *extension;
@property (copy,   nonatomic) NSString *orderId;        // cw订单号
@property (copy,   nonatomic) NSString *cpProductId;    // 游戏商品id
@property (copy,   nonatomic) NSString *productId;      // 内购上配置的商品id
@property (copy,   nonatomic) NSString *productName;    // 商品名称
@property (copy,   nonatomic) NSString *productDesc;    // 商品描述
@property (copy,   nonatomic) NSString *price;          // 商品价格
@property (copy,   nonatomic) NSString *currencyCode;
@property (copy,   nonatomic) NSString *paymentStr;
@property (copy,   nonatomic) NSString *formattedprice; // 格式化后的价格
@property NSInteger buyNum;
@property (assign, nonatomic) YYBBPaymentFrom from;     // 默认来自商品内购

@end

@interface YYBBPayOrderInfo : NSObject

@property (nonatomic, strong) NSString * orderNo;
@property (nonatomic, strong) NSArray * payParam;
@property (nonatomic, strong) NSString * payPlatform;
@property (nonatomic, strong) NSString * payUrl;
@property (nonatomic, strong) YYBBProductInfo *productInfo;
@property (nonatomic, strong) NSString * transactionIdentifier;
@property (nonatomic, strong) NSString * transactionReceipt;

@end


@interface YYBBProductMap : NSObject<YYModel>

@property (copy,   nonatomic) NSString *gprd;           // 游戏商品id
@property (copy,   nonatomic) NSString *iprd;           // 内购商品id
@property (copy,   nonatomic) NSString *def;            // 商品默认展示价格, 拉取内购商品信息失败时使用
@property (copy,   nonatomic) NSString *formattedprice; // 格式化后的价格

@end

//YYBBPay 应用内购接口
@protocol YYBBPay <NSObject>

@optional
- (void)payWithPayOrderInfo:(YYBBPayOrderInfo *)payOrderInfo
                paymentItem:(YYBBPaymentItem *)paymentItem
          completionHandler:(YYBBErrorCompletionBlock)completionHandler;

- (void)yybb_showCustomPaymentViewControllerWithProductInfo:(YYBBProductInfo *)productInfo;
- (void)yybb_showCustomPaymentViewControllerWithValidPaymentItems:(NSArray *)ValidPaymentItems
                                                      chooseFinish:(void (^)(YYBBPaymentItem *paymentItem))chooseFinish;
@end


@interface YYBBPaymentInfo : NSObject
@property (strong, nonatomic) YYBBProductInfo *productInfo;
@property (strong, nonatomic) YYBBPaymentItem *paymentItem;
@end
