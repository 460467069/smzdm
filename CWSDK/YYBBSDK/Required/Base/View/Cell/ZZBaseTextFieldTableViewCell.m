//
//  ZZBaseTextFieldTableViewCell.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZBaseTextFieldTableViewCell.h"
#import <YYCategories/UIView+YYAdd.h>
#import "YYBBUtilsMacro.h"

@implementation ZZBaseTextFieldTableViewCell

- (void)initUI {
    [self.contentView addSubview:self.logoView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setTextFieldform:(ZZTextFieldForm *)textFieldform {
    
    _textFieldform = textFieldform;
    
    self.logoView.image = textFieldform.image;
    self.titleLabel.text = _textFieldform.title;
    self.titleLabel.characterSpacing = _textFieldform.characterSpacing;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    id optionImage = self.textFieldform.image;
    if ([optionImage isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)optionImage;
        self.logoView.left = YYBBDefaultPadding;
        self.logoView.size = image.size;
        self.logoView.centerY = self.contentView.centerY;
    } else {
        self.logoView.left = 0;
        self.logoView.size = CGSizeZero;
        self.logoView.centerY = self.contentView.centerY;
    }
        
    if (self.titleLabel.text.length > 0) {
        self.titleLabel.left = self.logoView.right + YYBBDefaultPadding + 5;
        self.titleLabel.width = 80;
        self.titleLabel.height = self.contentView.height;
    } else {
        self.titleLabel.left = self.logoView.right;
        self.titleLabel.size = CGSizeZero;
    }
}

#pragma mark- Custom Access
- (UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [UIImageView new];
    }
    return _logoView;
}

- (YYBBSpaceInsetsLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[YYBBSpaceInsetsLabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (void)setTitleLabelSize:(CGSize)titleLabelSize {
    if (!CGSizeEqualToSize(_titleLabelSize, titleLabelSize)) {
        _titleLabelSize = titleLabelSize;
        CGRect titleLabelFrame = self.titleLabel.frame;
        titleLabelFrame.size = titleLabelSize;
        self.titleLabel.frame = titleLabelFrame;
    }
}

@end
