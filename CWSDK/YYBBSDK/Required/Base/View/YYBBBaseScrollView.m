//
//  YYBBBaseScrollView.m
//  
//
//  Created by Wang_Ruzhou on 9/17/19.
//  Copyright © 2019 Wang_ruzhou. All rights reserved.
//

#import "YYBBBaseScrollView.h"

@implementation YYBBBaseScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self yybb_setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self yybb_setup];
}

- (void)yybb_setup {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

@end

