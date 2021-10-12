//
//  UITextView+YYBB.h
//
//
//  Created by normal on 2016/11/14.
//  Copyright © 2016年 YYBB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextViewHeightDidChangedBlock)(CGFloat currentTextViewHeight);

@interface UITextView (YYBBAdd)

/* 占位文字 */
@property (nonatomic, copy) NSString *yybb_placeholder;

/* 占位文字颜色 */
@property (nonatomic, strong) UIColor *yybb_placeholderColor;

/* 最大高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat yybb_maxHeight;

/* 最小高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat yybb_minHeight;

@property (nonatomic, copy) TextViewHeightDidChangedBlock yybb_textViewHeightDidChanged;

/* 获取图片数组 */
- (NSArray *)yybb_getImages;

/* 自动高度的方法，maxHeight：最大高度 */
- (void)yybb_autoHeightWithMaxHeight:(CGFloat)maxHeight;

/* 自动高度的方法，maxHeight：最大高度， textHeightDidChanged：高度改变的时候调用 */
- (void)yybb_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(TextViewHeightDidChangedBlock)textViewHeightDidChanged;

/* 添加一张图片 image:要添加的图片 */
- (void)yybb_addImage:(UIImage *)image;

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)yybb_addImage:(UIImage *)image size:(CGSize)size;

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)yybb_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index;

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)yybb_addImage:(UIImage *)image multiple:(CGFloat)multiple;

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)yybb_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index;

@end
