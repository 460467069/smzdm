//
//  YYBBPlaceholderTextView.m
//
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBPlaceholderTextView.h"
#import "NSString+YYBBAdd.h"

@implementation YYBBPlaceholderTextView


- (void)dealloc {
    [self removeTextViewNotificationObservers];
    _placeholder = nil;
    _placeholderTextColor = nil;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self configureTextView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureTextView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configureTextView];
    }
    return self;
}

- (void)configureTextView {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:15.0f];
    self.contentMode = UIViewContentModeRedraw;
    self.text = nil;
    
    _placeholder = nil;
    _placeholderTextColor = [UIColor lightGrayColor];
    _placeholderOffset = CGPointMake(7.f, 5.f);
    
    [self addTextViewNotificationObservers];
}

- (BOOL)hasText {
    return ([[self.text yybb_stringByTrimingWhitespace] length] > 0);
}

#pragma mark - Setters

- (void)setPlaceholder:(NSString *)placeHolder {
    if ([placeHolder isEqualToString:_placeholder]) {
        return;
    }
    
    _placeholder = [placeHolder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeHolderTextColor {
    if ([placeHolderTextColor isEqual:_placeholderTextColor]) {
        return;
    }
    
    _placeholderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

- (void)setPlaceholderOffset:(CGPoint)placeholderOffset {
    if (CGPointEqualToPoint(placeholderOffset, _placeholderOffset)) {
        return;
    }
    
    _placeholderOffset = placeholderOffset;
    [self setNeedsDisplay];
}

#pragma mark - UITextView overrides

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if ([self.text length] == 0 && self.placeholder) {
        [self.placeholderTextColor set];
        
        [self.placeholder drawInRect:CGRectInset(rect, self.placeholderOffset.x, self.placeholderOffset.y)
                      withAttributes:[self placeholderTextAttributes]];
    }
}

#pragma mark - Notifications

- (void)addTextViewNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)removeTextViewNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
}

- (void)didReceiveTextViewNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - Utilities

- (NSDictionary *)placeholderTextAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    
    return @{ NSFontAttributeName : self.font,
              NSForegroundColorAttributeName : self.placeholderTextColor,
              NSParagraphStyleAttributeName : paragraphStyle };
}

@end
