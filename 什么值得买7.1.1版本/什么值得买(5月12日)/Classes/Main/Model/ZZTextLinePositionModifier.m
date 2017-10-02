//
//  ZZTextLinePositionModifier.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "ZZTextLinePositionModifier.h"


/**
 文本line位置修改
 将每行文本的高度和位置固定下来, 不受中英文/Emoji字体的 ascent / descent 的影响
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 
 */

@implementation ZZTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    if (self) {
        if (kiOS9Later) {
            _lineHeightMultiple = 1.34;
        }else{
            _lineHeightMultiple = 1.3125;
        }
    }
    return self;
}

- (void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeght = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row * lineHeght;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    ZZTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    
    if (lineCount == 0) {
        return 0;
    }
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end
