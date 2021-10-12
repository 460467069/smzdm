//
//  NSJSONSerialization+YYBBAdd.m
//  YYCardBoard
//
//  Created by 李叶夫 on 2020/12/22.
//  Copyright © 2020 Wang_Ruzhou. All rights reserved.
//

#import "NSJSONSerialization+YYBBAdd.h"
#import <objc/runtime.h>

@implementation NSJSONSerialization (YYBBAdd)

+ (void)load {
    SEL origSel = @selector(JSONObjectWithData:options:error:);
    SEL newSel = @selector(YYBBJSONObjectWithData:options:error:);
    Method origMethod = class_getClassMethod([self class], origSel);
    Method newMethod = class_getClassMethod([self class], newSel);
    method_exchangeImplementations(origMethod, newMethod);
}

+ (nullable id)YYBBJSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    if (data.length == 0 || !data) {
        return nil;
    }
    id res = [self YYBBJSONObjectWithData:data options:opt error:error];
    return res;
}

@end
