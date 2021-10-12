//
//  YBCPhoneTextField.h
//  BloothSmoking
//
//  Created by Wang_Ruzhou on 11/12/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import "YYBBLimitConstants.h"
#import "JVFloatLabeledTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBBFloatLimitTextField : JVFloatLabeledTextField<UITextFieldDelegate>

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger inputLimit;
#else
@property (nonatomic, assign) ZZTextFieldInputLimit inputLimit;
#endif

@property (nonatomic, assign) IBInspectable NSInteger maxLength;

@end

NS_ASSUME_NONNULL_END
