//
//  NSArray+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import "NSArray+YYBBAdd.h"
#import <YYCategories/NSString+YYAdd.h>
#import "YYBBSDK.h"

@implementation NSArray (YYBBAdd)

- (NSDictionary *)signParameters {
    NSMutableString *strs = [NSMutableString string];
    [self enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [strs appendString:obj];
        } else {
            NSString *str = [NSString stringWithFormat:@"%@", obj];
            [strs appendString:str];
        }
    }];
    NSString *salt = [YYBBSDK sharedInstance].config.appKey;
    [strs appendString:salt];
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionary];
    newParameters[@"sign"] = [strs md5String];
    return [newParameters copy];
}

- (NSDictionary *)signParametersWithCustomSalt:(NSString *)salt {
    NSMutableString *strs = [NSMutableString string];
    [self enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [strs appendString:obj];
        } else {
            NSString *str = [NSString stringWithFormat:@"%@", obj];
            [strs appendString:str];
        }
    }];
    [strs appendString:salt];
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionary];
    newParameters[@"sign"] = [strs md5String];
    return [newParameters copy];
}

+ (id)arrayWithObjectSafe:(id)anObject {
    if (!anObject) {
        return nil;
    }
    return [self arrayWithObject:anObject];
}

- (id)objectAtIndexSafe:(NSUInteger)uindex {
    NSInteger index = uindex;
    if (index < 0 || index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (NSArray *)arrayByAddingObjectSafe:(id)anObject {
    if (!anObject) {
        return [self copy];
    }
    return [self arrayByAddingObject:anObject];
}

@end


@implementation NSMutableArray (YYBBSafe)

- (void)addObjectSafe:(id)anObject {
    if (!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)insertObjectSafe:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        return;
    }
    if (index >= self.count) {
        [self addObjectSafe:anObject];
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)replaceObjectAtIndexSafe:(NSUInteger)uindex withObject:(id)anObject {
    if (!anObject) {
        return;
    }
    NSInteger index = uindex;
    if (index < 0 || index >= self.count) {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)removeObjectAtIndexSafe:(NSUInteger)uindex {
    NSInteger index = uindex;
    if (index < 0 || index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

@end
