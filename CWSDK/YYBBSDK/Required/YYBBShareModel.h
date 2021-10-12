//
//  YYBBShareModel.h
//  YYBBSDK
//
//  Created by Kris Liu on 9/23/17.
//  Copyright © 2017 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBBBaseModel.h"

typedef NS_ENUM(NSUInteger, YYBBShareType) {
    YYBBShareTypeWechatSession         = 22,        // 微信好友
    YYBBShareTypeWechatTimeline        = 23,        // 微信朋友圈
    YYBBShareTypeQQFriend              = 24,        // QQ好友
    YYBBShareTypeSaveToLocal           = 88,        // 保存到本地
    YYBBShareTypeEmail                 = 10000,     // 邮箱
};

@interface YYBBShareModel : YYBBBaseModel

@property (nonatomic, assign) YYBBShareType shareType;
@property (nonatomic, strong) NSString * shareIcon;
@property (nonatomic, strong) NSString * shareIconHighlighted;
@property (nonatomic, strong) NSString * title;

@end
