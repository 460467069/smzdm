//
//  YYBBSeparatorView.m
//
//
//  Created by Wang_ruzhou on 2018/3/10.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "YYBBSeparatorView.h"
#import "UIColor+YYBBAdd.h"

@implementation YYBBSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    self.backgroundColor = [UIColor yybb_grayScaleBgColor];
}

@end
