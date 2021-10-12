//
//  UITextField+YYBBAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITextField (YYBBAdd)

/**
 *  创建textfield
 *
 *  @param frame            位置
 *  @param font             字体
 *  @param tColor           字体颜色
 *  @param aTextAliType     对齐
 *  @param style            风格
 *  @param leftViewWidth    光标左间距
 *  @param backgroundImg    背景图片
 *  @param clearButtonMode  清除类型
 *  @param keyBoardType     键盘类型
 *  @param delegate         委托对象
 *
 *  @return textfield对象
 */
+ (instancetype)yybb_createTextFiled:(CGRect)frame
                            textFont:(UIFont *)font
                           textColor:(UIColor *)tColor
                         textAliType:(NSTextAlignment)aTextAliType
                         borderStyle:(UITextBorderStyle)style
                       leftViewWidth:(CGFloat)leftViewWidth
                       backgroundImg:(nullable UIImage *)backgroundImg
                     clearButtonMode:(UITextFieldViewMode)clearButtonMode
                        keyBoardType:(UIKeyboardType)keyBoardType
                            delegate:(nullable id)delegate;

@end
NS_ASSUME_NONNULL_END
