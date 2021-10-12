//
//  YYBBPlaceholderTextView.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//


@interface YYBBPlaceholderTextView : UITextView

/// 当 text view 为空时显示的文字. 默认为 `nil`.
@property (nonatomic, copy) IBInspectable NSString *placeholder;

/// `placeholder` 的字体颜色, 默认为 `[UIColor lightGrayColor]`.
@property (nonatomic, strong) IBInspectable UIColor *placeholderTextColor;

/// `placeholder` 在 text view 中的偏移量, 默认为 {7,5}
@property (nonatomic) CGPoint placeholderOffset;

- (BOOL)hasText;

@end
