//
//  YYBBBottomView.h
//  YunYin
//
//  Created by Wang_Ruzhou on 12/6/19.
//  Copyright © 2019 云印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YCShadowView/YCShadowView.h>

// 高度
FOUNDATION_EXPORT CGFloat const kBottomViewHeight;

@class YYBBBottomViewAction;
typedef void(^YYBBBottomViewActionBlock)(YYBBBottomViewAction * _Nullable action);

NS_ASSUME_NONNULL_BEGIN


@interface YYBBBottomViewAction : NSObject

@property (nullable, nonatomic) NSString *title;
@property (nullable, nonatomic, readonly) UIColor *bgColor;
@property (nullable, nonatomic, readonly) UIColor *borderColor;
@property (nonatomic, copy, readonly) YYBBBottomViewActionBlock actionBlock;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, assign) BOOL yybb_isLoading;
@property (nullable, nonatomic) UIButton *btn;
@property (nonatomic, assign, readonly) UIAlertActionStyle style;

+ (instancetype)actionWithTitle:(nullable NSString *)title
                        bgColor:(nullable UIColor *)bgColor
                    borderColor:(nullable UIColor *)borderColor
                        handler:(nullable YYBBBottomViewActionBlock)handler;

+ (instancetype)actionWithTitle:(nullable NSString *)title
                          style:(UIAlertActionStyle)style
                        handler:(nullable YYBBBottomViewActionBlock)handler;

@end

@interface YYBBBottomView : YCShadowView

- (void)addAction:(YYBBBottomViewAction *)action;

@end

NS_ASSUME_NONNULL_END
