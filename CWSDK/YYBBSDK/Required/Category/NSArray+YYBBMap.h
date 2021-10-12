//
//  NSArray+YYBBMap.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYBBMap)

- (NSArray *)yybb_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

@end

