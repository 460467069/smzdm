//
//  UILabel+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UILabel(ZZAdd)

- (CGSize)contentSize;

/**
 *  创建label
 *
 *  @param frame        位置
 *  @param aText        内容
 *  @param aTextAliType 对齐
 *  @param font         字体
 *  @param aColor       字体颜色
 *  @param bColor       背景颜色
 *
 *  @return label对象
 */
+ (instancetype)yj_createLable:(CGRect)frame
                          text:(nullable NSString *)aText
                   textAliType:(NSTextAlignment)aTextAliType
                          font:(UIFont *)font
                         color:(UIColor *)aColor
                     backColor:(UIColor *)bColor;

/**
 *  创建label
 *
 *  @param frame        位置
 *  @param aText        内容
 *  @param aTextAliType 对齐
 *  @param font         字体
 *  @param aColor       字体颜色
 *  @param bColor       背景颜色
 *  @param bAdjust      是否自动适配宽度
 *
 *  @return label对象
 */
+ (instancetype)yj_createLable:(CGRect)frame
                          text:(nullable NSString *)aText
                   textAliType:(NSTextAlignment)aTextAliType
                          font:(UIFont *)font
                         color:(UIColor *)aColor
                     backColor:(UIColor *)bColor
     adjustsFontSizeToFitWidth:(BOOL)bAdjust;
@end

NS_ASSUME_NONNULL_END
