//
//  UIStackView+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import "UIStackView+YYBBAdd.h"
#import <objc/runtime.h>
#import <YYCategories/UIView+YYAdd.h>
#import "UIImage+YYBBAdd.h"
#import <Masonry/Masonry.h>
#import "UIView+YYBBAdd.h"

static int _YYBBStackViewBgViewSetterKey;

@implementation UIStackView (YYBBAdd)

- (UIColor *)yybb_bgColor {
    UIView *setter = objc_getAssociatedObject(self, &_YYBBStackViewBgViewSetterKey);
    return setter.backgroundColor;
}

- (void)setYybb_bgColor:(UIColor *)yybb_bgColor {
    UIView *setter = [self yybb_contentView];
    setter.backgroundColor = yybb_bgColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    UIView *setter = [self yybb_contentView];
    
    setter.layer.masksToBounds = cornerRadius > 0;
    setter.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    UIView *setter = [self yybb_contentView];
    return setter.layer.cornerRadius;
}

- (UIView *)yybb_contentView {
    UIView *setter = objc_getAssociatedObject(self, &_YYBBStackViewBgViewSetterKey);
    if (!setter) {
        setter = [[UIView alloc] init];
//        setter.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
        objc_setAssociatedObject(self, &_YYBBStackViewBgViewSetterKey, setter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self insertSubview:setter atIndex:0];
        [setter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return setter;
}

@end
