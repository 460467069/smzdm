//
//  NSArray+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 2018/8/3.
//  Copyright © 2018年 Wang_ruzhou. All rights reserved.
//

#import "NSPointerArray+YYBBAdd.h"

@implementation NSPointerArray (YYBBAdd)

- (void)addObject:(id)object
{
    [self addPointer:(__bridge void *)object];
}

- (BOOL)containsObject:(id)object
{
    // get passed in object's pointer
    void * objPtr = (__bridge void *)object;
    for (NSUInteger i = 0; i < [self count]; i++) {
        void * ptr = [self pointerAtIndex:i];
        
        if (ptr == objPtr) {
            return YES;
        }
    }
    
    return NO;
}

- (void)removeObject:(id)object
{
    // get pointer to the passed in object
    void * objPtr = (__bridge void *)object;
    int objIndex = -1;
    for (NSUInteger i = 0; i < [self count]; i++) {
        void * ptr = [self pointerAtIndex:i];
        
        if (ptr == objPtr) {
            // pointers equal, found our object!
            objIndex = i;
            break;
        }
    }
    
    // make sure index is non-nil and not outside bounds
    if (objIndex >= 0 && objIndex < [self count]) {
        [self removePointerAtIndex:objIndex];
    }
}

- (void)removeAllNulls
{
    NSMutableSet *indexesToRemove = [NSMutableSet new];
    for (NSUInteger i = 0; i < [self count]; i++) {
        if (![self pointerAtIndex:i]) { // is the pointer null? then remove it
            [indexesToRemove addObject:@(i)];
        }
    }
    
    for (NSNumber *indexToRemove in indexesToRemove) {
        [self removePointerAtIndex:[indexToRemove unsignedIntegerValue]];
    }
}

@end
