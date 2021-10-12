//
//  YYBBSDK.h
//  YYBBSDK
//
//  Created by Wang_ruzhou on 15-1-21.
//  Copyright (c) 2015年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBPay.h"

@implementation YYBBPaymentItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"paymentType" : @"id"
             };
}

- (NSString *)placeHolderIcon {
    YYBBPaymentType paymentType = self.paymentType;
    switch (paymentType) {
        case YYBBPaymentTypeIAP:
            return @"pay_apple";
        default:
            return @"";
    }
}

@end

@implementation YYBBPaymentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : @"YYBBPaymentItem"
             };
}

@end


@implementation YYBBProductInfo

@end


@implementation YYBBPayOrderInfo

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"orderNo"]          = @"order_no";
    dictM[@"payParam"]         = @"pay_param";
    dictM[@"payPlatform"]      = @"pay_platform";
    dictM[@"payUrl"]           = @"pay_url";
    return dictM.copy;
}

@end

@implementation YYBBPaymentInfo
@end

@implementation YYBBProductMap
@end


