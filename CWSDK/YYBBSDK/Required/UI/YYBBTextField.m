//
//  YYBBTextField.m
//  YYBBSDK
//
//  Created by Kris Liu on 9/23/17.
//  Copyright © 2017 Wang_ruzhou. All rights reserved.
//

#import "YYBBTextField.h"
#import <YYText/NSAttributedString+YYText.h>
#import "UIColor+YYBBAdd.h"
#import "UIView+YYBBAdd.h"
#import "NSObject+YYBBAdd.h"
#import <YYCategories/UIView+YYAdd.h>

@interface YYBBTextField ()

@end

@implementation YYBBTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    self.cornerRadius = 2;
    self.textColor = [UIColor yybb_blackColor];
    [self configureAttributedPlaceholder:self.placeholder];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self configureAttributedPlaceholder:placeholder];
}


- (void)configureAttributedPlaceholder:(NSString *)placeholder {
    if (![placeholder yybb_isNotEmpty]) {
        return;
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:placeholder];
        one.yy_font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        one.yy_color = [UIColor yybb_placeHolderColor];
        [text appendAttributedString:one.copy];
    }
    
    self.attributedPlaceholder = text;
}

- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    if (leftViewWidth) {
        UIView *leftView = [[UIView alloc] init];
        leftView.width = leftViewWidth;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
}

- (void)setRightViewWidth:(CGFloat)rightViewWidth {
    if (rightViewWidth) {
        UIView *rightView = [[UIView alloc] init];
        rightView.width = rightViewWidth;
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end
