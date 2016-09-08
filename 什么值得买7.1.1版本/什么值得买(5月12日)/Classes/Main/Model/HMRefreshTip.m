//
//  HMRefreshTip.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMRefreshTip.h"

@implementation HMRefreshTip

+ (NSString *)randomRefreshTip{
    
    NSData *data = [NSData dataNamed:@"RefreshTips.geojson"];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *array = dict[@"fresh_tips"];
    
    
    return [array randomObject];
    
    
}
@end
