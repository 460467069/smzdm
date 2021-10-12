//
//  YYBBSDK_AppStore.h
//  YYBBSDK_AppStore
//
//  Created by dayong on 15-1-22.
//  Copyright (c) 2015年 YYBBsdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "YYBBPay.h"
#import "YYBBPlugin.h"

@interface YYBBSDK_AppStore : YYBBPlugin<YYBBPay, SKProductsRequestDelegate, SKPaymentTransactionObserver , UIAlertViewDelegate>

@end
