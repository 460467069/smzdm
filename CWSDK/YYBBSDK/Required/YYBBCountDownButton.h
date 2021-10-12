//
//  YYBBCountDownButton.h
//
//
//  Created by Wang_ruzhou on 2017/4/10.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYBBCountDownButton;
typedef NSString* (^CountDownChanging)(YYBBCountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(YYBBCountDownButton *countDownButton, NSUInteger second);
typedef void(^TouchedCountDownButtonHandler)(YYBBCountDownButton *countDownButton, NSUInteger tag);

@interface YYBBCountDownButton : UIButton

// 倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
// 倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
// 倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
// 开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
// 停止倒计时
- (void)stopCountDown;

@end
