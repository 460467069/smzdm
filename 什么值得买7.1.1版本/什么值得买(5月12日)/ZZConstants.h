//
//  ZZConstants.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/15.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#ifndef ZZConstants_h
#define ZZConstants_h
#define ZZColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kStatusH                    20                      //  状态栏高度
#define kNavBarH                    44                      //  导航栏高度
#define kTabBarH                    49                      //  标签栏高度

#define kGlobalRedColor [UIColor colorWithHexString:@"#F04848"]
#define kGlobalGrayColor [UIColor colorWithHexString:@"#666666"]
#define kGlobalLightGrayColor ZZColor(247, 247, 247)


#define kHomeFirstCellPicHeight1 (kScreenWidth / 750.0 * 326)
#define kHomeFirstCellPicWidth1 (kScreenWidth / 750.0 * 284)
#define kHomeFirstCellPicHeight2 (kScreenWidth / 750.0 * 154)
#define kHomeFirstCellPicWidth2 (kScreenWidth / 750.0 * 464)
#define kHomeFirstCellPicHeight3 (kScreenWidth / 750.0 * 170)
#define kHomeFirstCellPicWidth3 (kScreenWidth / 750.0 * 231)

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

//QQ
#define kShareTencentKey            @"fEiiO0nLREbY1Hop"
#define kShareTencentSecret         @"9a060eff2d92b3f1b0fbc180fa334957"

// JSPatch
#define kJSPatchKey                 @"c9cdea7d8f31f8e6"

#define kBuglyAppID                 @"c336b9bd5c"
#define kBuglyAppKey                @"4edefee5-e863-4aec-a7d9-c87174a01e1b"

static inline NSString * OPTEncryptKey() {
    /**
     *  加密流程:
     *  1. 将密钥随机插入空格后转换为十六进制
     *  2. 将转换后的十六进制字符串做 Base64 加密
     *
     *  解密流程:
     *  1. 将密钥做 Base64 解密
     *  2. 移除随机插入的空格
     *  3. 将十六进制转为 NSString.
     *
     *  https://www.branah.com/ascii-converter
     */
    
    static NSString *returnedKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *key = @"MzIyMDM2MjA2NTYyMzgzMzY2MjAzMDM3MzMyMDY2NjUzNDYyMzE2MTYxMjAzNjY1MzEzNTY0MzYzMzIwMzY2NDIwMzU2MjIwMzMzODY0MjA2Ng==";
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:key options:0];
        NSString *decodedString = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
        NSString *hexedString = [decodedString stringByReplacingOccurrencesOfString:@"20" withString:@""];
        
        if (([hexedString length] % 2) != 0) {
            return;
        }
        
        NSMutableString *string = [NSMutableString string];
        
        for (NSInteger i = 0; i < [hexedString length]; i += 2) {
            NSString *hex = [hexedString substringWithRange:NSMakeRange(i, 2)];
            NSInteger decimalValue = 0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat"
            sscanf([hex UTF8String], "%x", &decimalValue);
            [string appendFormat:@"%c", decimalValue];
#pragma clang diagnostic pop
        }
        
        returnedKey = [string copy];
    });
    
    return returnedKey;
}



#endif /* ZZConstants_h */
