//
//  ZZBaseTextFieldTableViewCell.h
//  
//
//  Created by Wang_ruzhou on 2017/2/27.
//  Copyright © 2017年 Wang_ruzhou. All rights reserved.
//

#import "YYBBSpaceInsetsLabel.h"
#import "ZZTextFieldForm.h"
#import "YYBBBaseTableViewCell.h"

@interface ZZBaseTextFieldTableViewCell : YYBBBaseTableViewCell

@property (nonatomic, strong) ZZTextFieldForm *textFieldform;

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) YYBBSpaceInsetsLabel *titleLabel;
@property (nonatomic) CGSize  titleLabelSize;

@end
