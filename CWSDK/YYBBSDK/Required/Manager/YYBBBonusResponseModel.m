//
//  YYBBBonusResponseModel.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 11/9/18.
//

#import "YYBBBonusResponseModel.h"

@implementation YYBBBonusResponseModel
@synthesize msg;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"userBounsModel" : @"data"};
}

@end


@implementation YYBBUserBounsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"products" : [YYBBShopBonusItem class] };
}

@end


@implementation YYBBShopBonusItem

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"productID" : @"id"};
}

@end

@implementation YYBBBonusRegisterResponseModel
@synthesize msg;

+  (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"smsCode" : @"data"};
}

@end

@implementation YYBBBonusVerifyCodeResponseModel
@synthesize msg;

@end

@implementation YYBBBonusExchangeRecordModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [YYBBBonusExchangeRecordDetailModel class] };
}

@end

@implementation YYBBBonusExchangeRecordDetailModel

@end



