//
//  UIColor+YYBBAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UIColor+YYBBAdd.h"
#import <YYCategories/UIColor+YYAdd.h>
#import "YYBBUtilities.h"

@implementation UIColor (YYBBAdd)

+ (UIColor *)yybb_themeColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#FF5792);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFBD15);
    }
    return nil;
}

+ (UIColor *)yybb_themeColor2 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#76B4FF);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFBD15);
    }
    return nil;
}

+ (UIColor *)yybb_themeColor3 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#E4F0FF);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFEBD0);
    }
    return nil;
}

+ (UIColor *)yybb_themeColor4 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#4295F8);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FF9B15);
    }
    return nil;
}

+ (UIColor *)yybb_themeColor4_alpha20 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return [UIColor colorWithHex:0x4295F8 alpha:0.2];
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return [UIColor colorWithHex:0xFF9B15 alpha:0.2];
    }
    return nil;
}

+ (UIColor *)yybb_receiptTextColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#778DD8);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FF9D46);
    }
    return nil;
}

+ (UIColor *)yybb_textColor1 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#76B4FF);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FF8C34);
    }
    return nil;
}

+ (UIColor *)yybb_textColor1_alpha33 {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return [UIColor colorWithHex:0x76B4FF alpha:0.33];
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return [UIColor colorWithHex:0xFF8C34 alpha:0.33];
    }
    return nil;
}

+ (UIColor *)yybb_strokeColor {
    return [self blackColor];
}

+ (UIColor *)yybb_tintColor {
    return [self yybb_sm_tintColor];
}

+ (UIColor *)yybb_textColor {
    return [self yybb_colorWithRed:153 green:153 blue:153];
}

+ (UIColor *)yybb_redColor {
    return [self colorWithHexString:@"#DF2548"];
}

+ (UIColor *)yybb_redColor2 {
    return [self colorWithHexString:@"#FF5182"];
}

+ (UIColor *)yybb_priceRedColor {
    return [self colorWithHexString:@"FF4646"];
}

+ (UIColor *)yybb_barButtonItemTitleColor {
    return [self colorWithHexString:@"#499AFC"];
}

+ (UIColor *)yybb_sm_tintColor {
    return [self yybb_colorWithRed:75 green:199 blue:255];
}

+ (UIColor *)yybb_orangeColor {
    return [self colorWithHexString:@"#FF6555"];
}

+ (UIColor *)yybb_yellowColor {
    return [self colorWithHexString:@"#FFE641"];
}

+ (UIColor *)yybb_blueColor {
    return [self yybb_colorWithRed:47 green:65 blue:77];
}

+ (UIColor *)yybb_momentNicknameColor {
    return [self yybb_colorWithRed:65 green:101 blue:145];
}

+ (UIColor *)yybb_lightBlackColor {
    return [self yybb_colorWithRed:85 green:85 blue:85];
}

+ (UIColor *)yybb_tableFooterButtonBackgroundColor {
    return  [self yybb_sm_tintColor];
    //return  [self yybb_tintColor];
}

+ (UIColor *)yybb_mrchantsColor {
    return [self yybb_tintColor];
}

+ (UIColor *)yybb_navigationBarTintColor {
    return [self yybb_colorWithRed:246 green:247 blue:248];
}

+ (UIColor *)yybb_tableViewBackgroundColor {
    return [self yybb_colorWithRed:241 green:242 blue:243];
}

+ (UIColor *)yybb_grayColor {
    return [self colorWithHexString:@"#646464"];
}

+ (UIColor *)yybb_middleGrayColor {
    return [self colorWithHexString:@"#666666"];
}

+ (UIColor *)yybb_lightGrayColor {
    return [self colorWithHexString:@"999999"];
}

// 灰度背景
+ (UIColor *)yybb_grayScaleBgColor {
    return [self colorWithHexString:@"F8F8F8"];
}

// 绿色
+ (UIColor *)yybb_greenColor {
    return [self colorWithHexString:@"#3ECC69"];
}

// 紫色
+ (UIColor *)yybb_purpleColor {
    return [self colorWithHexString:@"#AC2AC4"];
}

+ (UIColor *)yybb_cancelTitleColor {
    return [self colorWithHexString:@"#9B9B9B"];
}

+ (UIColor *)yybb_cancel1TitleColor {
    return [self colorWithHexString:@"#CCCCCC"];
}

+ (UIColor *)yybb_confirmTitleColor {
    return [self colorWithHexString:@"#499AFC"];
}

+ (UIColor *)yybb_confirmThemeTitleColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#499AFC);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFBD15);
    }
    return nil;
}

+ (UIColor *)yybb_lightWhiteColor {
    return [self yybb_colorWithRed:250 green:250 blue:250];
}

+ (UIColor *)yybb_whiteColor {
    return [UIColor whiteColor];
}

+ (UIColor *)yybb_filterResetColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(9AC7FF);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFD05B);
    }
    return nil;
}

+ (UIColor *)yybb_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self yybb_colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)yybb_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

+ (UIColor *)yybb_blackColor {
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)yybb_blackColor2 {
    return [self colorWithHexString:@"#646464"];
}

+ (UIColor *)yybb_lineColor {
    return [self colorWithHexString:@"#E0E0E0"];
}

+ (UIColor *)yybb_placeHolderColor {
    return [self colorWithHexString:@"#CCCCCC"];
}

+ (UIColor *)yybb_borderColor {
    return [self colorWithHexString:@"#E6E6E6"];
}

+ (UIColor *)yybb_color111 {
    return [self colorWithHexString:@"111111"];
}

+ (UIColor *)yybb_colorEDEDED {
    return [self colorWithHexString:@"EDEDED"];
}

+ (UIColor *)yybb_questionTypeTextColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#4295F8);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFBD15);
    }
    return nil;
}

+ (UIColor *)yybb_erpColor {
    if (YYBBCurrentAppType() == YYBBAppTypeMeLive) {
        return UIColorHex(#4295F8);
    } else if (YYBBCurrentAppType() == YYBBAppTypeOther) {
        return UIColorHex(#FFCD4C);
    }
    return nil;
}

+ (UIColor *)yybb_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
    green:((float)((hex & 0xFF00) >> 8)) / 255.0
     blue:((float)(hex & 0xFF)) / 255.0
    alpha:alpha];
}

@end
