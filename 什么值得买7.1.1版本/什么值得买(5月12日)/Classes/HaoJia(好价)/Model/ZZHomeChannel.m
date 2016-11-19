//
//  ZZHomeChannel.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZHomeChannel.h"

@implementation ZZHomeChannel


+ (NSArray *)homeChannels {
    
    return [self mj_objectArrayWithFilename:@"ZDMHome.plist"];
	
}
@end
