//
//  UITextField+ZZAdd.m
//  什么值得买
//
//  Created by Wang_ruzhou on 2017/4/30.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UITextField+ZZAdd.h"

@implementation UITextField (ZZAdd)
+ (UITextField *)yj_createTextFiled:(CGRect)frame
                           textFont:(UIFont *)font
                          textColor:(UIColor *)tColor
                        textAliType:(NSTextAlignment)aTextAliType
                        borderStyle:(UITextBorderStyle)style
                      leftViewWidth:(CGFloat)leftViewWidth
                  backgroundImgName:(NSString *)imgName
                    clearButtonMode:(UITextFieldViewMode)clearButtonMode
                       keyBoardType:(UIKeyboardType)keyBoardType
                           delegate:(id)delegate {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    if (font) {
        textField.font = font;
    }
    if (tColor) {
        textField.textColor = tColor;
    }
    if (imgName) {
        textField.background = [UIImage imageNamed:imgName];
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
