//
//  ZZTextFieldForm.m
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

static int const kYYMaxPhoneNumLength = 11;
static int const kYYMaxLoginPwdLength = 16;
static int const kYYMaxSMSCodeLength  = 4;
static int const kYYMaxPayPwdLength   = 6;
static int const kYYMaxIDCardLength   = 18;

#import "ZZTextFieldForm.h"
#import <YYCategories/UIColor+YYAdd.h>

@implementation ZZTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        _textFieldEnabled = YES;
        _keyboardType = UIKeyboardTypeDefault;
        _isOptionalDropDown = YES;
        _clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFiledTextColor = [UIColor colorWithHexString:@"333333"];
    }
    return self;
}

+ (instancetype)optionWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    ZZTextFieldForm *option = [self optionWithImage:nil title:title subTitle:nil];
    option.placeholder = placeholder;
    return option;
}

+ (instancetype)optionWithImage:(UIImage *)image title:(NSString *)title placeholder:(NSString *)placeholder {
    ZZTextFieldForm *option = [self optionWithImage:image title:title subTitle:nil];
    option.placeholder = placeholder;
    return option;
}

@end

@implementation ZZPhoneTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxLength = kYYMaxPhoneNumLength;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

@end

@implementation ZZLoginPwdTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.secureTextEntry = YES;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.maxLength = kYYMaxLoginPwdLength;
    }
    return self;
}

@end


@implementation ZZSMSCodeTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxLength = kYYMaxSMSCodeLength;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

@end

@implementation ZZPayPwdTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.secureTextEntry = YES;
        self.maxLength = kYYMaxPayPwdLength;
    }
    return self;
}
@end

@implementation ZZIDCardTextFieldForm

- (instancetype)init {
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.maxLength = kYYMaxIDCardLength;
    }
    return self;
}
@end

