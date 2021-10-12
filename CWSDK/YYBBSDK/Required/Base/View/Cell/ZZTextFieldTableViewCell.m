//
//  ZZTextFieldTableViewCell.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZTextFieldTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ZZTextFieldTableViewCell ()

@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation ZZTextFieldTableViewCell

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _textField = [UITextField new];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.contentView addSubview:_textField];
}

#pragma mark - Override

- (void)updateConstraints {
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textField.superview).with.insets(UIEdgeInsetsMake(10, 20, 10, 10));
    }];
    
    [super updateConstraints];
}


@end
