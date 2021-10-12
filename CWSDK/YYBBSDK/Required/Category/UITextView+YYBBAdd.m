//
//  UITextView+YYBB.m
//  YYBBTextView-demo
//
//  Created by normal on 2016/11/14.
//  Copyright © 2016年 YYBB. All rights reserved.
//

#import "UITextView+YYBBAdd.h"
#import <objc/runtime.h>

// 占位文字
static const void *YYBBPlaceholderViewKey = &YYBBPlaceholderViewKey;
// 占位文字颜色
static const void *YYBBPlaceholderColorKey = &YYBBPlaceholderColorKey;
// 最大高度
static const void *YYBBTextViewMaxHeightKey = &YYBBTextViewMaxHeightKey;
// 最小高度
static const void *YYBBTextViewMinHeightKey = &YYBBTextViewMinHeightKey;
// 高度变化的block
static const void *YYBBTextViewHeightDidChangedBlockKey = &YYBBTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *YYBBTextViewImageArrayKey = &YYBBTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *YYBBTextViewLastHeightKey = &YYBBTextViewLastHeightKey;

@interface UITextView ()

// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *yybb_imageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation UITextView (YYBBAdd)

#pragma mark - Swizzle Dealloc
+ (void)load {
    // 交换dealoc
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
}

- (void)myDealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    UITextView *placeholderView = objc_getAssociatedObject(self, YYBBPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        for (NSString *property in propertys) {
            @try {
                [self removeObserver:self forKeyPath:property];
            } @catch (NSException *exception) {}
        }
    }
    [self myDealloc];
}

#pragma mark - set && get
- (UITextView *)yybb_placeholderView {
    
    // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
    UITextView *placeholderView = objc_getAssociatedObject(self, YYBBPlaceholderViewKey);
    
    if (!placeholderView) {
        
        // 初始化数组
        self.yybb_imageArray = [NSMutableArray array];
        
        placeholderView = [[UITextView alloc] init];
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, YYBBPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        
        // 设置基本属性
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
//        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
        placeholderView.textColor = [UIColor lightGrayColor];
        placeholderView.backgroundColor = [UIColor clearColor];
        [self refreshPlaceholderView];
        [self addSubview:placeholderView];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        
        // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
        
    }
    return placeholderView;
}

- (void)setYybb_placeholder:(NSString *)placeholder
{
    // 为placeholder赋值
    [self yybb_placeholderView].text = placeholder;
}

- (NSString *)yybb_placeholder
{
    // 如果有placeholder值才去调用，这步很重要
    if (self.placeholderExist) {
        return [self yybb_placeholderView].text;
    }
    return nil;
}

- (void)setYybb_placeholderColor:(UIColor *)yybb_placeholderColor
{
    // 如果有placeholder值才去调用，这步很重要
    if (!self.placeholderExist) {
        NSLog(@"请先设置placeholder值！");
    } else {
        self.yybb_placeholderView.textColor = yybb_placeholderColor;
        
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, YYBBPlaceholderColorKey, yybb_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)yybb_placeholderColor
{
    return objc_getAssociatedObject(self, YYBBPlaceholderColorKey);
}

- (void)setYybb_maxHeight:(CGFloat)yybb_maxHeight
{
    CGFloat max = yybb_maxHeight;
    
    // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
    if (yybb_maxHeight < self.frame.size.height) {
        max = self.frame.size.height;
    }
    
    objc_setAssociatedObject(self, YYBBTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)yybb_maxHeight
{
    return [objc_getAssociatedObject(self, YYBBTextViewMaxHeightKey) doubleValue];
}

- (void)setYybb_minHeight:(CGFloat)yybb_minHeight
{
    objc_setAssociatedObject(self, YYBBTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", yybb_minHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)yybb_minHeight
{
    return [objc_getAssociatedObject(self, YYBBTextViewMinHeightKey) doubleValue];
}

- (void)setYybb_textViewHeightDidChanged:(TextViewHeightDidChangedBlock)yybb_textViewHeightDidChanged
{
    objc_setAssociatedObject(self, YYBBTextViewHeightDidChangedBlockKey, yybb_textViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextViewHeightDidChangedBlock)yybb_textViewHeightDidChanged
{
    void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, YYBBTextViewHeightDidChangedBlockKey);
    return textViewHeightDidChanged;
}

- (NSArray *)yybb_getImages
{
    return self.yybb_imageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight {
    objc_setAssociatedObject(self, YYBBTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight {
    return [objc_getAssociatedObject(self, YYBBTextViewLastHeightKey) doubleValue];
}

- (void)setYybb_imageArray:(NSMutableArray *)yybb_imageArray {
    objc_setAssociatedObject(self, YYBBTextViewImageArrayKey, yybb_imageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)yybb_imageArray {
    return objc_getAssociatedObject(self, YYBBTextViewImageArrayKey);
}

- (void)yybb_autoHeightWithMaxHeight:(CGFloat)maxHeight
{
    [self yybb_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:nil];
}
// 是否启用自动高度，默认为NO
static bool autoHeight = NO;
- (void)yybb_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(TextViewHeightDidChangedBlock)textViewHeightDidChanged
{
    autoHeight = YES;
    [self yybb_placeholderView];
    self.yybb_maxHeight = maxHeight;
    if (textViewHeightDidChanged) self.yybb_textViewHeightDidChanged = textViewHeightDidChanged;
}

#pragma mark - addImage
/* 添加一张图片 */
- (void)yybb_addImage:(UIImage *)image
{
    [self yybb_addImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)yybb_addImage:(UIImage *)image size:(CGSize)size
{
    [self yybb_insertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)yybb_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index
{
    [self yybb_addImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)yybb_addImage:(UIImage *)image multiple:(CGFloat)multiple
{
    [self yybb_addImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)yybb_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index
{
    [self yybb_addImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)yybb_addImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
    if (image) [self.yybb_imageArray addObject:image];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    CGRect bounds = textAttachment.bounds;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        bounds.size = size;
        textAttachment.bounds = bounds;
    } else if (multiple <= 0) {
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    } else {
        bounds.size = image.size;
        textAttachment.bounds = bounds;
    }
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
    self.attributedText = attributedString;
    [self textViewTextChange];
    [self refreshPlaceholderView];
}


#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self refreshPlaceholderView];
    if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
    
    UITextView *placeholderView = objc_getAssociatedObject(self, YYBBPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.yybb_placeholderView.frame = self.bounds;
        if (self.yybb_maxHeight < self.bounds.size.height) self.yybb_maxHeight = self.bounds.size.height;
        self.yybb_placeholderView.font = self.font;
        self.yybb_placeholderView.textAlignment = self.textAlignment;
        self.yybb_placeholderView.textContainerInset = self.textContainerInset;
        self.yybb_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
}

// 处理文字改变
- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, YYBBPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.yybb_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
    // 如果没有启用自动高度，不执行以下方法
    if (!autoHeight) return;
    if (self.yybb_maxHeight >= self.bounds.size.height) {
        
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        // 如果高度有变化，调用block
        if (currentHeight != self.lastHeight) {
            // 是否可以滚动
            self.scrollEnabled = currentHeight >= self.yybb_maxHeight;
            CGFloat currentTextViewHeight = currentHeight >= self.yybb_maxHeight ? self.yybb_maxHeight : currentHeight;
            // 改变textView的高度
            if (currentTextViewHeight >= self.yybb_minHeight) {
                CGRect frame = self.frame;
                frame.size.height = currentTextViewHeight;
                self.frame = frame;
                // 调用block
                if (self.yybb_textViewHeightDidChanged) self.yybb_textViewHeightDidChanged(currentTextViewHeight);
                // 记录当前高度
                self.lastHeight = currentTextViewHeight;
            }
        }
    }
    
//    if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
    
    // 获取对应属性的值
    UITextView *placeholderView = objc_getAssociatedObject(self, YYBBPlaceholderViewKey);
    
    // 如果有placeholder值
    if (placeholderView) return YES;
    
    return NO;
}

@end
