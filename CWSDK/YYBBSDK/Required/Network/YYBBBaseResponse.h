//
//  YYBBBaseResponse.h
//  
//
//  Created by Wang_Ruzhou on 10/11/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//


#import "YYBBNetworkEnum.h"
#import <YYModel/YYModel.h>

typedef void(^YYBBCompletionBlcok)(id _Nullable responseObj, NSError * _Nullable error);
typedef void(^YYBBServerSuccessBlcok)(id responseObj);
typedef void(^YYBBServerErrorMsgBlcok)(NSString * errorMsg);
typedef void(^YYBBFailureBlcok)(NSError * error);

NS_ASSUME_NONNULL_BEGIN

@interface YYBBBaseResponse : NSObject<YYModel>

@property (nonatomic, assign) YYBBNetworkCompleteType status;
@property (nonatomic,   copy) NSString *msg;

@end

@interface YYBBGlobalResponse : YYBBBaseResponse

@property (nonatomic, strong) id data;

@end

@interface YYBBBaseListResponse : NSObject<YYModel>

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, assign) NSInteger noReadCount;

@end

typedef void (^YYBBListCompletionBlock)(YYBBBaseListResponse * _Nullable listResponse, NSError * _Nullable error);

NS_ASSUME_NONNULL_END
