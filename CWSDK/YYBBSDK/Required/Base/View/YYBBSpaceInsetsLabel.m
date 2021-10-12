//
//  YYBBSpaceInsetsLabel.m
//  PPLiveMerchant
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBSpaceInsetsLabel.h"
#import <CoreText/CoreText.h>

static inline CTTextAlignment CTTextAlignmentFromNSTextAlignment(NSTextAlignment alignment) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    switch (alignment) {
        case NSTextAlignmentLeft: return kCTLeftTextAlignment;
        case NSTextAlignmentCenter: return kCTCenterTextAlignment;
        case NSTextAlignmentRight: return kCTRightTextAlignment;
        default: return kCTNaturalTextAlignment;
    }
#else
    switch (alignment) {
        case UITextAlignmentLeft: return kCTLeftTextAlignment;
        case UITextAlignmentCenter: return kCTCenterTextAlignment;
        case UITextAlignmentRight: return kCTRightTextAlignment;
        default: return kCTNaturalTextAlignment;
    }
#endif
}

@implementation YYBBSpaceInsetsLabel

- (void)drawRect:(CGRect)rect {
    if (!self.text || self.text.length == 0 || (self.linesSpacing == 0 && self.characterSpacing == 0)) {
        [super drawRect:rect];
        return;
    }
    NSString *newString = [self.text stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newString];
    
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[attributedString length])];
    CFRelease(helveticaBold);
    
    //设置字体颜色
    [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0, [attributedString length])];
    
    //设置字间距
    if(self.characterSpacing) {
        long number = self.characterSpacing;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
        if ([newString hasSuffix:@":"] || [newString hasSuffix:@"："]) {
            [attributedString addAttribute:(NSString *)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedString length] - 2)];
        }
        else {
            [attributedString addAttribute:(NSString *)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedString length] - 1)];
        }
        CFRelease(num);
    }
    
    //创建文本对齐方式
    CTTextAlignment alignment = CTTextAlignmentFromNSTextAlignment(self.textAlignment);
    //创建设置数组
    CTParagraphStyleSetting settings[] = {
        {.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void *)&alignment}
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0, [attributedString length])];
    CFRelease(style);
    
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    CTFrameDraw(leftFrame,context);
    CFRelease(leftFrame);
    UIGraphicsPushContext(context);
}

#pragma mark-  Custom Access

- (void)setCharacterSpacing:(CGFloat)characterSpacing {
    if (_characterSpacing != characterSpacing) {
        _characterSpacing = characterSpacing;
        [self setNeedsDisplay];
    }
}

- (void)setLinesSpacing:(CGFloat)linesSpacing {
    if (_linesSpacing != linesSpacing) {
        _linesSpacing = linesSpacing;
        [self setNeedsDisplay];
    }
}

@end
