//
//  UIButton+ActivityIndicatorView.m
//  
//
//  Created by aazhou on 13-8-13.
//  Copyright (c) 2013 joyotime. All rights reserved.
//

#import "UIButton+ActivityIndicatorView.h"
#import <objc/runtime.h>
#import <YYCategories/UIView+YYAdd.h>

static const char *kOriginalImagePropertyKey = "kOriginalImagePropertyKey";
static const char *kOriginalTitlePropertyKey = "kOriginalTitlePropertyKey";

#define kActivityIndicatorViewTag   9000001

@implementation UIButton (ActivityIndicatorView)

- (void)startAnimation:(UIActivityIndicatorViewStyle)style {
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self viewWithTag:kActivityIndicatorViewTag];
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        indicatorView.hidesWhenStopped = YES;
        indicatorView.tag = kActivityIndicatorViewTag;
        indicatorView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        [self addSubview:indicatorView];
    }
    self.originalTitle = [self titleForState:UIControlStateNormal];
    self.originalImage = [self imageForState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    [self setEnabled:NO];
    [indicatorView startAnimating];
}

- (void)stopAnimation {
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self viewWithTag:kActivityIndicatorViewTag];
    if (indicatorView) {
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
    }
    [self setTitle:self.originalTitle forState:UIControlStateNormal];
    [self setImage:self.originalImage forState:UIControlStateNormal];
    [self setEnabled:YES];
}

#pragma mark - Property

- (void)setOriginalImage:(UIImage *)originalImage {
    objc_setAssociatedObject(self, kOriginalImagePropertyKey, originalImage, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)originalImage {
    return objc_getAssociatedObject(self, kOriginalImagePropertyKey);
}

- (void)setOriginalTitle:(NSString *)originalTitle {
    objc_setAssociatedObject(self, kOriginalTitlePropertyKey, originalTitle, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)originalTitle {
    return objc_getAssociatedObject(self, kOriginalTitlePropertyKey);
}

@end
