//
//  NSArray+YYBBMap.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import "NSArray+YYBBMap.h"
#import "NSArray+YYBBAdd.h"

@implementation NSArray (YYBBMap)

- (NSArray *)yybb_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj, idx)) {
            [result addObject:block(obj, idx)];
        }
    }];
    return result;
}

@end
