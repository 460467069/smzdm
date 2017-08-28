//
//  NSDate+ZDTime.m
//  ZeroDistanceSeller
//
//  Created by Wang_ruzhou on 2017/7/18.
//  Copyright © 2017年 ZeroDistance. All rights reserved.
//

#import "NSDate+ZDTime.h"

@implementation NSDate (ZDTime)
+ (void)load
{
    /** 获取原始date方法 */
    Method originalM = class_getInstanceMethod([self class], @selector(date));
    
    /** 获取自定义的newDate方法 */
    Method exchangeM = class_getInstanceMethod([self class], @selector(newDate));
    
    /** 交换方法 */
    method_exchangeImplementations(originalM, exchangeM);
}

/** 自定义的方法 */
+(instancetype)newDate {
    
    return [self newDate];
}

@end
