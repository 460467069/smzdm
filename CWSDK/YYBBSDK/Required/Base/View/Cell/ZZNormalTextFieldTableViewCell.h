//
//  ZZNormalTextFieldTableViewCell.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZBaseTextFieldTableViewCell.h"
#import "ZZTextFieldForm.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZNormalTextFieldTableViewCell : ZZBaseTextFieldTableViewCell

@property (nonatomic, strong) UITextField *normalTextField;

@property (nonatomic, copy) void(^textFieldDidEndEditingBlock)(NSString *textFieldText, ZZTextFieldForm *form);
@property (nonatomic, copy) BOOL(^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString,ZZTextFieldForm *form);
@property (nonatomic, copy) void(^textFieldDidChangeBlock)(UITextField *textField, ZZTextFieldForm *form);
@property (nonatomic, copy) BOOL(^textFieldShouldReturnBlock)(UITextField *textField);

@end

NS_ASSUME_NONNULL_END
