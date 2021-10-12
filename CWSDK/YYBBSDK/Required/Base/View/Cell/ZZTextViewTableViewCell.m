//
//  ZZTextViewTableViewCell.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZTextViewTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ZZTextViewTableViewCell

- (void)initUI {
    _textView = [YYBBPlaceholderTextView new];
    [self.contentView addSubview:_textView];
    _textViewConstraints = [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_textView.superview);
    }];
}

@end
