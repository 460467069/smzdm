//
//  UIView+Badge.m
//  WeiYiMei
//
//  Created by 李叶夫 on 2019/6/23.
//  Copyright © 2019年 liyefu. All rights reserved.
//

#import "UIView+YYBBBadge.h"
#import "UIView+YYBBAdd.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) UILabel *badgeLab;

@end

@implementation UIView (Badge)


- (void)updateValue
{
    if (self.showDot.boolValue) {
        if (self.badgeLab) {
            self.badgeLab.text = nil;
        }
        else {
            self.badgeLab = [[UILabel alloc] init];
            self.badgeLab.backgroundColor = [UIColor redColor];
            self.badgeLab.font = [UIFont systemFontOfSize:10];
            self.badgeLab.textAlignment = NSTextAlignmentCenter;
            self.badgeLab.textColor = [UIColor whiteColor];
            self.badgeLab.userInteractionEnabled = NO;
            [self addSubview:self.badgeLab];
        }
        [self updateBadgeFrame];
    }
    else {
        if (self.badgeValue == nil || self.badgeValue.length == 0 || [self.badgeValue isEqualToString:@"0"]) {
            [self removeBadge];
        }
        else if (!self.badgeLab) {
            self.badgeLab = [[UILabel alloc] init];
            self.badgeLab.backgroundColor = [UIColor redColor];
            self.badgeLab.font = [UIFont systemFontOfSize:13];
            self.badgeLab.textAlignment = NSTextAlignmentCenter;
            self.badgeLab.textColor = [UIColor whiteColor];
            self.badgeLab.userInteractionEnabled = NO;
            [self addSubview:self.badgeLab];
            if (self.showDot.boolValue == false) {
                self.badgeLab.text = self.badgeValue.intValue > 99 ? @"99+" : self.badgeValue;
            }
            [self updateBadgeFrame];
        }
        else {
            if (self.showDot.boolValue == false) {
                self.badgeLab.text = self.badgeValue.intValue > 99 ? @"99+" : self.badgeValue;
            }
            [self updateBadgeFrame];
        }
    }
    
}

- (void)removeBadge
{
    [self.badgeLab removeFromSuperview];
    self.badgeLab = nil;
}

- (void)updateBadgeFrame
{
    if (self.showDot.boolValue) {
        self.badgeLab.text = nil;
        CGRect frame = CGRectMake(self.badgeOriginX.floatValue, self.badgeOriginY.floatValue, 10, 10);
        self.badgeLab.frame = frame;
        self.badgeLab.layer.cornerRadius = 5;
        self.badgeLab.layer.masksToBounds = YES;
    }
    else {
        CGSize size = [self.badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
        UIEdgeInsets inset = UIEdgeInsetsMake(4, 4, 4, 4);
        CGFloat w = size.width+inset.left+inset.right;
        CGFloat h = size.height+inset.top+inset.bottom;
        w = MAX(w, h);
        CGRect frame = CGRectMake(self.badgeOriginX.floatValue, self.badgeOriginY.floatValue, w, h);
        self.badgeLab.frame = frame;
        self.badgeLab.layer.cornerRadius = self.badgeLab.frame.size.height/2.0;
        self.badgeLab.layer.masksToBounds = YES;
        self.badgeLab.borderColor = [UIColor whiteColor];
        self.badgeLab.borderWidth = 1;
    }
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, @selector(badgeValue), badgeValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self updateValue];
}

- (NSString *)badgeValue
{
    return objc_getAssociatedObject(self, @selector(badgeValue));
}

- (void)setBadgeLab:(UILabel *)badgeLab
{
    objc_setAssociatedObject(self, @selector(badgeLab), badgeLab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLab
{
    return objc_getAssociatedObject(self, @selector(badgeLab));
}

- (void)setBadgeOriginX:(NSNumber *)badgeOriginX
{
    objc_setAssociatedObject(self, @selector(badgeOriginX), badgeOriginX, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBadgeFrame];
}

- (NSNumber *)badgeOriginX
{
    return objc_getAssociatedObject(self, @selector(badgeOriginX));
}

- (void)setBadgeOriginY:(NSNumber *)badgeOriginY
{
    objc_setAssociatedObject(self, @selector(badgeOriginY), badgeOriginY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBadgeFrame];
}

- (NSNumber *)badgeOriginY
{
    return objc_getAssociatedObject(self, @selector(badgeOriginY));
}

- (void)setShowDot:(NSNumber *)showDot
{
    objc_setAssociatedObject(self, @selector(showDot), showDot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateValue];
}

- (NSNumber *)showDot
{
    return objc_getAssociatedObject(self, @selector(showDot));
}


@end
