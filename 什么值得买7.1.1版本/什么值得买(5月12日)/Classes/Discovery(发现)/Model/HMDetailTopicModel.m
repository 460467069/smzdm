//
//  HMDetailTopicModel.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailTopicModel.h"

@implementation HMDetailTopicModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comment_pic_list" : [HMCommentPicList class]};
    
}

@end


@implementation HMCommentPicList

@end


