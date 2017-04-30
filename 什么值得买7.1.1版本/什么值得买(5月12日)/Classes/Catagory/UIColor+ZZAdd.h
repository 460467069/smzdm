//
//  UIColor+ZZAdd.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZZAdd)

+ (UIColor *)zz_randomColor;
+ (UIColor *)zz_tintColor;
+ (UIColor *)zz_redColor;
+ (UIColor *)zz_priceRedColor;
+ (UIColor *)zz_sm_tintColor;
+ (UIColor *)zz_blueColor;
+ (UIColor *)zz_blackColor;
+ (UIColor *)zz_momentNicknameColor;
+ (UIColor *)zz_tableFooterButtonBackgroundColor;
+ (UIColor *)zz_mrchantsColor;
+ (UIColor *)zz_navigationBarTintColor;
+ (UIColor *)zz_tableViewBackgroundColor;
+ (UIColor *)zz_lightGrayColor;
+ (UIColor *)zz_middleGrayColor;
+ (UIColor *)zz_grayColor;
+ (UIColor *)zz_placeHolderColor;
+ (UIColor *)zz_darkGrayColor;
+ (UIColor *)zz_lightBlackColor;
+ (UIColor *)zz_orangeColor;
+ (UIColor *)zz_lightWhiteColor;
+ (UIColor *)zz_whiteColor;
+ (UIColor *)zz_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)zz_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)zz_lineColor;
+ (UIColor *)zz_textColor;

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
