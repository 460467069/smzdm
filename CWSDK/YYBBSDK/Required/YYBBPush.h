//
//  YYBBPush.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 11/27/19.
//


typedef void (^JPushAliasOperationCompletion)(NSInteger iResCode, NSString * _Nullable iAlias, NSInteger seq);

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//分享接口
@protocol YYBBPush<NSObject>

@optional;

#pragma mark - JPush

/**
设置Alias

@param alias 需要设置的alias
@param completion 响应回调
@param seq 请求序列号
*/
- (void)setAlias:(NSString *)alias
completion:(JPushAliasOperationCompletion)completion
       seq:(NSInteger)seq;

/*!
* @abstract JPush标识此设备的 registrationID
*
* @discussion SDK注册成功后, 调用此接口获取到 registrationID 才能够获取到.
*
* JPush 支持根据 registrationID 来进行推送.
* 如果你需要此功能, 应该通过此接口获取到 registrationID 后, 上报到你自己的服务器端, 并保存下来.
* registrationIDCompletionHandler:是新增的获取registrationID的方法，需要在block中获取registrationID,resCode为返回码,模拟器调用此接口resCode返回1011,registrationID返回nil.
* 更多的理解请参考 JPush 的文档网站.
*/
- (void)registrationIDCompletionHandler:(void(^)(int resCode,NSString *registrationID))completionHandler;

@end

@interface YYBBPush : NSObject

@end

NS_ASSUME_NONNULL_END
