//
//  ZZDetailTopicHeaderView.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZDetailTopicHeaderLayout.h"

static NSString *const kOrderByHot = @"byhot";
static NSString *const kOrderByTime = @"bytime";

typedef NS_ENUM(NSUInteger, ZZDetailTopicHeaderViewOrderStyle) {
    ZZDetailTopicHeaderViewOrderStyleByHot,
    ZZDetailTopicHeaderViewOrderStyleByTime,
};

@class ZZDetailTopicHeaderView;
@protocol ZZDetailTopicHeaderViewDelegate <NSObject>

@optional

- (void)headerViewDidClickOrderBtn:(ZZDetailTopicHeaderView *)headerView orderStr:(NSString *)orderStr;

@end

@interface ZZDetailTopicHeaderView : UIView

@property (nonatomic, strong) ZZDetailTopicHeaderLayout *detailTopicHeaderLayout;

@property (nonatomic, weak) id<ZZDetailTopicHeaderViewDelegate> delegate;

@property (nonatomic, assign)ZZDetailTopicHeaderViewOrderStyle orderStyle;

- (instancetype)initWithOrderStyle:(ZZDetailTopicHeaderViewOrderStyle)orderStyle;

@end
