//
//  HMDetailBottomBar.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailBottomBar.h"

@interface HMDetailBottomBar ()
@property (nonatomic, assign) DetailBottomBarStyle style;
@property (nonatomic, weak) CALayer *topLineLayer;
@end

@implementation HMDetailBottomBar

+ (instancetype)barWithStyle:(DetailBottomBarStyle)style{
    
    HMDetailBottomBar *bottomBar = [[HMDetailBottomBar alloc] init];
    bottomBar.style = style;
    return bottomBar;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = 44;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *topLineLayer = [CALayer layer];
        topLineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:topLineLayer];
        topLineLayer.height = 0.5;
        topLineLayer.width = self.width;
        
    }
    return self;
}


@end
