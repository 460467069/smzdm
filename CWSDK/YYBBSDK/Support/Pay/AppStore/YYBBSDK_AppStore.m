
//
//  YYBBSDK_AppStore.m
//  YYBBSDK_AppStore
//
//  Created by dayong on 15-1-22.
//  Copyright (c) 2015年 YYBBsdk. All rights reserved.
//

static NSString *const YYBBIAPKey                = @"iap_product";
static NSString *const YYBBTransactionIdentifier = @"transactionIdentifier";
static NSString *const YYBBTransactionReceipt    = @"transactionReceipt";

#import "YYBBSDK_AppStore.h"
#import "YYBBKit.h"

static NSInteger const kRetryCount = 3;

@interface YYBBSDK_AppStore ()
@property (strong, nonatomic) NSArray *availableProducts;
@property (nonatomic, strong) NSMutableArray<YYBBProductInfo *> *savedProductInfos;
@property (nonatomic, strong) YYBBPayOrderInfo *payOrderInfo;
@property (nonatomic, strong) YYBBProductInfo *productInfo;
@property (nonatomic, assign) NSInteger iapRequestRetryCount;      // 内购最多请求尝试次数
@property (nonatomic, assign) NSInteger pmRequestRetryCount;       // 商品映射最多请求尝试次数
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *protdctParams; // 游戏商品id, 格式化后的价格名称
// 推广Payment
@property (nonatomic, strong) SKPayment *promotionPayment;
@property (nonatomic, strong) NSSet<NSString *> *productIdentifiers;
@property (nonatomic, copy) YYBBErrorCompletionBlock errorCompletionBlock;

@end

@implementation YYBBSDK_AppStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iapRequestRetryCount = kRetryCount;
        self.pmRequestRetryCount = kRetryCount;
        self.protdctParams = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)yybb_applicationDidFinishLaunching:(UIApplication *)application {
    NSArray *iaps = [YYBBSDK sharedInstance].config.iaps;
    self.productIdentifiers = [NSSet setWithArray:iaps];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self startProductRequest];
    [self beginMonitorgNotification];
}

- (void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark 预先校验可用商品
- (void)startProductRequest;
{
    self.iapRequestRetryCount -= 1;
    if (self.iapRequestRetryCount < 0) {
        return;
    }
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if (response.products.count > 0) {
        self.availableProducts = response.products;
        [self.protdctParams removeAllObjects];
        for (SKProduct *product in self.availableProducts) {
            for (NSString *productId in self.productIdentifiers) {
                if ([product.productIdentifier isEqualToString:productId]) {
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    numberFormatter.formatterBehavior = NSNumberFormatterBehavior10_4;
                    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
                    numberFormatter.locale = product.priceLocale;
                    NSString *formatterdPrice = [numberFormatter stringFromNumber:product.price];
                    NSLog(@"%@-%@",product.productIdentifier, formatterdPrice);
                    self.protdctParams[product.productIdentifier] = formatterdPrice;
                    break;
                }
            }
        }
        [YYBBSDK sharedInstance].protdctParams = self.protdctParams.copy;
    }
}

#pragma mark - SKRequestDelegate

- (void)requestDidFinish:(SKRequest *)request {
    [self processLostTransaction];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    [self startProductRequest];
}

#pragma mark - YYBBPay
#pragma mark - 用户选择商品后开始支付

- (void)payWithPayOrderInfo:(YYBBPayOrderInfo *)payOrderInfo
                paymentItem:(YYBBPaymentItem *)paymentItem
          completionHandler:(YYBBErrorCompletionBlock)completionHandler {
    
    _payOrderInfo = payOrderInfo;
    self.productInfo = payOrderInfo.productInfo;
    self.errorCompletionBlock = completionHandler;
    [self processLostTransaction];
    [self initiatePaymentRequest];
}

#pragma mark 向苹果发起支付
- (void)initiatePaymentRequest {
    if (self.availableProducts.count == 0) {
        // TODO: FIX ME
        // Initializer might be running or internet might not be available
        NSLog(@"No products are available.");
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                                    code:NSURLErrorUnknown
                                                userInfo:@{NSLocalizedDescriptionKey: @"Payment failed"}];
        !self.errorCompletionBlock ?: self.errorCompletionBlock(error);
        return;
    }
    
    if (![SKPaymentQueue canMakePayments]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"In App Purchasing Disabled", @"")
                                                                            message:NSLocalizedString(@"Check your parental control settings and try again later", @"") preferredStyle:UIAlertControllerStyleAlert];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller
                                                                                     animated:YES
                                                                                   completion:nil];
        return;
    }
    
    NSString *productId = self.productInfo.productId;
    [self.availableProducts enumerateObjectsUsingBlock:^(SKProduct *thisProduct, NSUInteger idx, BOOL *stop) {
        if ([thisProduct.productIdentifier isEqualToString:productId]) {
            *stop = YES;
            SKPayment *payment = [SKPayment paymentWithProduct:thisProduct];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            [SVProgressHUD show];
        }
    }];
}

#pragma mark - App Store 支付回调

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    NSLog(@"paymentQueue called.");
    
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [SVProgressHUD dismiss];
                [self recordTransactionOnSuccess:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"SKPaymentTransactionStatePurchased...");
                break;
            case SKPaymentTransactionStateFailed:
                [SVProgressHUD dismiss];
                // 支付失败或取消
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"SKPaymentTransactionStateFailed...");
                if (transaction.error.code == SKErrorPaymentCancelled) {
                    
                } else {                
                    !self.errorCompletionBlock ?: self.errorCompletionBlock(transaction.error);
                }
                break;
            case SKPaymentTransactionStateRestored:
                [SVProgressHUD dismiss];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"SKPaymentTransactionStateRestored...");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"SKPaymentTransactionStatePurchasing...");
                break;
            default:
                [SVProgressHUD dismiss];
                NSLog(@"SK State Other");
                break;
        }
    }
}

- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product {
#if 0
    BOOL isUserEnterMainInterface = [YYBBSDK sharedInstance].isUserEnterMainInterface;
    NSLog(@"isUserEnterMainInterface----%@", @(isUserEnterMainInterface));
    if (isUserEnterMainInterface) {
        return YES;
    }
#endif
    self.promotionPayment = payment;
    return NO;
}

- (void)startPromotionPayment {
    [[SKPaymentQueue defaultQueue] addPayment:self.promotionPayment];
    [SVProgressHUD show];
    self.promotionPayment = nil;
}

#pragma mark - 苹果支付成功逻辑处理
// App Store告知交易成功 添加交易数据到本地
-(void)recordTransactionOnSuccess:(SKPaymentTransaction *)transaction {
    
    // Save product and transaction data to local for lost order handling
    NSData* receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSString* transactionReceipt = [receiptData base64EncodedStringWithOptions:kNilOptions];
    transactionReceipt = [transactionReceipt stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    transactionReceipt = [transactionReceipt stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    self.payOrderInfo.transactionReceipt = transactionReceipt;
    self.payOrderInfo.transactionIdentifier = transaction.transactionIdentifier;
    
    if (_payOrderInfo) {
        NSArray *jsonArray = [[NSUserDefaults standardUserDefaults] arrayForKey:YYBBIAPKey] ?: [NSArray array];
        jsonArray = [jsonArray arrayByAddingObject:[_payOrderInfo yy_modelToJSONString]];
        [[NSUserDefaults standardUserDefaults] setObject:jsonArray forKey:YYBBIAPKey];
    }
    
    [self validTransaction:transaction];
}

// 向服务器验证交易是否成功
- (void)validTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"recordTransaction called...");
    if (self.payOrderInfo.orderNo.length == 0) {
        [self finishTransaction:transaction];
        NSLog(@"Restore transaction failed...");
        return;
    }
    
    [self payValidate:self.payOrderInfo];
}

// 交易成功更新本地交易数据
- (void)updateSavedProductInfo:(NSString *)transactionIdentifier
{
    NSMutableArray<YYBBPayOrderInfo *> *payOrderInfos = self.savedProductInfos;
    NSUInteger index = [payOrderInfos indexOfObjectPassingTest:^BOOL(YYBBPayOrderInfo * _Nonnull payOrderInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        return [payOrderInfo.transactionIdentifier isEqualToString:transactionIdentifier];
    }];
    
    if (index != NSNotFound) {
        [payOrderInfos removeObjectAtIndex:index];
        NSMutableArray *jsonArray = [NSMutableArray array];
        [payOrderInfos enumerateObjectsUsingBlock:^(YYBBPayOrderInfo * _Nonnull payOrderInfo, NSUInteger idx, BOOL * _Nonnull stop) {
            [jsonArray addObject:[payOrderInfo yy_modelToJSONString]];
        }];
        [[NSUserDefaults standardUserDefaults] setObject:jsonArray forKey:YYBBIAPKey];
    }
}

// 交易成功的正式结束
- (void)finishTransaction:(SKPaymentTransaction *)transaction
{
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [self updateSavedProductInfo:transaction.transactionIdentifier];
}

#pragma mark - 服务器校验

- (void)payValidate:(YYBBPayOrderInfo *)payOrderInfo {
    NSString *transactionIdentifier = payOrderInfo.transactionIdentifier;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"receipt"] = payOrderInfo.transactionReceipt;
    params[YYBBTransactionIdentifier] = transactionIdentifier;
    
    @weakify(self)
    [[YYBBFormNetworkAPIClient sharedClient] yybb_commonRequestWithUrl:kPayValidate parameters:params.copy onFinished:^(id  _Nullable responseObj, NSError * _Nullable error) {
        @strongify(self)
        if (error) {
            !self.errorCompletionBlock ?: self.errorCompletionBlock(error);
            return;
        }
        [self updateSavedProductInfo:transactionIdentifier];
        !self.errorCompletionBlock ?: self.errorCompletionBlock(nil);
    }];
}

#pragma mark - 漏单处理

- (void)processLostTransaction {
    @weakify(self)
    [self.savedProductInfos enumerateObjectsUsingBlock:^(YYBBProductInfo * _Nonnull payOrderInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        [self payValidate:payOrderInfo];
    }];
}

#pragma mark - Notification

- (void)beginMonitorgNotification {
    [self endMonitorgNotification];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(userDidEnterMainInterface:)
//                                                 name:YYBBSDKUserEnterMaiInterface
//                                               object:nil];
}

- (void)endMonitorgNotification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:YYBBSDKUserEnterMaiInterface
//                                                  object:nil];
}

- (void)userDidEnterMainInterface:(NSNotification *)notification {
//    [YYBBSDK sharedInstance].isUserEnterMainInterface = YES;
    if (self.promotionPayment == nil) {
        return;
    }
    [self startPromotionPayment];
}

#pragma mark - getter && setter
- (NSMutableArray<YYBBPayOrderInfo *> *)savedProductInfos {
    NSMutableArray *productInfos = [NSMutableArray array];
    NSArray<NSString *> *array = [[NSUserDefaults standardUserDefaults] arrayForKey:YYBBIAPKey];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull jsonString, NSUInteger idx, BOOL * _Nonnull stop) {
        if (jsonString.length > 0) {
            [productInfos addObject:[YYBBPayOrderInfo yy_modelWithJSON:jsonString]];
        }
    }];
    return productInfos;
}

@end
