//
//  HMDetailHeaderLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/10.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDetailModel.h"

#define kDetailContentOffset 20     //文字内容偏移(分割线左间距)
#define kTitleLineSpacing 15        //文字行间距
#define kTopImageHeight 200         //图片高度(若有)
#define kTopImageWidth 200         //图片高度(若有)
#define kSeparatorLineTop 15        //分割线顶部留白
#define kSeparatorLineBottom 20     //分割线底部留白
#define kSeparatorLineHeight 0.5    //分割线高度

@interface HMDetailHeaderLayout : NSObject

@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏
@property (nonatomic, strong) HMDetailModel *detailModel;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithHeaderDetailModel:(HMDetailModel *)detailModel;
//计算布局
- (void)layout;
@end

/**
 文本line位置修改
 将每行文本的高度和位置固定下来, 不受中英文/Emoji字体的 ascent / descent 的影响
 */
@interface HMTextLinePositionModifier : NSObject<YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font;                 //基准字体
@property (nonatomic, assign) CGFloat paddingTop;           //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom;        //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple;   //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end
