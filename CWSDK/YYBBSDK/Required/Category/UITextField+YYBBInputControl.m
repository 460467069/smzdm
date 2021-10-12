//
//  UITextField+YYBBInputControl.m
//  YYBBSDKDemo
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "UITextField+YYBBInputControl.h"
#import <objc/runtime.h>

static const void *key_Profile = &key_Profile;
static const void *key_tempDelegate = &key_tempDelegate;


/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
BOOL isNineKeyBoard(NSString *string)
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}


BOOL stringContainsEmoji(NSString *string)
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (isMatch) {
        return YES;
    }
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
            
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                // 区分九宫格输入 U+278b u'➋' -  U+2792 u'➒'
                if (0x278b <= hs && hs <= 0x2792) {
                    returnValue = NO;
                    // 九宫格键盘上 “^-^” 键所对应的为符号 ☻
                } else if (0x263b == hs) {
                    returnValue = NO;
                } else {
                    returnValue = YES;
                }
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}

static BOOL judgeRegular(NSString *contentStr, NSString *regularStr) {
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regularStr options:0 error:&error];
    if (error) {
        return YES;
    }
    NSArray *results = [regex matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)];
    return results.count > 0;
}
BOOL yybb_shouldChangeCharactersIn(id target, NSRange range, NSString *string) {
    if (!target) {
        return YES;
    }
    
    if ([target isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)target;
        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
            return NO;
        }
    } else if ([target isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)target;
        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
            return NO;
        }
    }
    
    if (isNineKeyBoard(string)) {
        return YES;
    }
    // 判断 emoji 表情
    if (stringContainsEmoji(string)) {
        return NO;
    }
    YYBBInputControlProfile *profile = objc_getAssociatedObject(target, key_Profile);
    if (!profile) {
        return YES;
    }
    //计算若输入成功的字符串
    NSString *nowStr = [target valueForKey:@"text"];
    NSMutableString *resultStr = [NSMutableString stringWithString:nowStr];
    if (string.length == 0) {
        [resultStr deleteCharactersInRange:range];
    } else {
        if (range.length == 0) {
            [resultStr insertString:string atIndex:range.location];
        } else {
            [resultStr replaceCharactersInRange:range withString:string];
        }
    }
    //长度判断
    if (profile.maxLength != NSUIntegerMax) {
        if (!profile.cancelTextLengthControlBefore && resultStr.length > profile.maxLength) {
            return NO;
        }
    }
    //正则表达式匹配
    if (resultStr.length > 0) {
        if (!profile.regularStr || profile.regularStr.length <= 0) {
            return YES;
        }
        return judgeRegular(resultStr, profile.regularStr);
    }
    return YES;
}
void yybb_textDidChange(id target) {
    if (!target) {
        return;
    }
    YYBBInputControlProfile *profile = objc_getAssociatedObject(target, key_Profile);
    if (!profile) {
        return;
    }
    //内容适配
    if (profile.maxLength != NSUIntegerMax && [target valueForKey:@"markedTextRange"] == nil) {
        NSString *resultText = [target valueForKey:@"text"];
        if ([target isKindOfClass:UITextView.class]) {
            //如果是 UITextView, 不需要过滤空格，未超过最大限制也不要调用 setText: 方法（setText:会导致光标自动移动到尾部）
            if (resultText.length > profile.maxLength) {
                [target setValue:[resultText substringToIndex:profile.maxLength] forKey:@"text"];
            }
        } else if ([target isKindOfClass:UITextField.class]) {
            //先内容过滤
            if (profile.textControlType == YYBBTextControlType_excludeInvisible) {
                resultText = [[target valueForKey:@"text"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            //再判断长度
            if (resultText.length > profile.maxLength) {
                [target setValue:[resultText substringToIndex:profile.maxLength] forKey:@"text"];
            } else {
                [target setValue:resultText forKey:@"text"];
            }
        }
    }
    //回调
    if (profile.textChangeInvocation) {
        [profile.textChangeInvocation setArgument:&target atIndex:2];
        [profile.textChangeInvocation invoke];
    }
    if (profile.textChanged) {
        profile.textChanged(target);
    }
}



@interface YYBBInputControlProfile ()
@property (nonatomic, assign) BOOL cancelTextLengthControlBefore;
@property (nonatomic, strong, nullable) NSInvocation *textChangeInvocation;
@end
@implementation YYBBInputControlProfile
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxLength = NSUIntegerMax;
    }
    return self;
}
- (void)addTargetOfTextChange:(id)target action:(SEL)action {
    NSInvocation *invocation = nil;
    if (target && action) {
        invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
        invocation.target = target;
        invocation.selector = action;
    }
    self.textChangeInvocation = invocation;
}
- (void)setTextControlType:(YYBBTextControlType)textControlType {
    _textControlType = textControlType;
    
    switch (textControlType) {
        case YYBBTextControlType_none: {
            self.regularStr = @"";
            self.keyboardType = UIKeyboardTypeDefault;
            self.autocorrectionType = UITextAutocorrectionTypeDefault;
            self.cancelTextLengthControlBefore = YES;
        }
            break;
        case YYBBTextControlType_number: {
            self.regularStr = @"^[0-9]*$";
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_letter: {
            self.regularStr = @"^[a-zA-Z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_letterSmall: {
            self.regularStr = @"^[a-z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_letterBig: {
            self.regularStr = @"^[A-Z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_number_letter: {
            self.regularStr = @"^[0-9a-zA-Z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_number_letterSmall: {
            self.regularStr = @"^[0-9a-z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_number_letterBig: {
            self.regularStr = @"^[0-9A-Z]*$";
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_price: {
            NSString *tempStr = self.maxLength == NSUIntegerMax?@"":[NSString stringWithFormat:@"%ld", (unsigned long)self.maxLength];
            self.regularStr = [NSString stringWithFormat:@"^(([1-9]\\d{0,%@})|0)(\\.\\d{0,2})?$", tempStr];
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
            
        case YYBBTextControlType_decimalOne: {
            NSString *tempStr = self.maxLength == NSUIntegerMax?@"":[NSString stringWithFormat:@"%ld", (unsigned long)self.maxLength];
            self.regularStr = [NSString stringWithFormat:@"^(([1-9]\\d{0,%@})|0)(\\.\\d{0,1})?$", tempStr];
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
        }
            break;
        case YYBBTextControlType_excludeInvisible: {
            self.regularStr = @"";
            self.keyboardType = UIKeyboardTypeDefault;
            self.autocorrectionType = UITextAutocorrectionTypeDefault;
            self.cancelTextLengthControlBefore = YES;
            break;
        }
        case YYBBTextControlType_uInteger: {
            self.regularStr = @"^[0-9]*[1-9][0-9]*$";
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
            break;
        }
        case YYBBTextControlType_uInteger0: {
            self.regularStr = @"^(0|[1-9][0-9]*)$";
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.cancelTextLengthControlBefore = NO;
            break;
        }
        default:
            break;
    }
}
+ (YYBBInputControlProfile *)creat {
    YYBBInputControlProfile *profile = [YYBBInputControlProfile new];
    return profile;
}
- (YYBBInputControlProfile * _Nonnull (^)(YYBBTextControlType))set_textControlType {
    return ^YYBBInputControlProfile* (YYBBTextControlType type) {
        self.textControlType = type;
        return self;
    };
}
- (YYBBInputControlProfile * _Nonnull (^)(NSString * _Nonnull))set_regularStr {
    return ^YYBBInputControlProfile* (NSString *regularStr) {
        self.regularStr = regularStr;
        return self;
    };
}
- (YYBBInputControlProfile * _Nonnull (^)(NSUInteger))set_maxLength {
    return ^YYBBInputControlProfile* (NSUInteger maxLength) {
        self.maxLength = maxLength;
        return self;
    };
}
- (YYBBInputControlProfile * _Nonnull (^)(void (^ _Nonnull)(id _Nonnull)))set_textChanged {
    return ^YYBBInputControlProfile *(void (^block)(id observe)) {
        if (block) {
            self.textChanged = ^(id observe) {
                block(observe);
            };
        }
        return self;
    };
}
- (YYBBInputControlProfile * _Nonnull (^)(id _Nonnull, SEL _Nonnull))set_targetOfTextChange {
    return ^YYBBInputControlProfile *(id target, SEL action) {
        [self addTargetOfTextChange:target action:action];
        return self;
    };
}
@end


@interface YYBBInputControlTempDelegate : NSObject <UITextFieldDelegate>
@property (nonatomic, weak) id delegate_inside;
@property (nonatomic, weak) id delegate_outside;
@property (nonatomic, strong) Protocol *protocol;
@end
@implementation YYBBInputControlTempDelegate
- (BOOL)respondsToSelector:(SEL)aSelector {
    struct objc_method_description des = protocol_getMethodDescription(self.protocol, aSelector, NO, YES);
    if (des.types == NULL) {
        return [super respondsToSelector:aSelector];
    }
    if ([self.delegate_inside respondsToSelector:aSelector] || [self.delegate_outside respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    BOOL isResponds = NO;
    if ([self.delegate_inside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_inside];
    }
    if ([self.delegate_outside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_outside];
    }
    if (!isResponds) {
        [self doesNotRecognizeSelector:sel];
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig_inside = [self.delegate_inside methodSignatureForSelector:aSelector];
    NSMethodSignature *sig_outside = [self.delegate_outside methodSignatureForSelector:aSelector];
    NSMethodSignature *result_sig = sig_inside?:sig_outside?:nil;
    return result_sig;
}
- (Protocol *)protocol {
    if (!_protocol) {
        if ([self.delegate_inside isKindOfClass:UITextField.self]) {
            _protocol = objc_getProtocol("UITextFieldDelegate");
        }
    }
    return _protocol;
}
@end


@implementation UITextField (YYBBInputControl)
#pragma mark insert logic to selector--setDelegate:
+ (void)load {
    if ([NSStringFromClass(self) isEqualToString:@"UITextField"]) {
        Method m1 = class_getInstanceMethod(self, @selector(setDelegate:));
        Method m2 = class_getInstanceMethod(self, @selector(customSetDelegate:));
        if (m1 && m2) {
            method_exchangeImplementations(m1, m2);
        }
    }
}
- (void)customSetDelegate:(id)delegate {
    @synchronized(self) {
        if (objc_getAssociatedObject(self, key_Profile)) {
            YYBBInputControlTempDelegate *tempDelegate = [YYBBInputControlTempDelegate new];
            tempDelegate.delegate_inside = self;
            if (self.delegate && delegate == self) {
                tempDelegate.delegate_outside = self.delegate;
            } else {
                tempDelegate.delegate_outside = delegate;
            }
            [self customSetDelegate:tempDelegate];
            objc_setAssociatedObject(self, key_tempDelegate, tempDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            [self customSetDelegate:delegate];
        }
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.delegate) {
            self.delegate = self;
        }
    });
}

#pragma mark getter setter

- (void)setYybb_inputCP:(YYBBInputControlProfile *)yybb_inputCP {
    @synchronized(self) {
        if (yybb_inputCP && [yybb_inputCP isKindOfClass:YYBBInputControlProfile.self]) {
            objc_setAssociatedObject(self, key_Profile, yybb_inputCP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            self.delegate = self;
            self.keyboardType = yybb_inputCP.keyboardType;
            self.autocorrectionType = yybb_inputCP.autocorrectionType;
            yybb_inputCP.textChangeInvocation || yybb_inputCP.textChanged ? [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents : UIControlEventEditingChanged]:nil;
        } else {
            objc_setAssociatedObject(self, key_Profile, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
- (YYBBInputControlProfile *)yybb_inputCP {
    return objc_getAssociatedObject(self, key_Profile);
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) return YES;
    return yybb_shouldChangeCharactersIn(textField, range, string);
}
- (void)textFieldDidChange:(UITextField *)textField {
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) return;
    yybb_textDidChange(textField);
}

@end


@implementation UITextView (YYBBInputControl)

#pragma mark getter setter

- (void)setYybb_inputCP:(YYBBInputControlProfile *)yybb_inputCP {
    @synchronized(self) {
        if (yybb_inputCP && [yybb_inputCP isKindOfClass:YYBBInputControlProfile.self]) {
            objc_setAssociatedObject(self, key_Profile, yybb_inputCP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            self.delegate = self;
            self.keyboardType = yybb_inputCP.keyboardType;
            self.autocorrectionType = yybb_inputCP.autocorrectionType;
        } else {
            objc_setAssociatedObject(self, key_Profile, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
- (YYBBInputControlProfile *)yybb_inputCP {
    return objc_getAssociatedObject(self, key_Profile);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.delegate) {
            self.delegate = self;
        }
    });
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) return YES;
    return yybb_shouldChangeCharactersIn(textView, range, text);
}
- (void)textViewDidChange:(UITextView *)textView {
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) return;
    yybb_textDidChange(textView);
}

@end

