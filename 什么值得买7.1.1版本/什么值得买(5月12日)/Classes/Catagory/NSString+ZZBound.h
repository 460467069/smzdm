//
//  NSString+ZZBound.h
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZBound)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
//给出[日期格式为"20161201"], 返回对应星期
- (NSString *)caculateWeek;
@end
