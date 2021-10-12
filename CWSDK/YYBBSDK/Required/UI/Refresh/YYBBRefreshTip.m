//
//  YYBBRefreshTip.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBRefreshTip.h"
#import "YYBBUtilsMacro.h"
#import <YYCategories/NSArray+YYAdd.h>

@implementation YYBBRefreshTip

+ (NSString *)randomRefreshTip {
    
    NSString *file     = [YYBBSDKBundle() pathForResource:@"SMZDMRefreshTips.geojson" ofType:nil];
    NSData *data       = [NSData dataWithContentsOfFile:file];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array     = dict[@"fresh_tips"];
    return [array randomObject];
}
@end
