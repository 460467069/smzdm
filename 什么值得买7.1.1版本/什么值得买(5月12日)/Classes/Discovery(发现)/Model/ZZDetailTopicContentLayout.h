//
//  ZZDetailTopicContentLayout.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/13.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDetailTopicModel.h"

@interface ZZDetailTopicContentLayout : NSObject
/** 头像高度 */
@property (nonatomic, assign) CGFloat avatarViewHeight;

@property (nonatomic, strong) YYTextLayout *userInfoLayout;
@property (nonatomic, assign) CGFloat userInfoHeight;
/** 标题 和 价格 */
@property (nonatomic, strong) YYTextLayout *titleLayout;
/** 推荐原因, 包括副标题 */
@property (nonatomic, strong) YYTextLayout *reasonLayout;
/** 额外信息, 如评价 + 使用时长 */
@property (nonatomic, strong) YYTextLayout *extraInfoLayout;
/** 点赞 */
@property (nonatomic, strong) YYTextLayout *supportLayout;


@property (nonatomic, strong) ZZDetailTopicModel *detailTopicModel;
- (instancetype)initWithContentDetailModel:(ZZDetailTopicModel *)detailTopicModel;
//计算布局
- (void)layout;

@end
