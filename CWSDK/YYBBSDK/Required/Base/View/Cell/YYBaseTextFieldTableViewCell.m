//
//  YYBaseTextFieldTableViewCell.m
//  CoCoaPods
//
//  Created by Wang_Ruzhou on 11/7/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//


static NSString * const kOnlyNum          = @"0123456789";
static NSString * const kOnlyLetter       = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static NSString * const kOnlyLetterAndNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

#import "YYBaseTextFieldTableViewCell.h"
#import "NSString+YYBBAdd.h"

@implementation YYBaseTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    NSInteger maxLength = self.textFieldform.maxLength;
    if (maxLength > 0 && textField.text.length > maxLength) {
        textField.text = [[textField.text substringToIndex:maxLength] yybb_stringByTrimingWhitespace];
    }
    //处理cell重用时,textfield内容被清空的情况
    self.textFieldform.formText = textField.text;
    if (_textFieldDidChangeBlock) {
        _textFieldDidChangeBlock(textField, self.textFieldform);
    }
}

- (void)setTextFieldDidChangeBlock:(void (^)(UITextField *textField, ZZTextFieldForm *form))textFieldDidChangeBlock {
    if (_textFieldDidChangeBlock != textFieldDidChangeBlock) {
        _textFieldDidChangeBlock = textFieldDidChangeBlock;
    }
}

@end
