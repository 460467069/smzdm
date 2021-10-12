//
//  UITextField+YYBBInputControl.h
//  YYBBSDKDemo
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

BOOL yybb_shouldChangeCharactersIn(id _Nullable target, NSRange range, NSString * _Nullable string);
void yybb_textDidChange(id _Nullable target);

typedef NS_ENUM(NSInteger, YYBBTextControlType) {
    YYBBTextControlType_none,               // 无限制
    YYBBTextControlType_number,             // 数字
    YYBBTextControlType_letter,             // 字母（包含大小写）
    YYBBTextControlType_letterSmall,        // 小写字母
    YYBBTextControlType_letterBig,          // 大写字母
    YYBBTextControlType_number_letterSmall, // 数字+小写字母
    YYBBTextControlType_number_letterBig,   // 数字+大写字母
    YYBBTextControlType_number_letter,      // 数字+字母
    
    YYBBTextControlType_excludeInvisible,   // 去除不可见字符（包括空格、制表符、换页符等）
    YYBBTextControlType_price,              // 价格（小数点后最多输入两位）
    YYBBTextControlType_decimalOne,         // 小数（小数点后最多输入一位)
    YYBBTextControlType_uInteger,           // 正整数不含0
    YYBBTextControlType_uInteger0,          // 整数含0
};


@interface YYBBInputControlProfile : NSObject

/**
 限制输入长度，NSUIntegerMax表示不限制（默认不限制）
 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 限制输入的文本类型（单选，在内部其实是配置了regularStr属性）
 */
@property (nonatomic, assign) YYBBTextControlType textControlType;

/**
 限制输入的正则表达式字符串
 */
@property (nonatomic, copy, nullable) NSString *regularStr;

/**
 文本变化回调（observer为UITextFiled或UITextView）
 */
@property (nonatomic, copy, nullable) void(^textChanged)(id observe);

/**
 添加文本变化监听
 @param target 方法接收者
 @param action 方法（方法参数为UITextFiled或UITextView）
 */
- (void)addTargetOfTextChange:(id)target action:(SEL)action;



/**
 链式配置方法（对应属性配置）
 */
+ (YYBBInputControlProfile *)creat;
- (YYBBInputControlProfile *(^)(YYBBTextControlType type))set_textControlType;
- (YYBBInputControlProfile *(^)(NSString *regularStr))set_regularStr;
- (YYBBInputControlProfile *(^)(NSUInteger maxLength))set_maxLength;
- (YYBBInputControlProfile *(^)(void (^textChanged)(id observe)))set_textChanged;
- (YYBBInputControlProfile *(^)(id target, SEL action))set_targetOfTextChange;



//键盘索引和键盘类型，当设置了 textControlType 内部会自动配置，当然你也可以自己配置
@property(nonatomic) UITextAutocorrectionType autocorrectionType;
@property(nonatomic) UIKeyboardType keyboardType;

//取消输入前回调的长度判断
@property (nonatomic, assign, readonly) BOOL cancelTextLengthControlBefore;
//文本变化方法体
@property (nonatomic, strong, nullable, readonly) NSInvocation *textChangeInvocation;

@end


@interface UITextField (YYBBInputControl) <UITextFieldDelegate>

@property (nonatomic, strong, nullable) YYBBInputControlProfile *yybb_inputCP;

@end


@interface UITextView (YYBBInputControl) <UITextViewDelegate>

@property (nonatomic, strong, nullable) YYBBInputControlProfile *yybb_inputCP;

@end


NS_ASSUME_NONNULL_END


