//
//  ZZTableView.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/6/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZWeiboTableView.h"

@implementation ZZWeiboTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //Remove touch delay (since iOS 8)
        UIView *wrapView = self.subviews.firstObject;
        
        if (wrapView && [NSStringFromClass(wrapView.class) hasPrefix:@"WrapperView"]) {
            
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"]) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    
    if ([view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
