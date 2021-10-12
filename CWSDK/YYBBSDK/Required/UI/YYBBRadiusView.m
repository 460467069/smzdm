//
//  RadiusView.m
//  
//
//  Created by Wang_ruzhou on 2018/3/10.
//  Copyright © 2018年 ZeroDistance. All rights reserved.
//

#import "YYBBRadiusView.h"

@implementation YYBBStrokeLabel

- (void)drawTextInRect:(CGRect)rect {
    if (self.strokeWidth > 0) {
        CGSize shadowOffset = self.shadowOffset;
        UIColor *textColor = self.textColor;
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        //画外边
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [super drawTextInRect:rect];
        //画内文字
        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = textColor;
        self.shadowOffset = CGSizeMake(0, 0);
        [super drawTextInRect:rect];
        self.shadowOffset = shadowOffset;
    } else {
        [super drawTextInRect:rect];
    }
}

@end


@implementation YYBBStrokeButton

- (void)drawRect:(CGRect)rect {
    if (self.strokeWidth > 0) {
        CGSize shadowOffset = self.titleLabel.shadowOffset;
        UIColor *textColor = self.titleLabel.textColor;
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        //画外边
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        [self setTitleColor:self.strokeColor forState:UIControlStateNormal];
        [super drawRect:rect];
        //画内文字
        CGContextSetTextDrawingMode(c, kCGTextFill);
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.shadowOffset = CGSizeMake(0, 0);
        [super drawRect:rect];
        self.titleLabel.shadowOffset = shadowOffset;
    } else {
        [super drawRect:rect];
    }
}


@end
