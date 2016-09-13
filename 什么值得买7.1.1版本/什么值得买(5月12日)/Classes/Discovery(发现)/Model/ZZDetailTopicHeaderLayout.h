//
//  ZZDetailTopicHeaderLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/11.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDetailTopicHeaderModel.h"

#define kDetailTopicBtnTop 0
#define kDetailTopicBtnBottom 15
#define kDetailTopicBtnHeight 25
#define kDetailTopicBtnWidth 60
#define kDetailTopicBtnMargin 15
#define kDetailContentOffset 10
#define kDetailTopicImageHeight (kScreenW / 750.0 * 281)


@interface ZZDetailTopicHeaderLayout : NSObject

@property (nonatomic, strong) ZZDetailTopicHeaderModel *detailTopicHeaderModel;

@property (nonatomic, strong) YYTextLayout *articleLayout;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat articleHeight;
@property (nonatomic, assign) CGFloat height;


- (instancetype)initWithHeaderDetailModel:(ZZDetailTopicHeaderModel *)detailTopicHeaderModel;
//计算布局
- (void)layout;
@end
