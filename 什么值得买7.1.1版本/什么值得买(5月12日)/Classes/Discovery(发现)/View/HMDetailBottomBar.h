//
//  HMDetailBottomBar.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DetailBottomBarStyle) {
    DetailBottomBarStyleHaoWu,
    DetailBottomBarStyleYuanChuang,
    DetailBottomBarStyleHaiTao,
    DetailBottomBarStyleYouHui = DetailBottomBarStyleHaiTao,
    DetailBottomBarStyleHuaTi,
    DetailBottomBarStyleZiXun,
    DetailBottomBarStylePingCe = DetailBottomBarStyleZiXun,
};

@interface HMDetailBottomBar : UIView

+ (instancetype)barWithStyle:(DetailBottomBarStyle)style;

@end
