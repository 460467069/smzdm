//
//  NSObject+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/3/6.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "NSObject+ZZAdd.h"

@implementation NSObject (ZZAdd)
- (BOOL)zz_isEmpty {
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return [[(NSString *)self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] <= 0;
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSSet class]]) {
        return [(NSSet *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSData class]]) {
        return [(NSData *)self length] <= 0;
    }
    
    return NO;
}
@end
