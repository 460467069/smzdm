//
//  ZZDetailBottomBar.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZDetailModel.h"

@class ZZDetailBaseBottomBar;

@protocol ZZDetailBaseBottomBarDelegate <NSObject>

@optional

/** 点击了分享按钮 */
- (void)bottomBarShareBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了喜欢按钮 */
- (void)bottomBarLikeBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"值"按钮 */
- (void)bottomBarWorthyBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"不值"按钮 */
- (void)bottomBarUnworthyBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"买"按钮 */
- (void)bottomBarBuyBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"直达链接"按钮 */
- (void)bottomBarLinkBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"评论"按钮 */
- (void)bottomBarCommentBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

/** 点击了"打赏"按钮 */
- (void)bottomBarDashangBtnDidClick:(ZZDetailBaseBottomBar *)bottomBar;

@end


@interface ZZFirstContainerView : UIView

@end

@interface ZZSecondContainerView : UIView

@end

@interface ZZDetailBaseBottomBar : UIView

@property (nonatomic, weak) id<ZZDetailBaseBottomBarDelegate> delegate;
@property (nonatomic, strong) id detailModel;
@property (nonatomic, assign, readonly) DetailBottomBarStyle style;

+ (instancetype)barWithStyle:(DetailBottomBarStyle)style;

+ (instancetype)barWithDetailModel:(id )detailModel;

@end
