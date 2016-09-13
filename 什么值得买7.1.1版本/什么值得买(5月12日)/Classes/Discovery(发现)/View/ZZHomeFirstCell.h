//
//  ZZHomenFirstCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ZZHomeFirstLayout.h"
#import "ZZCycleScrollView.h"

@interface ZZTitleView : UIView
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) YYLabel *titleLabel;


@end

@interface ZZSeparatorView : UIView
@end

@interface ZZFourPicView : UIView
@property (nonatomic, strong) NSArray<UIImageView *> *fourPics;
@end



@interface ZZHorizontalScrollItem : UIView

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) YYLabel *contentLabel;
@end


@interface ZZHorizontalScrollView : UIScrollView
@property (nonatomic, strong) UIImageView *talentShow;
@property (nonatomic, strong) NSArray<ZZHorizontalScrollItem *> *pics;


@end



@protocol ZZHomeFirstCellDelegete;
@interface ZZHomeFirstCell : UITableViewCell

@property (nonatomic, strong) ZZHomeFirstLayout *layout;

@property (nonatomic, strong) ZZTitleView *titleView;
@property (nonatomic, strong) ZZCycleScrollView *cycleScrollView;
@property (nonatomic, strong) ZZFourPicView *fourPicView;
@property (nonatomic, strong) ZZHorizontalScrollView *horizontalScrollView;
@property (nonatomic, strong) ZZSeparatorView *separatorView;
@property (nonatomic, weak) id<ZZHomeFirstCellDelegete > delegate;

@end

@protocol ZZHomeFirstCellDelegete <NSObject>

@optional
/** 点击了轮播图片 */
- (void)cellDidClickCycleScrollView:(ZZHomeFirstCell *)cell atIndex:(NSInteger)index;
/** 点击了四张图片中的一张 */
- (void)cellDidClickOneOfFourPic:(ZZHomeFirstCell *)cell;
/** 点击了原创Item */
- (void)cellDidClickYuanChuangItem:(ZZHomeFirstCell *)cell atIndex:(NSInteger)index;
/** 点击了福利Item */
- (void)cellDidClickFuliItem:(ZZHomeFirstCell *)cell atIndex:(NSInteger)index;
@end


