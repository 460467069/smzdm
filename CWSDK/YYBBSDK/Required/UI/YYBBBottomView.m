//
//  YYBBBottomView.m
//  YunYin
//
//  Created by Wang_Ruzhou on 12/6/19.
//  Copyright © 2019 云印. All rights reserved.
//

#import "YYBBBottomView.h"
#import <YYCategories/YYCGUtilities.h>
#import <YYCategories/YYCategoriesMacro.h>
#import <YYCategories/UIView+YYAdd.h>
#import <YYCategories/UIColor+YYAdd.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <Masonry/Masonry.h>
#import "YYBBUtilsMacro.h"
#import "UIButton+YYBBAdd.h"
#import "UIColor+YYBBAdd.h"
#import "UIButton+ActivityIndicatorView.h"
#import "YYBBFontUtilities.h"

CGFloat const kBottomViewHeight = 44;
static CGFloat const kStackViewHeight  = 44;
static CGFloat const kStackViewTop     = 0;
static CGFloat const kStackViewLeft    = 15;

@interface YYBBBottomViewAction ()

@property (nullable, nonatomic) UIColor *bgColor;
@property (nullable, nonatomic) UIColor *borderColor;
@property (nonatomic, copy) YYBBBottomViewActionBlock actionBlock;
@property (nonatomic, assign) UIAlertActionStyle style;

@end

@implementation YYBBBottomViewAction
+ (instancetype)actionWithTitle:(nullable NSString *)title
                        bgColor:(nullable UIColor *)bgColor
                    borderColor:(nullable UIColor *)borderColor
                        handler:(nullable YYBBBottomViewActionBlock)handler {
    YYBBBottomViewAction *action = [[YYBBBottomViewAction alloc] init];
    action.title = title;
    action.bgColor = bgColor;
    action.borderColor = borderColor;
    action.actionBlock = handler;
    action.enabled = YES;
    return action;
}

+ (instancetype)actionWithTitle:(nullable NSString *)title
                          style:(UIAlertActionStyle)style
                        handler:(YYBBBottomViewActionBlock)handler {
    
    YYBBBottomViewAction *action = [[YYBBBottomViewAction alloc] init];
    action.title = title;
    if (style == UIAlertActionStyleCancel) {
        action.bgColor = [UIColor whiteColor];
        action.borderColor = [UIColor yybb_redColor];
    } else if (style == UIAlertActionStyleDefault) {
        action.bgColor = [UIColor yybb_redColor];
        action.borderColor = [UIColor yybb_redColor];
    }
    action.style = style;
    action.actionBlock = handler;
    action.enabled = YES;
    return action;
}


- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    self.btn.enabled = enabled;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    [self.btn setTitle:title forState:UIControlStateNormal];
}

- (void)setYybb_isLoading:(BOOL)yybb_isLoading {
    _yybb_isLoading = yybb_isLoading;
    
    if (yybb_isLoading) {
        [self.btn startAnimation:UIActivityIndicatorViewStyleWhite];
    } else {
        [self.btn stopAnimation];
    }
}

@end

@interface YYBBBottomView ()

@property (nonatomic, strong) NSMutableArray<YYBBBottomViewAction *> *actions;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation YYBBBottomView

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
    self.backgroundColor = [UIColor whiteColor];
    CGFloat height = 0;
    if (isIPhoneXSeries()) {
        height = kBottomViewHeight - kStackViewTop;
    } else {
        height = kBottomViewHeight;
    }
    self.width = kScreenWidth;
    self.height = height;
    [self addSubview:self.stackView];
}

- (void)addAction:(YYBBBottomViewAction *)action {
    [self.actions addObject:action];
}

- (void)didMoveToSuperview {
    if (self.superview == nil) {
        return;
    }
    [self updateBottomView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (isIPhoneXSeries()) {
        self.bottom = self.superview.height - YYBBBottomHeight();
    } else {
        self.bottom = self.superview.height - YYBBDefaultPadding;
    }
    self.stackView.left = kStackViewLeft;
    self.stackView.top = kStackViewTop;
    self.stackView.width = self.width - kStackViewLeft * 2;
    self.stackView.height = kStackViewHeight;
}

#pragma mark - Private
- (void)updateBottomView {
    @weakify(self)
    [self.actions enumerateObjectsUsingBlock:^(YYBBBottomViewAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        UIButton *btn = [UIButton yybb_buttonWithTarget:self
                                                 action:@selector(btnDidClick:)
                                                  frame:CGRectZero
                                              imageName:nil
                                             titleColor:[UIColor whiteColor]
                                              titleFont:YYBBFont16()
                                        backgroundColor:[UIColor clearColor]
                                           cornerRadius:kBottomViewHeight * 0.5
                                            borderWidth:0
                                            borderColor:action.borderColor
                                                  title:action.title];
        btn.tag = idx;
        action.btn = btn;
        btn.enabled = action.enabled;
        [btn setBackgroundImage:[UIImage imageWithColor:action.bgColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColorHex(CCCCCC)] forState:UIControlStateDisabled];
        [self.stackView addArrangedSubview:btn];
    }];
}

- (void)btnDidClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    YYBBBottomViewAction *action = self.actions[tag];
    YYBBBottomViewActionBlock actionBlock = action.actionBlock;
    !actionBlock ?: actionBlock(action);
}

#pragma mark - Getter && Setter

- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 0;
        _stackView.alignment = UIStackViewAlignmentFill;
    }
    return _stackView;
}

- (CGSize)intrinsicContentSize {
    CGFloat height = 0;
    if (isIPhoneXSeries()) {
        height = kBottomViewHeight - kStackViewTop;
    } else {
        height = kBottomViewHeight;
    }
    return CGSizeMake(kScreenWidth, height);
}

@end
