//
//  YYBBTabBarModel.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "YYBBTabBarModel.h"
#import "YYBBUtilsMacro.h"
#import <YYModel/YYModel.h>

@implementation YYBBTabBarModel


+ (NSArray *)tabBarModels {
    //根据mainBundle下的plist文件名转成模型数组
    NSString *file = [YYBBSDKBundle() pathForResource:@"YYBBTabBarModel.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:file];
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
    
}
@end
