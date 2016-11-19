//
//  ZZDetailTopicContentLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDetailTopicModel.h"

#define kDetailTopicMarginX  15                    /**< 整个内容, 左右间距 */
#define kDetailTopicMarginY  15                    /**< 整个内容, 上下间距 */
#define kDetailTopicContentOffsetX 15           /**< 内容偏移, 左右 */
#define kDetailTopicContentOffsetY 15           /**< 内容偏移, 上下 */
#define kDetailTopicContentTopMargin 15         /**< 内容顶部留白 */
#define kDetailTopicContentAvartarWH 48         /**< 头像宽高 */
#define kDetailTopicUserInfoWidth 180           /**< 用户信息宽 */
#define kDetailTopicUserInfoHeight 50           /**< 用户信息高 */
#define kDetailTopicUserInfoMarginX 8           /**< 用户信息左右留白 */
#define kDetailTopicUserInfoMarginY 8           /**< 用户信息上下留白 */
#define kDetailTopicProPicWH (kScreenW / 750.0 * 200)                /**< 配图大小 */
#define kDetailTopicTitleLeftMargin  30         /**< 标题左间距 */
#define kDetailTopicDescTopMargin 15            /**< 文字描述顶部留白 */
#define kDetailTopicDescHeight 120              /**< 文字描述高度 */
#define kDetailTopicDescWidth (kScreenW - 2 * kDetailContentOffset) /**< 文字描述宽 */
#define kDetailTopicUseTimeHeight 50            /**< 使用时长那栏高度 */
#define kDetailTopicUseTimeWidth 120            /**< 使用时长那栏高度 */
#define kDetailTopicUseTimeY 15                 /**< 使用时长上下留白 */
#define kDetailTopicSmallBtnWidth   50          /**< 小按钮宽 */
#define kDetailTopicSmallBtnMargin   15          /**< 按钮间间距 */
#define kDetailTopicStarMargin 5                /** 星星之间的间距 */
#define kDetailTopicStarWidth ([UIImage imageNamed:@"star_red"].size.width)                /** 星星宽 */
#define kDetailTopicStarHeight ([UIImage imageNamed:@"star_red"].size.height)               /** 星星高 */
#define kDetailTopicTotalStars 5                /** 星星总数 */
#define kDetailTopicStarLabelWidth (kDetailTopicStarWidth + kDetailTopicStarMargin) * kDetailTopicTotalStars

@interface ZZDetailTopicContentLayout : NSObject
/** 头像高度 */
@property (nonatomic, assign) CGFloat avatarViewHeight;

@property (nonatomic, strong) YYTextLayout *userInfoLayout;
@property (nonatomic, assign) CGFloat userInfoHeight;

@property (nonatomic, strong) YYTextLayout *starLayout;
/** 标题 和 价格 */
@property (nonatomic, strong) YYTextLayout *titleLayout;

/** 推荐原因, 副标题 + 文本内容 */
@property (nonatomic, strong) YYTextLayout *descriptionLayout;
@property (nonatomic, assign) CGFloat descriptionHeight;
/** 用户上传图片数 */
@property (nonatomic, strong) YYTextLayout *picCountLayout;
/** 评论数 */
@property (nonatomic, strong) YYTextLayout *commentCountLayout;
/** 使用时长 */
@property (nonatomic, strong) YYTextLayout *useTimeLayout;
@property (nonatomic, assign) CGFloat useTimeHeight;

@property (nonatomic, strong) YYTextLayout *supportLayout;

@property (nonatomic, strong) ZZDetailTopicModel *detailTopicModel;
@property (nonatomic, assign) CGFloat height;
- (instancetype)initWithContentDetailModel:(ZZDetailTopicModel *)detailTopicModel;
//计算布局
- (void)layout;

@end
