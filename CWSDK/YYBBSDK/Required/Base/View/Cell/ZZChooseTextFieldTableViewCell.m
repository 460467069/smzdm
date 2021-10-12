//
//  ZZChooseTextFieldTableViewCell.m
//
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "ZZChooseTextFieldTableViewCell.h"
#import <YYCategories/UIView+YYAdd.h>
#import "YYBBUtilsMacro.h"

@interface ZZChooseTextFieldTableViewCell ()<IQDropDownTextFieldDelegate>
@property (nonatomic, strong) IQDropDownTextField *dropDownTextField;
@end

@implementation ZZChooseTextFieldTableViewCell

- (void)initUI {
    [self.contentView addSubview:self.dropDownTextField];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setTextFieldform:(ZZTextFieldForm *)textFieldform {
    [super setTextFieldform:textFieldform];
    [self setNeedsUpdateTextField];
}

- (void)setNeedsUpdateTextField {
    self.dropDownTextField.itemList = self.textFieldform.itemList;
    self.dropDownTextField.placeholder = self.textFieldform.placeholder;
    self.dropDownTextField.selectedRow = self.textFieldform.defaultSelectedIndex;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dropDownTextField.left = self.titleLabel.right + YYBBDefaultPadding;
    self.dropDownTextField.height = self.contentView.height;
    self.dropDownTextField.width = self.contentView.width - self.dropDownTextField.left - YYBBDefaultPadding;
}

#pragma mark - IQDropDownTextFieldDelegate
- (void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item {
    
    if ([item isEqualToString:NSLocalizedString(@"Select", nil)]) {
        self.textFieldform.defaultSelectedIndex = 0;
    } else {
        NSInteger selectedRow = [self.textFieldform.itemList indexOfObject:item];
        self.textFieldform.defaultSelectedIndex = selectedRow + 1;
    }
    if ([self.delegate respondsToSelector:@selector(chooseTextFieldTableViewCellDidSelecItem:)]) {
        [self.delegate chooseTextFieldTableViewCellDidSelecItem:self];
    }
}

#pragma mark- Custom Access
- (IQDropDownTextField *)dropDownTextField {
    if (!_dropDownTextField) {
        _dropDownTextField = [IQDropDownTextField new];
        _dropDownTextField.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        _dropDownTextField.delegate = self;
    }
    return _dropDownTextField;
}

@end
