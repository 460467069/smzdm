//
//  ZZTextLinePositionModifier.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文本line位置修改
 将每行文本的高度和位置固定下来, 不受中英文/Emoji字体的 ascent / descent 的影响
 */
@interface ZZTextLinePositionModifier : NSObject<YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font;                 //基准字体
@property (nonatomic, assign) CGFloat paddingTop;           //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom;        //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple;   //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end