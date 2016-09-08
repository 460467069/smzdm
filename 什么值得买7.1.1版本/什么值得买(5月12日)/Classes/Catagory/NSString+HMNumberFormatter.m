//
//  NSString+HMNumberFormatter.m
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "NSString+HMNumberFormatter.h"

@implementation NSString (HMNumberFormatter)


+ (NSString *)stringFromFloat:(CGFloat )value {
    
    NSNumber *number = [NSNumber numberWithFloat:value];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    
    return [formatter stringFromNumber:number];
    
    
}

@end
