//
//  CountDownManager.m
//  CellCountDown
//
//  Created by herobin on 16/9/11.
//  Copyright © 2016年 herobin. All rights reserved.
//

#import "YYBBCountDownTimer.h"
#import <UIKit/UIKit.h>
#import <YYText/YYTextWeakProxy.h>
#import "LxDBAnything.h"

@interface YYBBCountDownTimer ()

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void (^timerBlock)(NSTimeInterval timeInterval);

@end

@implementation YYBBCountDownTimer

- (instancetype _Nonnull )initWithTimerBlock:(void (^)(NSTimeInterval timeInterval))timerBlock {
    self = [super init];
    if (self) {
        _timerBlock = [timerBlock copy];
        [self beginMonitorgNotification];
    }
    return self;
}

- (void)start {
    [_timer invalidate];
    [self reload];
    [self startTimer];
}

// 启动定时器
- (void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:1.0
                                     target:[YYTextWeakProxy proxyWithTarget:self]
                                   selector:@selector(timerStart)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)reload {
    _startDate = [NSDate date];
}

- (void)invalidate {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerStart {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    [self timerActionWithTimeInterval:(NSInteger)(deltaTime + 0.5)];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInterval {
    self.timeInterval = timeInterval;
    !self.timerBlock ?: self.timerBlock(timeInterval);
}

#pragma mark - Notification

- (void)beginMonitorgNotification {
    [self endMonitorgNotification];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationDidEnterBackground:)
                          name:UIApplicationDidEnterBackgroundNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(yybb_applicationWillEnterForegroundNotification:)
                          name:UIApplicationWillEnterForegroundNotification
                        object:nil];
    
}

- (void)endMonitorgNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter removeObserver:self
                             name:UIApplicationDidEnterBackgroundNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:UIApplicationWillEnterForegroundNotification
                           object:nil];
}

- (void)yybb_applicationDidEnterBackground:(NSNotification *)notification {
    [self invalidate];
}

- (void)yybb_applicationWillEnterForegroundNotification:(NSNotification *)notification {    
    [_timer invalidate];
    [self startTimer];
}

#pragma mark - Dealloc

- (void)dealloc {
    [self endMonitorgNotification];
}


@end

