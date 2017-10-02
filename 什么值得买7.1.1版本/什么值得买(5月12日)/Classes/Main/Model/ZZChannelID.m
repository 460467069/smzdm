//
//  ZZChannelID.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/1.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZChannelID.h"

@implementation ZZChannelID


+ (instancetype)channelWithID:(NSInteger)index {
    
    NSArray<ZZChannelID *> *channelIDs = [self mj_objectArrayWithFilename:@"ZZCHannelID.plist"];
    
    if (index >= channelIDs.count) {
        return channelIDs[0];
    }
	
    return channelIDs[index];
}
@end
