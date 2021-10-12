//
//  UIImageView+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 6/17/19.
//

#import "UIButton+YYBBAdd.h"
#import "NSString+YYBBAdd.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation UIButton (YYBBAdd)

- (void)yybb_setImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state {
    NSURL *url = [NSURL URLWithString:[urlStr yybb_stringByURLEncode]];
    
    [self sd_setImageWithURL:url forState:state];
}

- (void)yybb_setImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state placeholderImage:(nullable UIImage *)placeholder {
    NSURL *url = [NSURL URLWithString:[urlStr yybb_stringByURLEncode]];
    [self sd_setImageWithURL:url forState:state placeholderImage:placeholder];
}

- (void)yybb__setBackgroundImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state {
    NSURL *url = [NSURL URLWithString:[urlStr yybb_stringByURLEncode]];
    [self sd_setBackgroundImageWithURL:url forState:state];
}

- (void)yybb__setBackgroundImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state placeholderImage:(nullable UIImage *)placeholder {
    NSURL *url = [NSURL URLWithString:[urlStr yybb_stringByURLEncode]];
    [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius
                       borderWidth:(CGFloat)borderWidth
                       borderColor:(UIColor *)borderColor
                             title:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    button.backgroundColor = backgroundColor;
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        
    }
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        if (title.length) {
            
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        }
    }
    
    if (cornerRadius > 0) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = borderColor.CGColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:imageName
                               titleColor:titleColor
                                titleFont:titleFont
                          backgroundColor:backgroundColor
                             cornerRadius:0
                              borderWidth:0
                              borderColor:nil
                                    title:title];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                             title:(NSString *)title {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:imageName
                               titleColor:titleColor
                                titleFont:titleFont
                          backgroundColor:nil
                             cornerRadius:0
                              borderWidth:0
                              borderColor:nil
                                    title:title];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                             title:(NSString *)title {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:nil
                               titleColor:titleColor
                                titleFont:titleFont
                          backgroundColor:nil
                             cornerRadius:0
                              borderWidth:0
                              borderColor:nil
                                    title:title];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:nil
                               titleColor:titleColor
                                titleFont:titleFont
                          backgroundColor:backgroundColor
                             cornerRadius:0
                              borderWidth:0
                              borderColor:nil
                                    title:title];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName
                      cornerRadius:(CGFloat)cornerRadius
                       borderWidth:(CGFloat)borderWidth
                       borderColor:(UIColor *)borderColor {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:imageName
                               titleColor:nil
                                titleFont:0
                          backgroundColor:nil
                             cornerRadius:cornerRadius
                              borderWidth:borderWidth
                              borderColor:borderColor
                                    title:nil];
}

+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName {
    
    return [UIButton yybb_buttonWithTarget:target
                                   action:action
                                    frame:frame
                                imageName:imageName
                               titleColor:nil
                                titleFont:0
                          backgroundColor:nil
                             cornerRadius:0
                              borderWidth:0
                              borderColor:nil
                                    title:nil];
    
}

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片的文字
 *  @param spacing           图片与文字之间的间距
 */
- (void)yybb_imagePositionStyle:(YYBBImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing {
    if (imagePositionStyle == YYBBImagePositionStyleDefault) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        } else {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
        }
    } else if (imagePositionStyle == YYBBImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + spacing, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, 0, 0);
        } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - titleW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + spacing);
        } else {
            CGFloat imageOffset = titleW + 0.5 * spacing;
            CGFloat titleOffset = imageW + 0.5 * spacing;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
        }
    } else if (imagePositionStyle == YYBBImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == YYBBImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }
}


/**
 *  设置图片与文字样式（推荐使用）
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 *  @param imagePositionBlock     在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)yybb_imagePositionStyle:(YYBBImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock {

    imagePositionBlock(self);
    
    if (imagePositionStyle == YYBBImagePositionStyleDefault) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        } else {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
        }
    } else if (imagePositionStyle == YYBBImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + spacing, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, 0, 0);
        } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - titleW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + spacing);
        } else {
            CGFloat imageOffset = titleW + 0.5 * spacing;
            CGFloat titleOffset = imageW + 0.5 * spacing;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
        }
    } else if (imagePositionStyle == YYBBImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == YYBBImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }
}



@end
