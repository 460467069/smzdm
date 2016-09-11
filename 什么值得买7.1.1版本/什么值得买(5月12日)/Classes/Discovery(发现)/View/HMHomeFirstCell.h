//
//  HMHomenFirstCell.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HMHomeFirstLayout.h"
#import "HMCycleScrollView.h"

@interface HMTitleView : UIView
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) YYLabel *titleLabel;


@end

@interface HMSeparatorView : UIView
@end

@interface HMFourPicView : UIView
@property (nonatomic, strong) NSArray<UIImageView *> *fourPics;
@end



@interface HMHorizontalScrollItem : UIView

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) YYLabel *contentLabel;
@end


@interface HMHorizontalScrollView : UIScrollView
@property (nonatomic, strong) UIImageView *talentShow;
@property (nonatomic, strong) NSArray<HMHorizontalScrollItem *> *pics;


@end



@protocol HMHomeFirstCellDelegete;
@interface HMHomeFirstCell : UITableViewCell

@property (nonatomic, strong) HMHomeFirstLayout *layout;

@property (nonatomic, strong) HMTitleView *titleView;
@property (nonatomic, strong) HMCycleScrollView *cycleScrollView;
@property (nonatomic, strong) HMFourPicView *fourPicView;
@property (nonatomic, strong) HMHorizontalScrollView *horizontalScrollView;
@property (nonatomic, strong) HMSeparatorView *separatorView;
@property (nonatomic, weak) id<HMHomeFirstCellDelegete > delegate;

@end

@protocol HMHomeFirstCellDelegete <NSObject>

@optional
/** 点击了轮播图片 */
- (void)cellDidClickCycleScrollView:(HMHomeFirstCell *)cell atIndex:(NSInteger)index;
/** 点击了四张图片中的一张 */
- (void)cellDidClickOneOfFourPic:(HMHomeFirstCell *)cell;
/** 点击了原创Item */
- (void)cellDidClickYuanChuangItem:(HMHomeFirstCell *)cell atIndex:(NSInteger)index;
/** 点击了福利Item */
- (void)cellDidClickFuliItem:(HMHomeFirstCell *)cell atIndex:(NSInteger)index;
@end


