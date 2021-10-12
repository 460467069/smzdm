//
//  YYBBMacros.h
//  YYCardBoard
//
//  Created by Wang_Ruzhou on 12/20/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#ifndef YYBBMacros_h
#define YYBBMacros_h

#define RGBColor(r,g,b,a)   [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define RGB(r,g,b)  RGBColor(r,g,b,1.0f)

#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#define RGBCommonColor(r)   [UIColor colorWithRed:r/255. green:r/255. blue:r/255. alpha:1]

// 项目主题色
#define YYBBBase_Color_Main UIColorHex(0xFDE23D)
#define YYBBBase_Color_MainOne UIColorHex(0xFFDF1A)

#define YYBBCOLOR_COLOR_Black RGBColor(51,51,51,1) //黑色
#define YYBBCOLOR_COLOR_52Black RGBColor(52,52,52,1) //黑色
#define YYBBCOLOR_COLOR_73Black RGBColor(73,73,73,1) //黑色
#define YYBBCOLOR_COLOR_74Black RGBColor(74,74,74,1) //黑色
#define YYBBCOLOR_COLOR_GrayBlack RGBColor(11,11,11,1) //灰色
#define YYBBCOLOR_COLOR_119Gray RGBColor(119,119,119,1) //119灰色
#define YYBBCOLOR_COLOR_214Gray RGBColor(214,214,214,1) //214灰色
#define YYBBCOLOR_COLOR_153Gray RGBColor(153,153,153,1) //153灰色
#define YYBBCOLOR_COLOR_115Gray RGBColor(115,115,115,1) //115灰色

#define YYBBCOLOR_COLOR_TitleYellow RGBColor(245, 201, 54, 1) //黄色
#define YYBBCOLOR_COLOR_TitleBlue RGBColor(67, 136, 255, 1) //蓝色

//系统
#define YYBBCOLOR_COLOR_DeepTitleBlue RGBColor(0, 122, 255, 1) //深蓝色
#define YYBBCOLOR_COLOR_Red RGBColor(255,98,59,1) //115灰色

//背景颜色
#define YYBBCOLOR_COLOR_BGROUND RGBColor(250,250,250,1) //背景颜色
#define YYBBCOLOR_COLOR_BGYELLOW RGBColor(255, 189, 21, 1) //背景黄色

#define YYBBCOLOR_COLOR_YELLOW RGBColor(250, 226, 7, 1) //换个色

///修改的宏
/// 项目主体高亮颜色
#define YYBBMainBGHL_COlOR RGBColor(250, 189, 21, 1)//背景黄色
//RGBColor(118, 180, 225, 1) 绿色
 
//TextView背景色
#define YYBBCOLOR_COLOR_237COLOR RGBColor(237, 237, 237, 1) //换个色

#define YYFontMedium @"PingFang-SC-Medium" //黑色
#define YYFontMediumBold @"Helvetica-Bold" //黑色粗体
#define YYFontRegular @"PingFang-SC-Regular" //浅黑
#define YYFontLight @"PingFang-SC-Light" //

// 通用背景颜色
#define YYBBBASE_COLOR_BackWhite UIColorHex(0xF8F8F8) //248
#define YYBBBASE_COLOR_BackGray UIColorHex(0xECECEC) // 236
#define YYBBBASE_COLOR_FenGeGray UIColorHex(0xD5D5D5)  //
#define YYBBBASE_COLOR_SepGray UIColorHex(0xE1E1E1) // 225

// 字体颜色
#define YYBBBASE_COLOR_ZeroBlack UIColorHex(0x000000)
#define YYBBBASE_COLOR_OneBlack UIColorHex(0x111111)
#define YYBBBASE_COLOR_FiveBlack UIColorHex(0x555555)
#define YYBBBASE_COLOR_SixBlack UIColorHex(0x666666)
#define YYBBBASE_COLOR_SevenBlack UIColorHex(0x777777)
#define YYBBBASE_COLOR_DarkYellow UIColorHex(0xF1C900)
#define YYBBBASE_COLOR_DarkGreen UIColorHex(0x8fc849)

/// 图片
#define YYBBLOADIMAGE(file) [UIImage imageNamed:file]

///AppDelegate
#define APPDELEGATES (AppDelegate *)[[UIApplication sharedApplication] delegate];

///  控制分页加载条数 ,用于下啦刷新的控制下拉的属性
#define YYBBPageSize @"10"

#endif /* YYBBMacros_h */
