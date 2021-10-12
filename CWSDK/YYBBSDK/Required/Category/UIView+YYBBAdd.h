//
//  UIView+YYBBAdd.h
//  YYBBSDK
//
//  Created by Wang_Ruzhou on 5/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYBBAdd)

//  圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
// 描框线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
// 描框颜色
@property (nonatomic, strong) IBInspectable UIColor* borderColor;
// 阴影模糊度
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;

+ (instancetype)loadNibFromBundle:(NSBundle *)bundle;

+ (instancetype)loadNib;


//获得某个范围内的屏幕图像
- (UIImage *)yybb_snapShotAtFrame:(CGRect)rect;
// 移除所有约束
- (void)uninstalledConstraints;

@end

NS_ASSUME_NONNULL_END
