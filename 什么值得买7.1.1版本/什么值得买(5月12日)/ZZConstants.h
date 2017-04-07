//
//  ZZConstants.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#ifndef ZZConstants_h
#define ZZConstants_h

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define ZZColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kStatusH                    20                      //  状态栏高度
#define kNavBarH                    44                      //  导航栏高度
#define kTabBarH                    49                      //  标签栏高度

#define kGlobalRedColor [UIColor colorWithHexString:@"#F04848"]
#define kGlobalGrayColor [UIColor colorWithHexString:@"#666666"]
#define kGlobalLightGrayColor ZZColor(234, 234, 234)


#define kHomeFirstCellPicHeight1 (kScreenW / 750.0 * 326)
#define kHomeFirstCellPicWidth1 (kScreenW / 750.0 * 284)
#define kHomeFirstCellPicHeight2 (kScreenW / 750.0 * 154)
#define kHomeFirstCellPicWidth2 (kScreenW / 750.0 * 464)
#define kHomeFirstCellPicHeight3 (kScreenW / 750.0 * 170)
#define kHomeFirstCellPicWidth3 (kScreenW / 750.0 * 231)

#define kDetailContentOffset 15

#define kHaojiaJingXuan @"haojia_jingxuan"
#define kZhiYouFuLi @"值友福利"

//Share SDK
#define kShareSDKKey                @"18879f9cde450"

//新浪微博
#define kShareSinaWeiboKey          @"4079614173"
#define kShareSinaWeiboSecret       @"cc6bf86d35dc387c1c2fea27a66eff7e"
#define kShareSinaWeiboRedirectUri  @"http://www.smzdm.com"

//微信
#define kShareWeChatKey             @"wx428cb93c44cf6e7f"
#define kShareWeChatSecret          @"9a060eff2d92b3f1b0fbc180fa334957"

//微信
#define kShareTencentKey            @"fEiiO0nLREbY1Hop"
#define kShareTencentSecret         @"9a060eff2d92b3f1b0fbc180fa334957"

// JSPatch
#define kJSPatchKey                 @"c9cdea7d8f31f8e6"

#define kBuglyAppID                 @"6fe4143c26"


#endif /* ZZConstants_h */
