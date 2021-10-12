//
//  UIView+Badge.h
//  WeiYiMei
//
//  Created by 李叶夫 on 2019/6/23.
//  Copyright © 2019年 liyefu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYBBBadge)

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, strong) NSNumber *badgeOriginX;

@property (nonatomic, strong) NSNumber *badgeOriginY;

@property (nonatomic, strong) NSNumber *showDot;

@end

NS_ASSUME_NONNULL_END
