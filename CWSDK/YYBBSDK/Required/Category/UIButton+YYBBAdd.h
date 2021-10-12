//
//  UIImageView+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 6/17/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    YYBBImagePositionStyleDefault,
    /// 图片在右，文字在左
    YYBBImagePositionStyleRight,
    /// 图片在上，文字在下
    YYBBImagePositionStyleTop,
    /// 图片在下，文字在上
    YYBBImagePositionStyleBottom,
} YYBBImagePositionStyle;


@interface UIButton (YYBBAdd)

- (void)yybb_setImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state;

- (void)yybb_setImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state placeholderImage:(nullable UIImage *)placeholder;

- (void)yybb__setBackgroundImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state;

- (void)yybb__setBackgroundImageWithURLStr:(nullable NSString *)urlStr forState:(UIControlState)state placeholderImage:(nullable UIImage *)placeholder;

/**
 * 快速创建按钮
 * frame : frame
 * imageName : 图片
 * titleColor : 字体颜色
 * titleFont : 字体大小
 * backgroundColor : 背景颜色
 * cornerRadius : 圆角半径
 * borderWidth : 边框宽度
 * borderColor : 边款颜色
 * title : 标题
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(nullable NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius
                       borderWidth:(CGFloat)borderWidth
                       borderColor:(UIColor *)borderColor
                             title:(NSString *)title;

/**
 * 快速创建按钮
 * frame : frame
 * imageName : 图片
 * titleColor : 字体颜色
 * titleFont : 字体大小
 * backgroundColor : 背景颜色
 * title : 标题
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(nullable NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title;
/**
 * 快速创建按钮
 * frame : frame
 * imageName : 图片
 * titleColor : 字体颜色
 * titleFont : 字体大小
 * title : 标题
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(nullable NSString *)imageName
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                             title:(NSString *)title ;
/**
 * 快速创建按钮
 * frame : frame
 * titleColor : 字体颜色
 * titleFont : 字体大小
 * backgroundColor : 背景颜色
 * title : 标题
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title;
/**
 * 快速创建按钮
 * frame : frame
 * titleColor : 字体颜色
 * titleFont : 字体大小
 * title : 标题
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                             title:(NSString *)title;
/**
 * 快速创建按钮
 * frame : frame
 * imageName : 图片
 * cornerRadius : 圆角半径
 * borderWidth : 边框宽度
 * borderColor : 边款颜色
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(nullable NSString *)imageName
                      cornerRadius:(CGFloat)cornerRadius
                       borderWidth:(CGFloat)borderWidth
                       borderColor:(UIColor *)borderColor;

/**
 * 快速创建按钮
 * frame : frame
 * imageName : 图片
 */
+ (UIButton *)yybb_buttonWithTarget:(id)target
                            action:(SEL)action
                             frame:(CGRect)frame
                         imageName:(nullable NSString *)imageName;

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)yybb_imagePositionStyle:(YYBBImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

/**
 *  设置图片与文字样式（推荐使用）
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 *  @param imagePositionBlock     在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)yybb_imagePositionStyle:(YYBBImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock;


@end

NS_ASSUME_NONNULL_END
