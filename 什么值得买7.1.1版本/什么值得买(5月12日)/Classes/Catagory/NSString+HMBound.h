//
//  NSString+HMBound.h
//  什么值得买(5月7日)
//
//  Created by Wang_ruzhou on 16/5/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMBound)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

@end
