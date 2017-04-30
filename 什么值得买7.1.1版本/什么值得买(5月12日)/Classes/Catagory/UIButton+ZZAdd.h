//
//  UIButton+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN



@interface UIButton (ZZAdd)

/**
 *  椭圆形的按钮
 */
+ (UIButton *)opt_buttonWithFrame:(CGRect)rect target:(id)target action:(SEL)action title:(NSString *)title;


+ (UIButton *)opt_titleButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  创建button
 *
 *  @param frame      位置
 *  @param bTag       tag
 *  @param title      标题
 *  @param tColor     标题颜色
 *  @param aFont      标题字体
 *  @param target     target对象
 *  @param action   action selector
 *
 *  @return button对象
 */

+ (UIButton *)yj_createButton:(CGRect)frame
                    buttonTag:(NSInteger)bTag
                  buttonTitle:(nullable NSString *)title
             buttonTitleColor:(UIColor *)tColor
              buttonTitleFont:(UIFont *)aFont
                       target:(nullable id)target
                     selector:(nullable SEL)action;

+ (UIButton *)yj_createButton:(CGRect)frame
                    buttonTag:(NSInteger)bTag
                  buttonImage:(nullable UIImage *)buttonImage
       buttonHighlightedImage:(nullable UIImage *)buttonHighlightedImage
                       target:(id)target
                     selector:(SEL)action;

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
