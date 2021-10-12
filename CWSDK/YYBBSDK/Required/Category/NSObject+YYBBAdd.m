//
//  NSObject+YYBBAdd.m
//  DaDongMen
//
//  Created by WangRuzhou on 3/23/15.
//  Copyright (c) 2015 Optimus Prime Information Technology Co., Ltd. All rights reserved.
//

#import "NSObject+YYBBAdd.h"
#import <YYModel/YYModel.h>

@implementation NSObject (YYBBAdd)

- (BOOL)yybb_isNotEmpty {
    return ![self yybb_isEmpty];
}

- (BOOL)yybb_isEmpty {
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

// 模型拷贝
- (instancetype)yybb_copy {
    id data = [self yy_modelToJSONObject];
    id a = [[self class] yy_modelWithJSON:data];
    return [[self class] yy_modelWithJSON:data];
}

@end
