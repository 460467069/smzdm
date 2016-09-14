//
//  ZZDetailTopicModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicModel.h"

@implementation ZZDetailTopicModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comment_pic_list" : [ZZCommentPicList class]};
    
}


- (NSString *)use_time{
    
    NSInteger useTime = [_use_time integerValue];
    
    NSString *temStr = nil;
    switch (useTime) {
        case 0:
            temStr = @"没用过";
            break;
        case 1:
            temStr = @"短暂体验";
            break;
        case 2:
            temStr = @"1-3个月";
            break;
        case 3:
            temStr = @"3个月-1年";
            break;
            
        default:
            break;
    }
    
    return temStr;
}

@end


@implementation ZZCommentPicList

@end


