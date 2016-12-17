//
//  ZZJumpToNextModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/20.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZJumpToNextModel.h"

@implementation ZZJumpToNextModel

+ (instancetype)modelWithLinkType:(NSString *)linkType{
    
    for (ZZJumpToNextModel *model in [self models]) {
        
        if ([model.linkType isEqualToString:linkType]) {
            
            return model;
        }
    }
    
    return nil;
    
    
}

+ (instancetype)modelWithChannelID:(NSInteger)channelID{
    
    for (ZZJumpToNextModel *model in [self models]) {
        
        if (model.channelID == channelID) {
            
            return model;
        }
    }

    return nil;
}




+ (NSArray<ZZJumpToNextModel *> *)models{

    NSArray *array = [self mj_objectArrayWithFilename:@"JumpToNext.plist"];
    
    return array;
}

@end
