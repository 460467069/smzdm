//
//  YYBBEnvironmentSwitchController.h
//  YYCardBoard
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <YYBBSDK/YYBBSDK.h>
#import "YYBBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBEnvironmentModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *baseUrlStr;
@property (nonatomic, copy) NSString *markBaseUrlStr;
@property (nonatomic, copy) NSString *quotationBaseUrlStr;
@property (nonatomic, copy) NSString *webUrlStr;
@property (nonatomic, copy) NSString *webUpdateVersionUrlStr;
@property (nonatomic, copy) NSString *domainUrlStr;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface YYBBDomainModel : NSObject

// 是否是自定义输入
@property (nonatomic, assign) BOOL isCustomInput;
@property (nonatomic, assign) BOOL isSelected;
// 是否为测试环境
@property (nonatomic, assign) BOOL isDebug;
@property (nonatomic, copy) NSString *baseUrlStr;

@end

@interface YYBBDomainSwitchManager : NSObject

@property (nonatomic, strong) NSArray<YYBBEnvironmentModel *> *envModels;

@property (nonatomic, strong) YYBBEnvironmentModel *currentEnvironmentModel;

@property (nonatomic, strong) YYBBDomainModel *currentDomainModel;
// 环境
@property (nonatomic, strong, nullable) NSArray<YYBBEnvironmentModel *> *environmentModels;
// 正式环境, 二级厂请求头
@property (nonatomic, strong, nullable) NSMutableArray<YYBBDomainModel *> *releaseFactoryDomains;
// 测试环境, 二级厂请求头
@property (nonatomic, strong, nullable) NSMutableArray<YYBBDomainModel *> *debugFactoryDomains;

+ (instancetype)sharedInstance;

- (void)yybb_initialization;

- (void)setAllToNotSelected;

- (void)saveEnvironment;

@end

@interface YYBBEnvironmentSwitchController : YYBBBaseViewController

@end

NS_ASSUME_NONNULL_END
