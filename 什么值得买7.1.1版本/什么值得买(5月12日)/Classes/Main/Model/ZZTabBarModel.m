//
//  ZZTabBarModel.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZTabBarModel.h"

@implementation ZZTabBarModel


+ (NSArray *)tabBarModels {
    
    
    //根据mainBundle下的plist文件名转成模型数组
    return [self mj_objectArrayWithFilename:@"UITabBar.plist"];
    
}
@end
