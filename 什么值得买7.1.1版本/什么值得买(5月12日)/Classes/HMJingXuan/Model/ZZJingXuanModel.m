//
//  ZZJingXuanModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/31.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZJingXuanModel.h"

@implementation ZZJingXuanModel

+ (NSArray *)models {
    
    
    //根据mainBundle下的plist文件名转成模型数组
    return [self mj_objectArrayWithFilename:@"JingXuan.plist"];
    
}

@end
