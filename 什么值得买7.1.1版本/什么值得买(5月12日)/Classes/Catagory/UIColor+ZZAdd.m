//
//  UIColor+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UIColor+ZZAdd.h"

@implementation UIColor (ZZAdd)
+ (UIColor *)zz_tintColor {
    return [self zz_sm_tintColor];
}

+ (UIColor *)zz_textColor {
    return [self zz_colorWithRed:153 green:153 blue:153];
}

+ (UIColor *)zz_redColor {
    return [self zz_colorWithRed:255 green:45 blue:75];
}

+ (UIColor *)zz_priceRedColor {
    return [self zz_colorWithRed:228 green:93 blue:86];
}

+ (UIColor *)zz_sm_tintColor {
    return [self zz_colorWithRed:75 green:199 blue:255];
}

+ (UIColor *)zz_orangeColor {
    return [self colorWithHexString:@"#ffa200"];
}

+ (UIColor *)zz_blueColor {
    return [self zz_colorWithRed:47 green:65 blue:77];
}

+ (UIColor *)zz_momentNicknameColor {
    return [self zz_colorWithRed:65 green:101 blue:145];
}

+ (UIColor *)zz_lightBlackColor {
    return [self zz_colorWithRed:85 green:85 blue:85];
}

+ (UIColor *)zz_tableFooterButtonBackgroundColor {
    return  [self zz_sm_tintColor];
    //return  [self zz_tintColor];
}

+ (UIColor *)zz_mrchantsColor {
    return [self zz_tintColor];
}

+ (UIColor *)zz_navigationBarTintColor {
    return [self zz_colorWithRed:246 green:247 blue:248];
}

+ (UIColor *)zz_tableViewBackgroundColor {
    return [self zz_colorWithRed:241 green:242 blue:243];
}

+ (UIColor *)zz_lightGrayColor {
    return [self zz_colorWithRed:231 green:232 blue:233];
}

+ (UIColor *)zz_middleGrayColor {
    return [self zz_colorWithRed:190 green:190 blue:190];
}

+ (UIColor *)zz_grayColor {//#999999
    return [self zz_colorWithRed:153 green:153 blue:153];
}

+ (UIColor *)zz_darkGrayColor {
    return [self colorWithHexString:@"#666666"];
}


+ (UIColor *)zz_lightWhiteColor {
    return [self zz_colorWithRed:250 green:250 blue:250];
}

+ (UIColor *)zz_whiteColor {
    return [UIColor whiteColor];
}

+ (UIColor *)zz_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self zz_colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)zz_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

+ (UIColor *)zz_blackColor {
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)zz_lineColor {
    return [UIColor colorWithWhite:0.8 alpha:0.5];
}

+ (UIColor *)zz_placeHolderColor {
    return [self colorWithHexString:@"#d7d5d5"];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] <= 6)
    {
        return [UIColor zz_tintColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor zz_tintColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)zz_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
