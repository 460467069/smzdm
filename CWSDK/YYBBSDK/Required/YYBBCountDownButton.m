//
//  YYBBCountDownButton.m
//  
//
//  Created by Wang_ruzhou on 2017/4/10.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBCountDownButton.h"
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/NSTimer+YYAdd.h>
#import <YYText/YYTextWeakProxy.h>
#import "UIColor+YYBBAdd.h"
#import "UIView+YYBBAdd.h"
#import "YYBBUtilities.h"

@interface YYBBCountDownButton () {
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YYBBCountDownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        self.cornerRadius = 4;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor yybb_lightGrayColor] forState:UIControlStateDisabled];
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        self.cornerRadius = 15;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor yybb_lightGrayColor] forState:UIControlStateDisabled];
    }
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor yybb_themeColor2]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor yybb_grayScaleBgColor]] forState:UIControlStateDisabled];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.borderColor = [UIColor clearColor];
        self.borderWidth = 0;
    } else {
        self.borderColor = UIColorHex(CCCCCC);
        self.borderWidth = 0.5;
    }
}

#pragma -mark touche action

- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(YYBBCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method

- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    [_timer invalidate];
    
    _timer = [NSTimer timerWithTimeInterval:1.0
                                     target:[YYTextWeakProxy proxyWithTarget:self]
                                   selector:@selector(timerStart)
                                   userInfo:nil
                                    repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    if (_second<= 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = _countDownChanging(self,_second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}

@end
