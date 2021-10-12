//
//  ZZTextFieldForm.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

static CGFloat const kTextFiledSpacing = 25.0;

typedef NS_ENUM(NSUInteger, ZZTextFieldType) {
    ZZTextFieldTypeInput,
    ZZTextFieldTypeChoose
};

#import "ZZTableViewRowOption.h"
#import <IQDropDownTextField/IQDropDownTextField.h>

@interface ZZTextFieldForm : ZZTableViewRowOption

@property (nonatomic, assign) BOOL isRequired;                  // 是否必填
@property (nonatomic,   copy) NSArray <NSString*> *itemList;
@property (nonatomic,   copy) NSString *placeholder;
@property (nonatomic,   copy) NSString *formText;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;
@property (nonatomic, assign) ZZTextFieldType textFieldType;
@property (nonatomic,   copy) NSString *optionalItemText;
@property (nonatomic,   copy) NSString *selectedItem;
@property (nonatomic, assign) IQDropDownMode dropDownMode;
@property (nonatomic,   copy) NSDate *date;
@property (nonatomic, assign) BOOL isOptionalDropDown;
@property (nonatomic, assign) CGFloat characterSpacing;

@property (nonatomic,   copy) NSString *valueKey;
@property (nonatomic, assign) NSInteger  maxLength;
@property (nonatomic, assign) UIReturnKeyType returnKeyType;
@property (nonatomic, assign) UIKeyboardType  keyboardType;
@property (nonatomic, assign) UITextFieldViewMode  clearButtonMode;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) BOOL hasSubTitle;
@property (nonatomic, assign) BOOL allowJump;
@property (nonatomic, assign) BOOL isCashInput;
@property (nonatomic, assign) BOOL textFieldEnabled;    //用户交互
@property (nonatomic, assign) BOOL shouldHiddenVerificationCode;    //是否隐藏获取验证码按钮
@property (nonatomic, assign) CGFloat trailing;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UITextAutocorrectionType correctionType;
@property (nonatomic, strong) UIColor *textFiledTextColor;

+ (instancetype)optionWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

+ (instancetype)optionWithImage:(NSString *)imageStr title:(NSString *)title placeholder:(NSString *)placeholder;

@end


@interface ZZPhoneTextFieldForm : ZZTextFieldForm

@end

@interface ZZLoginPwdTextFieldForm : ZZTextFieldForm

@end

@interface ZZSMSCodeTextFieldForm : ZZTextFieldForm

@end

@interface ZZPayPwdTextFieldForm : ZZTextFieldForm

@end

@interface ZZIDCardTextFieldForm : ZZTextFieldForm

@end

