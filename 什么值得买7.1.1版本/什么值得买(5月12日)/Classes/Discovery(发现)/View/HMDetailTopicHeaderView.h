//
//  HMDetailTopicHeaderView.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMDetailTopicHeaderLayout.h"

@class HMDetailTopicHeaderView;
@protocol HMDetailTopicHeaderViewDelegate <NSObject>

@optional

- (void)headerViewDidClickOrderBtn:(HMDetailTopicHeaderView *)headerView;

@end

@interface HMDetailTopicHeaderView : UIView

@property (nonatomic, strong) HMDetailTopicHeaderLayout *topicHeaderLayout;

@property (nonatomic, weak) id<HMDetailTopicHeaderViewDelegate> delegate;

@end
