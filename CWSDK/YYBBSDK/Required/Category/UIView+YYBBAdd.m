//
//  UIView+YYBBAdd.m
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import "UIView+YYBBAdd.h"
#import <objc/runtime.h>
#import <YYCategories/UIView+YYAdd.h>
#import "UIImage+YYBBAdd.h"
#import <Masonry/Masonry.h>

@implementation UIView (YYBBAdd)

-(CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = cornerRadius > 0;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

+ (instancetype)loadNibFromBundle:(NSBundle *)bundle {
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    UIView *view = [bundle loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
    return view;
}

//获得某个范围内的屏幕图像
- (UIImage *)yybb_snapShotAtFrame:(CGRect)rect {
    UIImage *image = [self snapshotImage];
    return [image yybb_croppedImage:rect];
}

- (void)uninstalledConstraints {
    NSArray *installedConstraints = [MASViewConstraint installedConstraintsForView:self];
    for (MASConstraint *constraint in installedConstraints) {
        [constraint uninstall];
    }
}

+ (instancetype)loadNib {
    return [self loadNibFromBundle:nil];
}

@end
