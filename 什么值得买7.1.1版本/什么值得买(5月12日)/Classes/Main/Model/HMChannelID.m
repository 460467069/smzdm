//
//  HMChannelID.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMChannelID.h"

@implementation HMChannelID


+ (instancetype)channelWithID:(NSInteger)index{
    
    NSArray<HMChannelID *> *channelIDs = [self mj_objectArrayWithFilename:@"HMCHannelID.plist"];
    
    if (index >= channelIDs.count) {
        return channelIDs[0];
    }
	
    return channelIDs[index];
}
@end
