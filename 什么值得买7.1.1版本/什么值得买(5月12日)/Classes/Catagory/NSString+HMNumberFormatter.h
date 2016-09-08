//
//  NSString+HMNumberFormatter.h
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMNumberFormatter)

/** 浮点型转百分比字符串 */
+ (NSString *)stringFromFloat:(CGFloat )value;
@end
