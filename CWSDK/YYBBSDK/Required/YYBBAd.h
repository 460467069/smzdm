//
//  YYBBAd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/15/19.
//

#import <Foundation/Foundation.h>

@class YYBBShareInfo;
// 广告
@protocol YYBBAdProtocol<NSObject>

@optional;

/// 展示激励视频
/// @param successHandler 成功回调, reward:奖励的有关数据内容
/// @param failureHandler failureHandler, error: 条件不足的原因
- (void)yybb_showRewardVideoWithPlacedId:(NSString *)placeId
                           successHandler:(void(^)(NSDictionary *reward))successHandler
                           failureHandler:(void(^)(NSError *error))failureHandler;

@end

@interface YYBBAd : NSObject

@end
