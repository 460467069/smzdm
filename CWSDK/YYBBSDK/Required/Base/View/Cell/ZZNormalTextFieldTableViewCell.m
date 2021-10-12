//
//  ZZNormalTextFieldTableViewCell.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

static NSString * const kOnlyNum          = @"0123456789";
static NSString * const kOnlyLetter       = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static NSString * const kOnlyLetterAndNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

#import "ZZNormalTextFieldTableViewCell.h"
#import "YYBBProtocol.h"
#import <Masonry/Masonry.h>
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYText/NSAttributedString+YYText.h>
#import "NSString+YYBBAdd.h"

@interface ZZNormalTextFieldTableViewCell ()<UITextFieldDelegate, YYBBLayoutDelegate>

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZZNormalTextFieldTableViewCell

- (void)initUI {
    [self.contentView addSubview:self.normalTextField];
    [self.contentView addSubview:self.lineView];
}

- (void)setTextFieldform:(ZZTextFieldForm *)textFieldform {
    [super setTextFieldform:textFieldform];
    [self setNeedsUpdateTextField];
}

- (void)setNeedsUpdateTextField {
    self.normalTextField.keyboardType           = self.textFieldform.keyboardType;
    self.normalTextField.returnKeyType          = self.textFieldform.returnKeyType;
    self.normalTextField.clearButtonMode        = UITextFieldViewModeWhileEditing;
    self.normalTextField.secureTextEntry        = self.textFieldform.secureTextEntry;
    self.normalTextField.userInteractionEnabled = self.textFieldform.textFieldEnabled;
    self.normalTextField.placeholder            = self.textFieldform.placeholder;
    self.normalTextField.text                   = self.textFieldform.formText;
}

- (void)updateConstraints {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kTextFiledSpacing);
        make.right.offset(-kTextFiledSpacing);
        make.bottom.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.normalTextField.left   = self.titleLabel.right + kTextFiledSpacing;
    self.normalTextField.height = self.contentView.height;
    self.normalTextField.width  = self.contentView.width - self.normalTextField.left - kTextFiledSpacing;
}

#pragma mark- UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_textFieldDidEndEditingBlock) {
        NSString *resultText = [textField.text yybb_stringByTrimingWhitespace];
        _textFieldDidEndEditingBlock(resultText, self.textFieldform);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_textFieldShouldReturnBlock) {
        return _textFieldShouldReturnBlock(textField);
    }
    return [textField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *) textField {
    if (_textFieldDidChangeBlock) {
        _textFieldDidChangeBlock(textField, self.textFieldform);
    }
    self.textFieldform.formText = textField.text; //处理cell重用时,textfield内容被清空的情况
}

- (void)setTextFieldDidChangeBlock:(void (^)(UITextField *textField, ZZTextFieldForm *form))textFieldDidChangeBlock {
    if (_textFieldDidChangeBlock != textFieldDidChangeBlock) {
        _textFieldDidChangeBlock = textFieldDidChangeBlock;
    }
}

#pragma mark - Getter && Setter

- (UITextField *)normalTextField {
    if (!_normalTextField) {
        _normalTextField = [UITextField new];
        _normalTextField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] init];
        attributedPlaceholder.yy_color = [UIColor colorWithHexString:@"999999"];
        _normalTextField.attributedPlaceholder = attributedPlaceholder;
        _normalTextField.textColor = [UIColor colorWithHexString:@"333333"];
        _normalTextField.delegate = self;
        [_normalTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _normalTextField.enablesReturnKeyAutomatically = YES;
    }
    return _normalTextField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        _lineView.height = 0.5;
    }
    return _lineView;
}

- (void)delloc{
    [self.normalTextField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

@end
