//
//  YYBBLimitConstants.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZZTextFieldInputLimit) {
    ZZTextFieldInputUnLimit            = 0, // 不限制
    ZZTextFieldInputLimitNum,               // 数字
    ZZTextFieldInputLimitLetter,            // 字母
    ZZTextFieldInputLimitLetterAndNum       // 数字+字母
};

FOUNDATION_EXPORT NSString * const kOnlyNum;
FOUNDATION_EXPORT NSString * const kOnlyLetter;
FOUNDATION_EXPORT NSString * const kOnlyLetterAndNum;


