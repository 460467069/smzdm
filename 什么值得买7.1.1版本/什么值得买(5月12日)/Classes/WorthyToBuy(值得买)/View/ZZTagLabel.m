//
//  ZZTagLabel.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZTagLabel.h"

@implementation ZZTagLabel



+ (instancetype)labelWithString:(NSString *)title {
	
    ZZTagLabel *tagLabel = [[self alloc] init];
    tagLabel.text = title;
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.userInteractionEnabled = YES;
    return tagLabel;
}


- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.block) {
        self.block();
    }
}

@end
