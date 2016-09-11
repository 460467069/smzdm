//
//  HMDetailTopicHeaderLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDetailTopicModel.h"

#define kDetailTopicBtnTop 15
#define kDetailTopicBtnBottom 15
#define kDetailTopicBtnHeight 25
#define kDetailTopicBtnWidth 60
#define kDetailTopicBtnMargin 15
#define kDetailContentOffset 15


@interface HMDetailTopicHeaderLayout : NSObject

@property (nonatomic, strong) HMDetailTopicModel *detailTopicModel;

@property (nonatomic, strong) YYTextLayout *articleLayout;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat articleHeight;
@property (nonatomic, assign) CGFloat height;


- (instancetype)initWithHeaderDetailModel:(HMDetailTopicModel *)detailTopicModel;
//计算布局
- (void)layout;
@end
