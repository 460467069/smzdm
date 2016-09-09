//
//  HMCycleScrollView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMCycleScrollView.h"
#import <AVFoundation/AVFoundation.h>

@implementation HMCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup{
    self.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.pageDotColor = [UIColor whiteColor];
    self.currentPageDotColor = [UIColor redColor];
    self.placeholderImage = [UIImage imageNamed:@"banner_bg"];
}

@end
