//
//  ZZHomeHeadModel.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZTitleBannelOption.h"
#import "ZZHeadLine.h"
#import "ZZLittleBanner.h"
#import "ZZBaseRequest.h"

@interface ZZHomeBannerRequest : ZZBaseRequest

@property (nonatomic, copy) NSString *type;

@end

@interface ZZHomeHeadModel : NSObject
@property (nonatomic, strong) NSArray<ZZHeadLine *> *rows;
@property (nonatomic, strong) NSArray<ZZLittleBanner *> *littleBanner;
@property (nonatomic, strong) NSArray<ZZHeadLine *> *headlines;
@property (nonatomic, strong) ZZTitleBannelOption *littleBannerOptions;

@end
