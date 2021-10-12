//
//  CountDownManager.h
//  CellCountDown
//
//  Created by herobin on 16/9/11.
//  Copyright © 2016年 herobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYBBCountDownTimerProtocol <NSObject>

- (void)countDownWithTimeInterval:(NSTimeInterval)timeInterval;

@end

@interface YYBBCountDownTimer : NSObject


@property (nonatomic, assign) NSInteger timeInterval;
- (instancetype _Nonnull )initWithTimerBlock:(void (^)(NSTimeInterval timeInterval))timerBlock;

/** 开始倒计时 */
- (void)start;

/** 停止倒计时 */
- (void)invalidate;

@end
