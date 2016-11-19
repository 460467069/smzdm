//
//  ZZContentArticle.h
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZHeadLine.h"
#import "ZZLittleBanner.h"

@interface ZZContentHeader : NSObject

@property (nonatomic, strong) NSArray<ZZHeadLine *> *rows;

@property (nonatomic, strong) NSArray<ZZLittleBanner *> *little_banner;

@end




