//
//  YYBBSmsCodeTextField.m
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 11/12/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBSmsCodeTextField.h"

@implementation YYBBSmsCodeTextField

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
    [self.formatter setDefaultOutputPattern:@"####"];
}


@end
