//
//  NSTimer+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/12/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZZTimerBlock)(NSTimer *);

@interface NSTimer (ZZAdd)

@property (nonatomic, copy) ZZTimerBlock block;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *))block;

@end
