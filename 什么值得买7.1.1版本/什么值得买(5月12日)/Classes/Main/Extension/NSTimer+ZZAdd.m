//
//  NSTimer+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "NSTimer+ZZAdd.h"
#import <objc/runtime.h>

static NSString *ZZ_NSTimerKey = @"ZZ_NSTimerKey";

@implementation NSTimer (ZZAdd)


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *))block{
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:self selector:@selector(repeat:) userInfo:userInfo repeats:yesOrNo];
    timer.block = block;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    return timer;
}

+ (void)repeat:(NSTimer *)timer{
    
    if (timer.block) {
        timer.block(timer);
    }
    
}

- (ZZTimerBlock)block{
    
    
    return objc_getAssociatedObject(self, &ZZ_NSTimerKey);
}


- (void)setBlock:(ZZTimerBlock)block{
    
    objc_setAssociatedObject(self, &ZZ_NSTimerKey, block, OBJC_ASSOCIATION_COPY);
}


@end
