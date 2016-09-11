//
//  HMDetailHeaderLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailHeaderLayout.h"
#import "WBStatusLayout.h"

/**
 文本line位置修改
 将每行文本的高度和位置固定下来, 不受中英文/Emoji字体的 ascent / descent 的影响
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 
 */

@implementation HMTextLinePositionModifier

- (instancetype)init
{
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

- (void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container{
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeght = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row * lineHeght;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone{
    HMTextLinePositionModifier *one = [self.class new];
    
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount{
    
    if (lineCount == 0) {
        return 0;
    }
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end

@implementation HMDetailHeaderLayout


- (instancetype)initWithHeaderDetailModel:(HMDetailModel *)detailModel {
	
    if (!detailModel) {
        return nil;
    }
    if (self = [super init]) {
        
        _detailModel = detailModel;
    }
    
    [self layout];
    _height = 0;
    _height += _imageHeight;
    _height += _textHeight;
    _height += kSeparatorLineTop;
    _height += kSeparatorLineHeight;
    _height += kSeparatorLineBottom;
    
    return self;
 
}

- (void)layout{

    NSArray <HMProductFocusPicUrl *> *article_product_focus_pic_url = _detailModel.article_product_focus_pic_url;

    if (article_product_focus_pic_url.count != 0 || _detailModel.article_pic) {
        _imageHeight = kTopImageHeight;
    }else{
        _imageHeight = 0;
    }
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    {
        NSString *title = [NSString stringWithFormat:@"%@ | %@", _detailModel.article_mall, _detailModel.article_format_date];
        if (_detailModel.article_bl_author_info[0]) {
            title = [NSString stringWithFormat:@"%@ | 爆料人: %@", title, _detailModel.article_bl_author_info[0].nick_name];
        }
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailModel.article_title];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:font forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    {
        NSString *title = [NSString stringWithFormat:@"%@", _detailModel.article_price];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:kGlobalRedColor forKey:NSForegroundColorAttributeName];
        [attributes setObject:font forKey:NSFontAttributeName];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:attributes]];
    }
    
    text.lineSpacing = kTitleLineSpacing;
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = font;
    modifier.paddingTop = kWBCellPaddingText;
    modifier.paddingBottom = kWBCellPaddingText;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenW, HUGE) insets:UIEdgeInsetsMake(kDetailContentOffset, kDetailContentOffset, 0, kDetailContentOffset)];
    
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_titleTextLayout) return;
    
    _textHeight = _titleTextLayout.textBoundingSize.height;
    
}

@end
