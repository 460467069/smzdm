//
//  ZZDetailTopicContentLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZDetailTopicContentLayout.h"

@implementation ZZDetailTopicContentLayout


- (instancetype)initWithContentDetailModel:(ZZDetailTopicModel *)detailTopicModel {
    if (!detailTopicModel) {
        return nil;
    }
    
    if (self = [super init]) {
        _detailTopicModel = detailTopicModel;
        [self layout];
    }
    return self;
}


- (void)layout {
	
//    _titleLayout
    
}
@end
