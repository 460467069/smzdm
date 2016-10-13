//
//  LEOStarView.m
//  StarView
//
//  Created by leoliu on 16/1/22.
//  Copyright © 2016年 leoliu. All rights reserved.
//

#import "LEOStarView.h"

static CGFloat kTotalScore = 10.;
static NSUInteger kDefaultCount = 5;
static CGFloat kMargin = 2.0;

@implementation LEOStarView

- (instancetype)initWithStarImage:(UIImage *)starImage{
    
    LEOStarView *starView = [[LEOStarView alloc] init];
    starView.starImage = starImage;
    starView.width = 5 * starImage.size.width + 4 * kMargin;
    starView.height = starImage.size.height;
    
    return starView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat width = self.starImage.size.width;
    CGFloat height = self.starImage.size.height;
    
    for (int i = 0; i < self.starCount; i++) {
        CGRect starRect = CGRectMake(i * (width + kMargin), 0, width, height);
        [self.starImage drawInRect:starRect];
    }
    
    [self.starBackgroundColor set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    CGRect newRect = CGRectZero;
    if (self.markType == EMarkTypeInteger) {
        newRect = CGRectMake(0, 0, self.currentIndex * (width + kMargin), height);
    } else {
        newRect = CGRectMake(0, 0, self.currentPercent * width, height);
    }
    [self.starFrontColor set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.starImage.size.width;
    
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == EMarkTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / (width + kMargin));
        } else {
            self.currentIndex = ceilf(xPoint / (width + kMargin));
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.starImage.size.width;
    
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == EMarkTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / (width + kMargin));
        } else {
            self.currentIndex = ceilf(xPoint / (width + kMargin));
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.markComplete) {
        if (self.markType == EMarkTypeInteger) {
            if (self.currentIndex > self.starCount) {
                self.currentIndex = self.starCount;
            }
            self.currentIndex = self.currentIndex > self.starCount ? self.starCount : self.currentIndex;
            self.markComplete(self.currentIndex * self.totalScore / self.starCount);
        } else {
            self.currentPercent = self.currentPercent > 1. ? 1. : self.currentPercent;
            self.currentPercent = self.currentPercent < 0. ? 0. : self.currentPercent;
            self.markComplete(self.currentPercent * self.totalScore);
        }
    }
    [self setNeedsDisplay];
}

#pragma mark - lazy

- (NSUInteger)starCount
{
    if (_starCount <= 0) {
        _starCount = kDefaultCount;
    }
    return _starCount;
}

- (CGFloat)totalScore
{
    if (_totalScore <= 0.001) {
        _totalScore = kTotalScore;
    }
    return _totalScore;
}

- (UIImage *)starImage
{
    if(!_starImage)
    {
        _starImage = [UIImage imageNamed:@"star_red"];
    }
    return _starImage;
}

- (UIColor *)starBackgroundColor
{
    if(!_starBackgroundColor)
    {
        _starBackgroundColor = [UIColor whiteColor];
    }
    return _starBackgroundColor;
}

- (UIColor *)starFrontColor
{
    if(!_starFrontColor)
    {
        _starFrontColor = [UIColor orangeColor];
    }
    return _starFrontColor;
}


@end
