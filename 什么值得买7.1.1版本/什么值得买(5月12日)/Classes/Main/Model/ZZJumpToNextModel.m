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
    
    NSArray<ZZJumpToNextModel *> *models = [self mj_objectArrayWithFilename:@"JumpToNext.plist"];
    
    for (ZZJumpToNextModel *model in models) {
        
        if ([model.linkType isEqualToString:linkType]) {
            
            return model;
        }
    }
    
    return nil;
    
    
}

@end
