//
//  NSArray+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYBBAdd)

- (NSDictionary *)signParameters;
- (NSDictionary *)signParametersWithCustomSalt:(NSString *)salt;

+ (id)arrayWithObjectSafe:(id)anObject;
- (id)objectAtIndexSafe:(NSUInteger)uindex;
- (NSArray *)arrayByAddingObjectSafe:(id)anObject;

@end

@interface NSMutableArray (YYBBSafe)

- (void)addObjectSafe:(id)anObject;
- (void)insertObjectSafe:(id)anObject atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndexSafe:(NSUInteger)index withObject:(id)anObject;
- (void)removeObjectAtIndexSafe:(NSUInteger)index;

@end
