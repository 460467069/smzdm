//
//  YYBaseTextFieldTableViewCell.h
//  CoCoaPods
//
//  Created by Wang_Ruzhou on 11/7/19.
//  Copyright © 2019 Wang_Ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBBBaseTableViewCell.h"
#import "ZZTextFieldForm.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBaseTextFieldTableViewCell : YYBBBaseTableViewCell

@property (nonatomic, strong) ZZTextFieldForm *textFieldform;

@property (nonatomic, copy) void(^textFieldDidEndEditingBlock)(NSString *textFieldText, ZZTextFieldForm *form);
@property (nonatomic, copy) BOOL(^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString,ZZTextFieldForm *form);
@property (nonatomic, copy) void(^textFieldDidChangeBlock)(UITextField *textField, ZZTextFieldForm *form);
@property (nonatomic, copy) BOOL(^textFieldShouldReturnBlock)(UITextField *textField);

- (void)textFieldDidChange:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
