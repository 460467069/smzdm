//
//  HMContentArticle.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMHeadLine.h"
#import "HMLittleBanner.h"

@interface HMContentHeader : NSObject

@property (nonatomic, strong) NSArray<HMHeadLine *> *rows;

@property (nonatomic, strong) NSArray<HMLittleBanner *> *little_banner;

@end




