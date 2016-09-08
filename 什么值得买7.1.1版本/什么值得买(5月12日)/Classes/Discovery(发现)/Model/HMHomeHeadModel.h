//
//  HMHomeHeadModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMTitleBannelOption.h"
#import "HMHeadLine.h"
#import "HMLittleBanner.h"


@interface HMHomeHeadModel : NSObject
@property (nonatomic, strong) NSArray<HMHeadLine *> *rows;
@property (nonatomic, strong) NSArray<HMLittleBanner *> *littleBanner;
@property (nonatomic, strong) NSArray<HMHeadLine *> *headlines;
@property (nonatomic, strong) HMTitleBannelOption *littleBannerOptions;

@end
