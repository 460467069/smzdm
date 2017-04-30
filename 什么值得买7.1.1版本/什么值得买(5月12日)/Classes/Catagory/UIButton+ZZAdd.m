//
//  UIButton+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UIButton+ZZAdd.h"


@implementation UIButton (ZZAdd)
+ (UIButton *)opt_buttonWithFrame:(CGRect)rect target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12]];
    [[button layer] setBorderWidth:1];
    [[button layer] setBorderColor:[UIColor whiteColor].CGColor];;
    [[button layer] setCornerRadius:CGRectGetHeight(rect) / 2];
    [[button layer] setMasksToBounds:YES];
    return button;
}

+ (UIButton *)opt_titleButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:[UIColor opt_tintColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor opt_grayColor] forState:UIControlStateHighlighted];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)yj_createButton:(CGRect)frame
                    buttonTag:(NSInteger)bTag
                  buttonTitle:(NSString *)title
             buttonTitleColor:(UIColor *)tColor
              buttonTitleFont:(UIFont *)aFont
                       target:(id)target
                     selector:(SEL)action {
    UIButton *button = [self yj_createButton:frame
                                   buttonTag:bTag
                                      target:target
                                    selector:action];
    button = [self yj_button:button
                 buttonTitle:title
            buttonTitleColor:tColor
             buttonTitleFont:aFont];
    return button;
}

+ (UIButton *)yj_createButton:(CGRect)frame
                    buttonTag:(NSInteger)bTag
                       target:(id)target
                     selector:(SEL)action {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = bTag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*  设置按钮的标题、标题颜色、标题字体 */
+ (UIButton *)yj_button:(UIButton *)button
            buttonTitle:(NSString *)title
       buttonTitleColor:(UIColor *)tColor
        buttonTitleFont:(UIFont *)aFont {
    [button setTitle:title forState:UIControlStateNormal];
    if (tColor) {
        [button setTitleColor:tColor forState:UIControlStateNormal];
    }
    if (aFont) {
        button.titleLabel.font = aFont;
    }
    return button;
}

+ (UIButton *)yj_createButton:(CGRect)frame
                    buttonTag:(NSInteger)bTag
                  buttonImage:(UIImage *)buttonImage
       buttonHighlightedImage:(nullable UIImage *)buttonHighlightedImage
                       target:(id)target
                     selector:(SEL)action {
    UIButton *button = [self yj_createButton:frame
                                   buttonTag:bTag
                                      target:target
                                    selector:action];
    if (buttonImage) {
        [button setImage:buttonImage forState:UIControlStateNormal];
    }
    if (buttonHighlightedImage) {
        [button setImage:buttonHighlightedImage forState:UIControlStateHighlighted];
    }
    return button;
}

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    if (labelWidth == 0) {
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        labelWidth  = titleSize.width;
    }
    
    CGFloat imageInsetsTop = 0.0f;
    CGFloat imageInsetsLeft = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight = 0.0f;
    
    CGFloat titleInsetsTop = 0.0f;
    CGFloat titleInsetsLeft = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight = 0.0f;
    
    switch (style) {
        case ButtonEdgeInsetsStyleImageRight:
        {
            space = space * 0.5;
            
            imageInsetsLeft = labelWidth + space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = - (imageViewWidth + space);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case ButtonEdgeInsetsStyleImageLeft:
        {
            space = space * 0.5;
            
            imageInsetsLeft = -space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = space;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
        case ButtonEdgeInsetsStyleImageBottom:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5 - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
            
        }
            break;
        case ButtonEdgeInsetsStyleImageTop:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5 - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}
@end
