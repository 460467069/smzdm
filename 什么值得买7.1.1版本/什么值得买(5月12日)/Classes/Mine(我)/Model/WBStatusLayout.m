//
//  WBStatusLayout.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/7/24.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "WBStatusLayout.h"

/**
  将每行的baseline 位置固定下来, 不受不同字体的ascent / descent 影响
  注意, Heiti SC中, ascent + descent = font size,
  但是在PingFang SC中, ascent + descent > font size.
  所以这里统一用Heiti SC(0.86 ascent, 0.14 descent) 座位顶部和底部标准, 保证不同系统下的显示一致性
  间距仍然使用字体默认
 */

@implementation WBTextLinePositionModifier

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (kiOS9Later) {
            _lineHeightMulitple = 1.34; //for PingFang SC
        }else{
            _lineHeightMulitple = 1.3125; //for Heiti SC
        }
    }
    return self;
}

- (void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container{
    
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = ascent * _lineHeightMulitple;
    
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone{
    WBTextLinePositionModifier *modifier = [[self.class allocWithZone:zone] init];
    modifier->_font = _font;
    modifier->_paddingTop = _paddingTop;
    modifier->_paddingBottom = _paddingBottom;
    modifier->_lineHeightMulitple = _lineHeightMulitple;
    return modifier;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount{
    if (lineCount == 0) {
        return 0;
    }
    
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * lineCount;
    
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end

@interface WBTextImageViewAttachment : YYTextAttachment
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;
@end

@implementation WBTextImageViewAttachment{
    UIImageView *_imageView;
}

- (void)setContent:(id)content{
    _imageView = content;
}

- (id)content{
    //UIImageView 只能在主线程访问, 如果当前是主线程, 返回非0数
    if (pthread_main_np() == 0) {
        return nil;
    }
    if (_imageView) {
        return _imageView;
    }
    //第一次获取时, (应该是在文本渲染完成, 需要添加视图时), 初始化图片视图, 并下载图片
    //这里改成YYAnimatedImageView, 就能支持GIF /APNG/WebP动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}

@end

@implementation WBStatusLayout


- (instancetype)initWithStatus:(WBStatus *)stauts style:(WBLayoutStyle)style {
    if (!stauts || stauts.user) {
        return nil;
    }
    self = [super init];
    _status = stauts;
    _style = style;
    [self layout];
    return self;
    
}

- (void)layout {
    _marginTop = kWBCellTopMargin;
    _titleHeight = 0;
    _profileHeight = 0;
    _textHeight = 0;
    _retweetHeight = 0;
    _retweetTextHeight = 0;
    _retweetPicHeight = 0;
    _retweetPicHeight = 0;
    _retweetCardHeight = 0;
    _picHeight = 0;
    _cardHeight = 0;
    _toolbarHeight = kWBCellToolbarHeight;
    _marginBottom = kWBCellToolbarBottomMargin;
    
    //文本排版, 计算布局
    [self _layoutTitle];
    [self _layoutProfile];
    [self _layoutRetweet];
    if (_retweetHeight == 0) {
        [self _layoutPics];
        if (_picHeight == 0) {
            [self _layoutCard];
        }
    }
    
    [self _layoutText];
    [self _layoutTag];
    [self _layoutToolbar];
    
    //计算高度
    _height = 0;
    _height += _marginTop;
    _height += _titleHeight;
    _height += _profileHeight;
    _height += _textHeight;
    if (_retweetHeight > 0) {
        _height += _retweetHeight;
    }else if (_picHeight){
        _height += _picHeight;
    }else if (_cardHeight){
        _height += _cardHeight;
    }
    
    if (_tagHeight > 0) {
        _height += _tagHeight;
    }else{
        if (_picHeight > 0 || _cardHeight > 0) {
            _height += kWBCellPadding;
        }
    }
    
    _height += _toolbarHeight;
    _height += _marginBottom;
}

/** 布局标题 */
- (void)_layoutTitle{
    
}

/** 布局头像 */
- (void)_layoutProfile{
    
}

/** 布局昵称 */
- (void)_layoutName{
    
}

/** 布局时间和来源 */
- (void)_layoutSource{
    
}

/** 布局微博正文 */
- (void)_layoutText{
    
}

/** 图片大小 */
- (void)_layoutPics{
    
}

- (void)_layoutCard{
    
}


/** 布局转发 */
- (void)_layoutRetweet{
    
}

/** 布局转发正文 */
- (void)_layoutRetweetText{
    
}

/** 布局图片大小 */
- (void)_layoutRetweetPics{
    
}

/** 布局转发图片 */
- (void)_layoutRetweetCard{
    
}

/** 布局标签 */
- (void)_layoutTag{
    
}

/** 布局工具栏 */
- (void)_layoutToolbar{
    
}
@end
