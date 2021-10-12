//
//  UIColor+YYBBAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YYBBAdd)

// 文字的主题色
+ (UIColor *)yybb_themeColor;
// 主题背景色
+ (UIColor *)yybb_themeColor2;
// 浅一点的背景主题色
+ (UIColor *)yybb_themeColor3;
// 浅一点背景色其上的文字颜色
+ (UIColor *)yybb_themeColor4;
+ (UIColor *)yybb_themeColor4_alpha20;
+ (UIColor *)yybb_receiptTextColor;
+ (UIColor *)yybb_textColor1;
+ (UIColor *)yybb_textColor1_alpha33;
+ (UIColor *)yybb_strokeColor;
+ (UIColor *)yybb_randomColor;
+ (UIColor *)yybb_tintColor;
+ (UIColor *)yybb_redColor;
+ (UIColor *)yybb_redColor2;
+ (UIColor *)yybb_priceRedColor;
+ (UIColor *)yybb_barButtonItemTitleColor;
+ (UIColor *)yybb_sm_tintColor;
+ (UIColor *)yybb_blueColor;
+ (UIColor *)yybb_blackColor;
+ (UIColor *)yybb_blackColor2;
+ (UIColor *)yybb_momentNicknameColor;
+ (UIColor *)yybb_tableFooterButtonBackgroundColor;
+ (UIColor *)yybb_mrchantsColor;
+ (UIColor *)yybb_navigationBarTintColor;
+ (UIColor *)yybb_tableViewBackgroundColor;
+ (UIColor *)yybb_grayColor;
+ (UIColor *)yybb_lightGrayColor;
+ (UIColor *)yybb_middleGrayColor;
+ (UIColor *)yybb_filterResetColor;
// 灰度背景
+ (UIColor *)yybb_grayScaleBgColor;
// 绿色
+ (UIColor *)yybb_greenColor;
// 紫色
+ (UIColor *)yybb_purpleColor;
// 取消按钮颜色
+ (UIColor *)yybb_cancelTitleColor;
// 取消按钮
+ (UIColor *)yybb_cancel1TitleColor;
// 确定按钮颜色
+ (UIColor *)yybb_confirmTitleColor;
+ (UIColor *)yybb_confirmThemeTitleColor;
+ (UIColor *)yybb_placeHolderColor;
+ (UIColor *)yybb_borderColor;
+ (UIColor *)yybb_lightBlackColor;
+ (UIColor *)yybb_orangeColor;
+ (UIColor *)yybb_yellowColor;
+ (UIColor *)yybb_lightWhiteColor;
+ (UIColor *)yybb_whiteColor;
+ (UIColor *)yybb_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)yybb_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)yybb_lineColor;
+ (UIColor *)yybb_textColor;
+ (UIColor *)yybb_color111;
+ (UIColor *)yybb_colorEDEDED;
+ (UIColor *) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;
// 售后问题类型背景颜色
+ (UIColor *)yybb_questionTypeTextColor;
@end
