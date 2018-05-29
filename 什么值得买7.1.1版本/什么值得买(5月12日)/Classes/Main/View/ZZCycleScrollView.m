//
//  ZZCycleScrollView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZCycleScrollView.h"
@implementation ZZCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.pageDotColor = [UIColor whiteColor];
    self.currentPageDotColor = [UIColor redColor];
    self.placeholderImage = [UIImage imageNamed:@"banner_bg"];
    self.autoScrollTimeInterval = 5.0;
//    self.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
}

@end
