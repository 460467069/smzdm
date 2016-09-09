//
//  HMDetailBottomBar.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailBottomBar.h"

@implementation HMDetailBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = 44;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
@end
