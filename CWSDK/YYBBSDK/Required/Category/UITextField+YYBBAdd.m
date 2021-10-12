//
//  UITextField+YYBBAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UITextField+YYBBAdd.h"
#import <YYCategories/UIView+YYAdd.h>

@implementation UITextField (YYBBAdd)
+ (instancetype)yybb_createTextFiled:(CGRect)frame
                             textFont:(UIFont *)font
                            textColor:(UIColor *)tColor
                          textAliType:(NSTextAlignment)aTextAliType
                          borderStyle:(UITextBorderStyle)style
                        leftViewWidth:(CGFloat)leftViewWidth
                        backgroundImg:(UIImage *)backgroundImg
                      clearButtonMode:(UITextFieldViewMode)clearButtonMode
                         keyBoardType:(UIKeyboardType)keyBoardType
                             delegate:(id)delegate {
    UITextField *textField = [[self alloc] initWithFrame:frame];
    if (font) {
        textField.font = font;
    }
    if (tColor) {
        textField.textColor = tColor;
    }
    if (backgroundImg) {
        textField.background = backgroundImg;
    }
    textField.borderStyle     = style;
    textField.returnKeyType   = UIReturnKeyNext;
    textField.delegate        = delegate;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor clearColor];
    textField.keyboardType    = keyBoardType;
    textField.clearButtonMode = clearButtonMode;
    [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [textField setTextAlignment:aTextAliType];
    
    if (leftViewWidth) {
        UIView *leftView = [[UIView alloc] init];
        leftView.width = leftViewWidth;
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return textField;
}

@end
