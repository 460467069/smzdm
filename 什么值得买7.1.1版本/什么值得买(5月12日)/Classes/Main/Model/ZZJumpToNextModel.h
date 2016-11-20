//
//  ZZJumpToNextModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/20.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  二级控制器跳转模型 基本思路:根据linkType获取对应模型, 便可创建相应控制器

#import <Foundation/Foundation.h>

@interface ZZJumpToNextModel : NSObject

@property (nonatomic, assign) NSInteger channelID;
@property (nonatomic, copy) NSString *linkType;
@property (nonatomic, copy) NSString *destionationController;


+ (instancetype)modelWithLinkType:(NSString *)linkType;

@end
