//
//  HMHomeChannel.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMHomeChannel.h"

@implementation HMHomeChannel


+ (NSArray *)homeChannels {
    
    return [self mj_objectArrayWithFilename:@"HMZDMHome.plist"];
	
}
@end
