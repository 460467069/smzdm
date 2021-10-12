//
//  YBCPhoneTextField.m
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 11/12/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBFloatLimitTextField.h"

@implementation YYBBFloatLimitTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    self.delegate = self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 长度限制
    // 输入类型限定
    ZZTextFieldInputLimit inputLimit = self.inputLimit;
    NSString *aString = nil;
    switch (inputLimit) {
        case ZZTextFieldInputUnLimit:
            break;
        case ZZTextFieldInputLimitNum:
            aString = kOnlyNum;
            break;
        case ZZTextFieldInputLimitLetter:
            aString = kOnlyLetter;
            break;
        case ZZTextFieldInputLimitLetterAndNum:
            aString = kOnlyLetterAndNum;
            break;
        default:
            break;
    }
    // 内容限制
    BOOL inputContentValid;
    if (inputLimit == ZZTextFieldInputUnLimit) {
        inputContentValid = YES;
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:aString] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        inputContentValid = [string isEqualToString:filtered];
    }
    
    // 长度限制
    BOOL lengthValid;
    if (self.maxLength <= 0) {
        lengthValid = YES;
    } else {
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        lengthValid = newLength <= self.maxLength || returnKey;
    }
    
    return inputContentValid && lengthValid;
}



@end
